/**
 * 路由分发
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/2/15
 */

'use strict';

module.exports = app => {
    // 公共服务
    app.use('/common', require('./doraemon/router'));

    // 业务模块
    app.use('/appcenter', require('./apps/appcenter')); // 应用中心

    app.use('/organization', require('./apps/organization')); // 通讯录
};
