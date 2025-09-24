const path = require('path')
const Koa = require('koa');
const send = require('koa-send');
const koaStatic = require('koa-static');
// const proxy = require('koa-proxies');
// const HttpProxy = require('http-proxy');
// const base64 = require('base-64')
// const utf8 = require('utf8')
// const axios = require('axios');
// const {stringify} = require("querystring");
const app = new Koa();

const port = process.env.PORT || 3000;
const staticPath = path.join(__dirname, './dist');
// log(`MODE: APP_IN_PUBLIC ${process.env.APP_IN_PUBLIC === 'TRUE'}`)

//log
app.use(async (ctx, next) => {
  try {
    await next();
    const contentType = ctx.res.getHeader('content-type');
    if (contentType && String(contentType).includes('text/html')) {
      ctx.set('Cache-Control', "private, no-store, no-cache, must-revalidate, proxy-revalidate");
    }
    if (!/\.\w+$/.test(ctx.path)) {
      log(`${ctx.method} ${ctx.status} ${ctx.url}`)
    }
  } catch (e) {
    if (e && e.statusCode) {
      log(`${ctx.method} ${e.statusCode} ${ctx.url}`)
    } else {
      console.error(e)
    }
  }
})


app.use(koaStatic(staticPath, {maxAge: 7 * 24 * 3600 * 1000}));

app.use(async (ctx) => {
  ctx.set('Cache-Control', "private, no-store, no-cache, must-revalidate, proxy-revalidate");
  await send(ctx, 'index.html', {root: staticPath});
})

const server = app.listen(port, () => {
  log(`server start: http://localhost:${port}`)
})

//
//
// // 代理图片
// const IMG_PATH = '/_img'
// app.use(proxy(IMG_PATH, {
//   target: 'https://img.momocdn.com',
//   rewrite: (path) => path.replace(IMG_PATH, ''),
//   changeOrigin: true,
//   headers: {referer: ''}
// }))
//
// // argos代理 报警、推送相关
// const ARGOS_PATH = '/_PROXY_ARGOS';
// app.use(proxy(ARGOS_PATH, {
//   target: 'http://argos.vip.p1staff.com',
//   rewrite: (path) => path.replace(ARGOS_PATH + '/thor', ''),
//   changeOrigin: true,
// }))

// server.on("upgrade", (req, socket, head) => {
//   const target = getWsProxy(req)
//   console.log(req.url, req.headers.host);
//   log('WebSocket Proxy => ' + target)
//   proxy.proxy.ws(req, socket, head, { changeOrigin: true, ws: true, logs: true, target}, err => {
//     console.error(err);
//   });
// });

function currentDate() {
  const date = new Date();
  return `${date.getFullYear()}-${pS(date.getMonth() + 1)}-${pS(date.getDate())} ${pS(date.getHours())}:${pS(date.getMinutes())}:${pS(date.getSeconds())},${pS(date.getMilliseconds(), 3)}`
}

function pS(v, n = 2) {
  return String(v).padStart(n, '0');
}

function log(s) {
  console.log(`${currentDate()} INFO onemeta-fe-prod: ${s}`)
}

