module.exports = {
  plugins: [
    require('tailwindcss'),
    require('autoprefixer'),
    require('postcss-px-to-viewport-8-plugin')({
      viewportWidth: 1920, // 设计稿的视口宽度
      unitPrecision: 5,
      viewportUnit: 'vw',
      selectorBlackList: ['ignore'], // 过滤不转换的 class
      minPixelValue: 1,
      mediaQuery: false,
    }),
  ],
};