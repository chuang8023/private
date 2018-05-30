/**
 * 公共router
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/3/9
 */

'use strict';

const router = require('express').Router();

const model = require('./model/common');

// 设置主题
router.put('/theme', (req, res, next) => {
    model.setTheme(req, req.body).then(data => {
        return res.send(data);
    }).catch(next);
});

// 切换用户
router.get('/switchUser', (req, res, next) => {
    let {id} = req.query;

    model.switchUser(req, {
        user_id: id
    }).then(data => {
        return res.send(data);
    }).catch(next);
});

// 切换企业
router.get('/switchEnterprise', (req, res, next) => {
    let {id} = req.query;

    model.switchEnterprise(req, {
        enterprise_id: id
    }).then(data => {
        return res.send(data);
    }).catch(next);
});

// 删除一条历史记录
router.get('/clearOneHistory', (req, res, next) => {
    let {keyword} = req.query;

    model.clearOneHistory(req, {
        keyword: keyword
    }).then(data => {
        return res.send(data);
    }).catch(next);
});

// 删除全部历史记录
router.get('/clearAllHistory', (req, res, next) => {

    model.clearAllHistory(req).then(data => {
        return res.send(data);
    }).catch(next);
});

// 添加历史记录
router.get('/addHistory', (req, res, next) => {
    let {keyword} = req.query;

    model.addHistory(req, {
        keyword: keyword
    }).then(data => {
        return res.send(data);
    }).catch(next);
});

// 客服
router.get('/customer', (req, res, next) => {

    model.customer(req).then(data => {
        return res.send(data);
    }).catch(next);
});

module.exports = router;
