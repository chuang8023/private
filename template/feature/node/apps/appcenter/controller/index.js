/**
 * appcenter controller
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/3/9
 */

'use strict';

// const _ = require('lodash');

const model = require('../model/index');

// 应用中心首页
const index = (req, res) => {

    return res.display('index', {
        title: '应用中心',
        module: 'appcenter',
        page: 'index'
    });
};

// 应用列表
const apps = (req, res, next) => {
    model.apps(req).then(data => {
        return res.send(data);
    }).catch(next);
};

// 新建/编辑应用
const setapp = (req, res, next) => {
    model.setapp(req, req.body).then(data => {
        return res.send(data);
    }).catch(next);
};

// 应用拖拽
const drag = (req, res, next) => {
    model.drag(req, req.body).then(data => {
        return res.send(data);
    }).catch(next);
};

module.exports = {
    index,
    apps,
    setapp,
    drag
};
