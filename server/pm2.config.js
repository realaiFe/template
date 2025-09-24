module.exports = {
  apps: [{
    name: "onemeta-fe-server",
    script: "./index.js",
    env: {
      NODE_ENV: "production",
    },
    "error_file"  : "./err.log",
    "out_file"    : "./out.log",
    "pid_file"    : "./pid.pid",
    "merge_logs"  : true,
    "log_date_format" : "YYYY-MM-DD HH:mm:ss.SSS"
  }]
}
