/**
 * 带布局的渲染
 * @desc: 区分于res.render, res.display会请求公共接口，渲染布局
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/2/28
 */

'use strict';

const _ = require('lodash');

const layout = require('../model/layout');

const config = global[global.app].config;

// 判断是否显示侧菜单等
const _menuControl = (url) => {
    let header = false;
    let side = false;

    if (url.indexOf('/app/!') > -1) {
        header = true;
    }

    return {
        header,
        side
    };
};

module.exports = (req, res, next) => {
    let url = req.url;

    res.display = (view, options, cb) => {
        layout.interface(req).then(data => {
            let {header, side} = _menuControl(url);

            // 对头部和侧栏加子菜单控制
            data.header.subShow = header;
            data.side.subShow = side;

            // title待办提醒
            let count = data.header.notice.count;

            if (count) {
                options.title = `(${count > 99 ? '99+' : count})${options.title}`;
            }

            // notice：数据经过安全处理，接口未返回预期值时则不渲染对应块
            res.render(view, _.assign(options, data, {
                title: options.title + (config.name ? ` - ${config.name}` : '')
            }), cb);
        }).catch(next);
    };

    next();
};
