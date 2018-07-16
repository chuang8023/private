/**
 * 资料页 controller
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/8/4
 */

'use strict';

// const _ = require('lodash');

const model = require('../model/ucenter');

// 个人资料页页面渲染
const index = (req, res) => {

    return res.display('ucenter', {
        title: '用户详细资料',
        module: 'organization',
        page: 'ucenter'
    });
};

// 基本信息
const info = (req, res, next) => {
    model.info(req).then(data => {
        return res.send(data);
    }).catch(next);
};

// 互动沟通
const interTalk = (req, res, next) => {
    let {id} = req.query;

    model.interTalk(req, id).then(data => {
        return res.send(data);
    }).catch(next);
};

// 互动工作
const interWork = (req, res, next) => {
    let {id} = req.query;

    model.interWork(req, id).then(data => {
        return res.send(data);
    }).catch(next);
};

// 更多共同工作
const moreWork = (req, res, next) => {
    model.moreWork(req).then(data => {
        return res.send(data);
    }).catch(next);
};

// 分页加载更多共同工作
const lastmore = (req, res, next) => {
    model.lastmore(req).then(data => {
        return res.send(data);
    }).catch(next);
};

// 更多互动沟通
const moreTalk = (req, res, next) => {
    model.moreTalk(req).then(data => {
        return res.send(data);
    }).catch(next);
};

module.exports = {
    index,
    info,
    interTalk,
    interWork,
    moreWork,
    moreTalk,
    lastmore
};
