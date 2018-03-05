/*
 * 正式环境配置
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/3/28
 */

'use strict';

module.exports = {
    port: 5000,
    api: 'http://www.feature.custommadeofthreeadmin.aysaas.com:55555',
    static: 'http://192.168.0.223:8006',
    fileio: 'http://fileio.feature.custommadeofthreeadmin.aysaas.com:55555',

    logger: {
        filename: 'log/saas.log'
    }
};
