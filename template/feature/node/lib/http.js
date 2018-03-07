/**
 * HTTP请求
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/2/15
 */

'use strict';

const _ = require('lodash');
const request = require('request-promise');
const urlJoin = require('url-join');
const querystring = require('querystring');

const ERR = {
    API_CALL_FAIL: {
        code: 500,
        message: 'API调用失败'
    }
};

/**
 * constructor
 */
function Http(url, opts) {
    this.opts = opts;
    this.url = url;

    if (!this.url) {
        throw new Error('url required.');
    }
}

/**
 * 生成请求的完整路径
 * @param url 请求url
 * @param qs 请求参数
 */
const genPath = (url, qs) => {
    if (qs) {
        return `${url}?${querystring.stringify(qs)}`;
    } else {
        return url;
    }
};

Http.prototype.get = function(path, data, opts) {
    let logger = global[global.app].logger;

    let options = _.defaults(opts || {}, {
        url: urlJoin(this.url, path),
        method: 'get',
        qs: data,
        json: true
    }, this.opts);

    let url = genPath(options.url, options.qs);

    logger.info(`api GET at: ${url}`);

    return request(options).then(res => {

        // TODO：接口需要统一返回值格式
        if (res.status !== 200 && !res.success) {
            logger.warn(`GET ${url} request not ok! status: ${res.status}, ${res.message}`);
        }

        return res;
    }).catch(e => {

        // 未登录做异常处理...wtf
        if (e.statusCode === 401) {
            return Promise.resolve({
                status: 401,
                message: e.message
            });
        } else {
            logger.apiError(`api Error at GET ${url}`, e);
            return Promise.resolve(ERR.API_CALL_FAIL);
        }
    });
};

Http.prototype.post = function(path, data, opts) {
    let logger = global[global.app].logger;

    let options = _.defaults(opts || {}, {
        url: urlJoin(this.url, path),
        method: 'post',
        form: data,
        json: true
    }, this.opts);

    let url = genPath(options.url);

    logger.info(`api POST at: ${url}`);

    return request(options).then(res => {
        if (res.status !== 200) {
            logger.warn(`POST ${url} request not ok! status: ${res.status}, ${res.msg}`);
        }

        return res;
    }).catch(e => {
        logger.apiError(`api Error at POST ${url}`, e);

        return Promise.resolve(ERR.API_CALL_FAIL);
    });
};

Http.prototype.put = function(path, data, opts) {
    let logger = global[global.app].logger;

    let options = _.defaults(opts || {}, {
        url: urlJoin(this.url, path),
        method: 'put',
        form: data,
        json: true
    }, this.opts);

    let url = genPath(options.url);

    logger.info(`api PUT at: ${url}`);

    return request(options).then(res => {
        if (res.status !== 200) {
            logger.warn(`PUT ${url} request not ok! status: ${res.status}, ${res.msg}`);
        }

        return res;
    }).catch(e => {
        logger.apiError(`api Error at PUT ${url}`, e);

        return Promise.resolve(ERR.API_CALL_FAIL);
    });
};

module.exports = Http;
