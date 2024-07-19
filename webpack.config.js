const TerserPlugin = require('terser-webpack-plugin');

module.exports = function (options, webpack) {
  const lazyImports = [];

  return {
    ...options,
    entry: ['./src/lambda.ts'],
    externals: [
      // ...options.externals,
    ],
    output: {
      ...options.output,
      libraryTarget: 'commonjs2',
    },
    plugins: [
      ...options.plugins,
      new webpack.IgnorePlugin({
        checkResource(resource) {
          // Ignoring non-essential modules for Lambda deployment
          return lazyImports.includes(resource);
        },
      }),
    ],

    optimization: {
      minimize: true, // Enable minification
      minimizer: [
        new TerserPlugin({
          // TerserPlugin options here
          // For example, to keep class names and function names:
          terserOptions: {
            keep_classnames: true,
            keep_fnames: true,
          },
        }),
      ],
    },
  };
};
