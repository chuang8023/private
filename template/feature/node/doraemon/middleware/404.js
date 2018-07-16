/**
 * 404错误处理
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/2/16
 */

'use strict';

module.exports = (req, res) => {
    if (req.xhr) {
        return res.status(404).json({
            code: 404,
            message: '抱歉，页面不存在！'
        });
    }

    return res.status(404).render('error/404', {
        title: '页面不存在 | 启业云',
        module: 'error',
        page: '404'
    });
};
