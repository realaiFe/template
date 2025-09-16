const { REACT_APP_ENV = 'dev' } = process.env;

const proxy = {
  dev: {
    '/api': {
      target: 'http://10.1.10.36:10600/',
      changeOrigin: true,
      // pathRewrite: { '^/api': '/api' },
    },
  },
};
export default proxy[REACT_APP_ENV];