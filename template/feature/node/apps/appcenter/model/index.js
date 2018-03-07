/**
 * appcenter model
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/3/9
 */

'use strict';

const qyCloud = global[global.app];
const config = qyCloud.config;
const http = new qyCloud.Http(config.api);

const Model = qyCloud.Model;

const _ = require('lodash');

const user = require('../../../doraemon/model/user');

class App extends Model {

    // 应用通知
    _notice(req) {
        return http.get(...this._appendCookie('/api2/notice/all', req, {
            url: '/appcenter'
        })).then(result => {
            let notice = {};

            if (result.status === 200) {
                notice = result.result.menu.count;
            }

            return notice;
        });
    }

    // 应用列表
    _app(req) {
        return http.get(...this._appendCookie('/api2/appcenter/applist/id', req)).then(result => {
            let app = {};

            if (result.status === 200) {
                app = result.result;
            }

            return app;
        });
    }

    /**
     * 应用列表
     */
    apps(req) {
        let apis = [
            this._notice(req),
            this._app(req),
            user.info(req)
        ];

        return Promise.all(apis).then(result => {
            let notice = result[0];

            let info = result[2];

            let _apps = _.map(result[1], app => {
                let main = _.pick(app, ['name', 'description', 'icon_name', 'id', 'order']);

                main.count = notice[main.id] || ''; // 获取主app的消息数目

                // 二级菜单与三级菜单合并，取其前6项
                main.subs = [];
                _.map(app.children, child => {
                    if (!child.link) {
                        _.map(child.children, item => {
                            main.subs.push(_.pick(item, ['link', 'name']));
                        });
                    } else {
                        main.subs.push(_.pick(child, ['link', 'name']));
                    }
                });
                main.subs = main.subs.slice(0, 6);

                return main;
            });

            return {
                apps: _apps,
                admin: info.userType === 6 // 管理员，可添加／拖动app
            };
        });
    }

    /**
     * 新建/编辑应用
     */
    setapp(req, opt) {
        let param = _.assign({
            category: 0,
            level: 1,
            order: 0
        }, opt);

        return http.post(...this._appendCookie('/api2/app/admin', req, {
            params: param
        })).then(result => {
            if (result.status === 200) {
                return result.result;
            }

            return result;
        });
    }

    /**
     * 应用拖拽
     */
    drag(req, opt) {
        return http.put(...this._appendCookie('/api2/app/admin/drag', req, {
            params: opt
        }));
    }

}

module.exports = new App();
