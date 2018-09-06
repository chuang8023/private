/**
 * 用户信息相关接口
 */

'use strict';

const qyCloud = global[global.app];
const config = qyCloud.config;
const http = new qyCloud.Http(config.api);

const Model = qyCloud.Model; // model base

// const mc = require('memory-cache');

class User extends Model {
    info(req) {

        // 减少重复请求
        // let _cachedInfo = mc.get(req.cookies.PHPSESSID);

        if (req.user) {
            return Promise.resolve(req.user);
        }

        return http.get(...this._appendCookie('/api2/user/info', req)).then(result => {
            let info = {};

            if (result.status === 200) {
                info = result.result;

                info.theme = info.theme || 'blue'; // 默认颜色

                req.user = info; // 用户信息打入req.app

                // 缓存用户信息，key为Sessionid，时间为10min
                // mc.put(req.cookies.PHPSESSID, JSON.stringify(info), 10 * 60 * 1000);
            } else if (result.status === 401) {

                //  未登陆状态直接返回提示信息交由controller处理
                info = result;
            }

            return info;
        });
    }
}

module.exports = new User();
