/**
 * config
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/2/15
 */

'use strict';

const _ = require('lodash');

const env = process.env.NODE_ENV || 'development';

const config = {
    app: 'QyCloud',
    name: '启业云',
    port: 7000
};

switch (env) {
    case 'production':
        try {
            const production = require('./production');

            _.extend(config, production);
        } catch (e) {
            throw 'production config file not exists';
        }
        break;
    case 'test':
        try {
            const test = require('./test');

            _.extend(config, test);
        } catch (e) {
            throw 'test config file not exists';
        }
        break;
    default:
        try {
            const development = require('./development');

            _.extend(config, development);
        } catch (e) {
            throw 'development config file not exists';
        }
        break;
}

module.exports = config;
