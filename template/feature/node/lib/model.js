/**
 * Model基类
 * @method _appendCookie(url, request, data) 帮助组合当前请求的cookie到http的header中
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/3/13
 */

'use strict';

class Model {
    /**
     * 扩展请求参数，将cookie加入请求头
     * @param url [string]
     * @param req [Object] request对象
     * @param data [Object] 请求参数
     */
    _appendCookie(url, req, data) {
        return [
            url,
            data,
            {
                headers: {
                    cookie: req.headers.cookie,
                    'user-agent': req.headers['user-agent']
                }
            }
        ];
    }
}

module.exports = Model;
