/**
 * 404错误处理
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/2/16
 */

'use strict';

const logger = global[global.app].logger;

module.exports = (err, req, res, next) => {

    logger.processError(`Processing error at ${req.url}.`, err);

    if (!res.headersSent) {
        if (req.xhr) {
            return res.status(500).json({
                code: 500,
                message: '服务器错误'
            });
        }

        return res.status(500).render('error/500', {
            title: '服务器错误 | 启业云',
            module: 'error',
            page: '500'
        });
    }
    next(err);
};
