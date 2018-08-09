/**
 * 布局接口
 */

'use strict';

const qyCloud = global[global.app];
const config = qyCloud.config;
const http = new qyCloud.Http(config.api);

const _ = require('lodash');

const Model = qyCloud.Model;

const user = require('../model/user');


// 皮肤数据
const _skinLists = [
    {
        name: '深邃黑',
        color: 'black'
    },
    {
        name: '梦幻紫',
        color: 'purple'
    },
    {
        name: '星际蓝',
        color: 'blue'
    },
    {
        name: '迎新春',
        color: 'year'
    }
];

class Layout extends Model {
    _infoExtractor(info) {
        let theme = 'blue';

        // 有托管时为被托管人的id，没有时按自己的id
        let trusterId = info.userId;

        // 判断有无托管，有托管时按被托管人的皮肤显示
        if (info.truster) {
            theme = info.truster_theme;
            trusterId = info.truster;
        } else {
            theme = info.theme;
            trusterId = info.userId;
        }

        return {
            name: info.realName || '',
            theme: theme || 'blue',
            avatar: info.avatar,
            userId: info.userId,
            trusterId: trusterId,
            isSysRoot: info.userType === '7',
            entId: info.entId,
            showTrusteeship: info.truster
        };
    }

    // 用户信息
    _info(req) {
        return user.info(req).then(result => _.assign({}, this._infoExtractor(result)));
    }

    // 侧栏菜单接口
    _app(req) {
        return http.get(...this._appendCookie('/api2/appcenter/applist/id', req)).then(result => {
            let app = {};

            if (result.status === 200) {
                let data = result.result;

                app = data;
            }

            return app;
        });
    }

    // 多企业/多用户
    _truster(req) {
        return http.get(...this._appendCookie('/api2/user/trusters', req)).then(result => {
            let truster = {};

            if (result.status === 200) {
                let data = result.result;

                truster = data;
            }

            return truster;
        });
    }

    // 待办应用
    _todo(req) {
        return http.get(...this._appendCookie('/api2/appcenter/applist/todocount', req)).then(result => {
            let todo = {};

            if (result.status === 200) {
                let data = result.result;

                todo = data;
            }

            return todo;
        });
    }

    // 常用应用
    _frequentlyUsed(req) {
        return http.get(...this._appendCookie('/api2/appcenter/applist/commonmenu/6', req)).then(result => {
            let frequentlyUsed = {};

            if (result.status === 200) {
                let data = result.result;

                frequentlyUsed = data;
            }

            return frequentlyUsed;
        });
    }

    //  运营通告
    _inform(req) {
        return http.get(...this._appendCookie('/api2/home/message/newest', req)).then(result => {
            let inform = {};

            if (result.status === 200) {
                let data = result.result;

                // 是否显示运用通告和查看详情链接
                let informData = {
                    informShow: false,
                    addUrl: false,
                    countDown: false,
                };

                // 判断运营通告是否有值
                if (!_.isEmpty(data)) {
                    let publish = data.publish_time || '1970-01-01';
                    let publishTime = publish.split(' ')[0].replace(/-/g, '');
                    let detailHref = '/news/show/' + publishTime + '/' + data.id;

                    let informShow = false;
                    let countDown = false;
                    let startTime = new Date(data.start).getTime();
                    let finishTime = new Date(data.finish).getTime();
                    let nowTime = new Date().getTime();
                    let openCountdown = data.extend.openCountdown;
                    let isShow = finishTime - nowTime < 300000 ? true : false;
                    let countNum = Math.ceil((finishTime - nowTime) / 60000);

                    if (nowTime > startTime && nowTime < finishTime) {
                        informShow = true;
                    } else {
                        informShow = false;
                    }

                    if (openCountdown * 1 === 1 && countNum <= 5) {
                        countDown = true;

                    } else {
                        countDown = false;
                    }

                    let addUrl = data.type * 1 === 2 ? true : false;

                    inform = data;

                    informData = {
                        detailHref,
                        informShow,
                        addUrl,
                        countDown,
                        openCountdown,
                        isShow,
                        countNum
                    };
                }

                _.assign(inform, informData);
            }

            return inform;
        });
    }

    // 系统应用
    _system(req) {
        return http.get(...this._appendCookie('/api2/appcenter/applist/system', req)).then(result => {
            let system = {};

            if (result.status === 200) {
                let data = result.result;

                system = data;
            }

            return system;
        });
    }

    // 二级菜单页header左侧图标和文字及aside列表
    _submenu() {
        return Promise.resolve({});
    }

    // 用户未读信息提醒
    _notice(req) {
        return http.get(...this._appendCookie('/api2/notice/all', req)).then(result => {
            let notice = {};

            if (result.status === 200) {
                let data = result.result.notice;

                data.showNotice = data.count === 0 ? false : true;

                if (data.count > 99) {
                    data.count = '99+';
                }

                notice = data;
            }

            return notice;
        });
    }

    // 搜索历史记录
    _history(req) {
        return http.get(...this._appendCookie('/api2/search/suggestion', req)).then(result => {
            let history = {};

            if (result.status === 200) {
                let data = result.result;

                data.showHistory = data.data.length ? true : false;

                history = data;
            }

            return history;
        });
    }

    // layout的header的logo
    _logo(req) {
        return http.get(...this._appendCookie('/api2/home/page', req)).then(result => {
            let logo = {};

            if (result.status === 200) {
                let data = result.result;

                logo = data;
            }

            return logo;
        });
    }

    interface(req) {
        let apis = [
            this._info(req),
            this._app(req),
            this._truster(req),
            this._todo(req),
            this._frequentlyUsed(req),
            this._inform(req),
            this._system(req),
            this._submenu(),
            this._notice(req),
            this._history(req),
            this._logo(req)
        ];

        return Promise.all(apis).then(results => {
            let header = results[0];
            let side = {
                menus: results[1]
            };

            let truster = results[2]; // 多用户多企业

            // 扩展Header数据
            _.assign(header, {
                skins: _.map(_skinLists, skin => {
                    let mapSkin = {
                        name: skin.name,
                        color: skin.color
                    };
                    if (skin.color === header.theme) {
                        mapSkin.checked = true;
                    }
                    return mapSkin;
                }),
                users: _.size(truster.userList) > 1 ? truster.userList : false,
                ents: _.size(truster.entList) > 1 ? truster.entList : false,
                inform: results[5],
                system: results[6],
                submenu: results[7],
                notice: results[8],
                searchHistory: results[9],
                logo: results[10]
            });

            // 是否显示待办应用
            let todo = results[3];

            _.assign(todo, {
                showTodo: _.size(todo) > 0 ? true : false,
            });

            // 扩展Side数据
            _.assign(side, {
                todo: todo,
                often: results[4],
                submenu: results[7],
                theme: header.theme,
                isSysRoot: header.isSysRoot
            });

            return {
                header,
                side
            };
        });
    }
}

module.exports = new Layout();
