var path              = require('path');
var webpack           = require('webpack');
var merge             = require('webpack-merge');
var HtmlWebpackPlugin = require('html-webpack-plugin');
var autoprefixer      = require('autoprefixer');
var ExtractTextPlugin = require('extract-text-webpack-plugin');
var CopyWebpackPlugin = require('copy-webpack-plugin');

var TARGET_ENV = process.env.npm_lifecycle_event === 'build' ? 'production' : 'development';

var commonConfig = {
  output: {
    path: path.resolve(__dirname, 'dist/'),
    filename: '[hash].js',
  },
  resolve: {
    modulesDirectories: ['node_modules'],
    extensions:         ['', '.js', '.elm']
  },
  module: {
    noParse: /\.elm$/,
    loaders: [
      {
        test: /\.(eot|ttf|woff|woff2|svg)$/,
        loader: 'file-loader'
      }
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: 'src/index.html',
      inject:   'body',
      filename: 'index.html'
    })
  ],
  postcss: [autoprefixer({browsers: ['last 2 versions']})],
}

if (TARGET_ENV === 'development') {
  module.exports = merge(commonConfig, {
    entry: [
      'webpack-dev-server/client?http://localhost:8080',
      path.join(__dirname, 'src/index.js')
    ],
    devServer: {
      inline:   true,
      progress: true
    },
    module: {
      loaders: [
        {
          test:    /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          loader:  'elm-hot!elm-webpack?verbose=true&warn=true'
        },
        {
          test: /\.(css|scss)$/,
          loaders: [
            'style-loader',
            'css-loader',
            'postcss-loader',
            'sass-loader'
          ]
        }
      ]
    }
  });
}

if (TARGET_ENV === 'production') {
  module.exports = merge(commonConfig, {
    entry: path.join(__dirname, 'src/index.js'),
    module: {
      loaders: [
        {
          test:    /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          loader:  'elm-webpack'
        },
        {
          test: /\.(css|scss)$/,
          loader: ExtractTextPlugin.extract('style-loader', [
            'css-loader',
            'postcss-loader',
            'sass-loader'
          ])
        }
      ]
    },
    plugins: [
      new CopyWebpackPlugin([
        {
          from: 'src/img/',
          to:   'img/'
        },
        {
          from: 'src/favicon.ico'
        },
      ]),

      new webpack.optimize.OccurenceOrderPlugin(),
      new ExtractTextPlugin('./[hash].css', {allChunks: true}),
      new webpack.optimize.UglifyJsPlugin({
        minimize:   true,
        compressor: {warnings: false},
        mangle:  true,
      })
    ]
  });
}
