/**
 * organization router
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/8/4
 */

'use strict';

const router = require('express').Router();

const ucenter = require('./controller/ucenter');

const auth = require('../../doraemon/middleware/auth');

router.get('/usercontactinfo/:id', auth, ucenter.index); // 个人资料页页面
router.get('/usercontactinfo/info/:id', auth, ucenter.info); // 个人资料

router.get('/intertalk', auth, ucenter.interTalk); // 相互沟通
router.get('/interwork', auth, ucenter.interWork); // 共同工作

router.get('/job/more', auth, ucenter.moreWork); // 加载更多共同工作
router.get('/talk/more', auth, ucenter.moreTalk); // 加载更多互动沟通

router.get('/job/lastmore', auth, ucenter.lastmore); // 分页加载更多共同工作


module.exports = router;
