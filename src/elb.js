/**
* @fileOverview aws-sdk code that gets us AWS ELB status information.
*/

var async = require('async');

var exports = module.exports = {};

const REGION = 'eu-west-1';
const ELB_READ_ONLY_ACCESS_KEY = 'AKIAJKDKBCRJWXK6SU7A';
const ELB_READ_ONLY_SECRET_KEY = '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';
const VELODROME_TESTING_LB = 'velodrome-testing-api-lb';

AWS.config.update({
  accessKeyId: ELB_READ_ONLY_ACCESS_KEY,
  secretAccessKey: ELB_READ_ONLY_SECRET_KEY,
  region: REGION
});

var ELB = new AWS.ELB();

/**
 * Retrieves a single LoadBalancer object.
 * @param {function} callback - Next task in async.waterfall.
*/
function getLoadBalancer(callback) {
  var lbs = [VELODROME_TESTING_LB];
  var params = {LoadBalancerNames: lbs};
  return ELB.describeLoadBalancers(params).send(callback);
};

/**
 * Gets all Instance objects for LoadBalancer 'lb'.
 * @param {string}   lb       - LoadBalancer object.
 * @param {function} callback - Next task in async.waterfall.
*/
function getInstances(lb, callback) {
  var lb = lb.LoadBalancerDescriptions[0]
  var instanceIds = lb.Instances.map(function(i) {
    return i.InstanceId;
  });
  return callback(null, instanceIds, lb.LoadBalancerName);
};

/**
 * Get Instance health status.
 * @param {array}    ids      - Instance identifiers.
 * @param {string}   lbName   - Name of LoadBalancer which contains instances listed in 'ids'.
 * @param {function} callback - Next task in async.waterfall.
*/
function getInstancesHealth(ids, lbName, callback) {
  var buildIds = function(acc, id) {
    acc.push({InstanceId: id}); return acc
  };
  var params = {LoadBalancerName: lbName, Instances: ids.reduce(buildIds, [])};
  ELB.describeInstanceHealth(params).send(callback);
};

/**
 * Parse health status response.
 * @param {object}   instancesHealth - Instances health status.
 * @param {function} callback        - Next task in async.waterfall.
*/
function parseInstancesHealth(instancesHealth, callback) {
  var parsed = {}; var states = instancesHealth.InstanceStates;
  states.every(function(state) {
    return parsed[state.InstanceId] = {
      state: state.State,
      reasonCode: state.ReasonCode,
      description: state.Description
    };
  });
  return callback(null, parsed);
};

/**
 * Handle error/result and FFI to Elm code.
 * @param {object} err  - Errors, if any, from async.waterfall.
 * @param {object} data - Successful result from async.waterfall.
*/
function handleResult(err, data) {
  console.log(data); // TODO
};

exports.ELBStatus = function() {
  var tasks = [getLoadBalancer, getInstances, getInstancesHealth, parseInstancesHealth];
  async.waterfall(tasks, handleResult);
}
