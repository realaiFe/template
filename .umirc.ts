import { defineConfig } from '@umijs/max';
import proxy from './config/proxy';

export default defineConfig({
  antd: {},
  access: {},
  model: {},
  initialState: {},
  request: {},
  layout: {
    title: '@umijs/max',
  },
  proxy,
  routes: [
    {
      path: '/',
      redirect: '/home',
    },
    {
      name: '首页',
      path: '/home',
      component: './Home',
      hideInMenu: true,
      layout: false,
    },
  ],
  npmClient: 'pnpm',
  tailwindcss: {},
  mock: false,
});