/**
 * appcenter router
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/3/9
 */

'use strict';

const router = require('express').Router();

const index = require('./controller/index');

const auth = require('../../doraemon/middleware/auth');

router.get('/', auth, index.index); // 应用中心
router.get('/apps', index.apps); // 获取应用列表
router.post('/setapp', index.setapp); // 新建/编辑应用
router.put('/drag', index.drag); // 应用拖拽

module.exports = router;
