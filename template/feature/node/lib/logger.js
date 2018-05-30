/**
 * 日志
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/2/17
 */

const winston = require('winston');

const DailyFileTransport = require('winston-daily-rotate-file');

const _ = require('lodash');

// 扩展的错误方法
// 扩展的方法名 -> 错误类型
const patulousErrors = {
    apiError: 'API',
    processError: 'DATA_PROCESSING',
    serviceErrror: 'SERVICE'
};

module.exports = config => {
    let opt = {
        transports: [
            new (winston.transports.Console)({
                level: 'debug',
                colorize: 'all',
                prettyPrint: () => '', // 格式化输出为 message, 除去metadata
                handleExceptions: true
            })
        ],
        exitOnError: false
    };

    // 正式环境添加LogFile
    if (process.env.NODE_ENV === 'production') {

        if (config) {
            opt.transports.push(new DailyFileTransport(_.extend({
                json: false,

                // daily formate
                prepend: true,
                datePattern: 'yyyy-MM-dd.',

                formatter: function(e) {
                    let meta = e.meta;

                    return JSON.stringify({
                        level: e.level,
                        time: new Date().toLocaleString(),
                        msg: e.message,
                        app: 'QYCloud-Node',

                        // group为错误类型的分类
                        // 『 API 』接口请求
                        // 『 DATA_PROCESSING 』数据处理
                        // 『 SERVICE 』服务
                        group: meta.type,

                        // 错误类型子分类
                        // 给API的请求添加了GET和POST的子分类
                        object: meta.subType,
                        error: meta.err
                    });
                }
            }, config)));
        }
    }

    let logger = new (winston.Logger)(opt);

    // 扩展logger，提供默认类型的错误日志

    _.forEach(patulousErrors, (type, method) => {

        logger[method] = (msg, error, ...meta) => {

            // 一行展示描述信息
            // >>>> 二行展示错误栈
            logger.error(`${msg}\n>>>>>>`, error || '', _.extend(meta || {}, {
                type: type,
                err: error || ''
            }));
        };
    });

    return logger;
};
