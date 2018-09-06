/**
 * 通用接口
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/3/31
 */

'use strict';

const qyCloud = global[global.app];
const config = qyCloud.config;
const http = new qyCloud.Http(config.api);

const Model = qyCloud.Model;

class Common extends Model {
    setTheme(req, opt) {
        return http.put(...this._appendCookie('/api2/user/theme', req, {
            params: opt
        }));
    }

    switchUser(req, opt) {
        return http.get(...this._appendCookie('/my/switchUser', req, opt));
    }

    switchEnterprise(req, opt) {
        return http.get(...this._appendCookie('/my/switchEnt', req, opt));
    }

    clearOneHistory(req, opt) {
        return http.get(...this._appendCookie('/api2/search/suggestion/hide', req, opt));
    }

    clearAllHistory(req, opt) {
        return http.get(...this._appendCookie('/api2/search/suggestion/hideAll', req, opt));
    }

    addHistory(req, opt) {
        return http.get(...this._appendCookie('/api2/search/suggestion/feature', req, opt));
    }

    customer(req, opt) {
        return http.get(...this._appendCookie('/api2/enterprise/customer', req, opt));
    }
}

module.exports = new Common();
