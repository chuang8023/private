/**
 * 登录判断
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/4/1
 */

'use strict';

const user = require('../model/user');

module.exports = (req, res, next) => {
    user.info(req).then(data => {

        if (data.status === 401) {
            return res.redirect('/home/login');
        }

        next();
    }).catch(next);
};
