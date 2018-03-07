/**
 * lib entry
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/2/15
 */

'use strict';

const Http = require('./http');
const logger = require('./logger');
const Model = require('./model');

function Lib(config) {
    this.config = config;
    this.Http = Http;
    this.logger = logger(config.logger);
    this.Model = Model;
}

module.exports = {
    registerGlobal(config) {
        let app = config.app || 'application';

        global.app = app;
        global[app] = this._init(config);
    },

    _init(config) {
        return new Lib(config);
    }
};
