/**
 * 用户资料页
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/8/4
 */

'use strict';

import '../global/global.scss';
import '../global/global.js';

import './css/ucenter.scss';

import Vue from 'vue';

import Resource from 'vue-resource';

Vue.use(Resource);

import App from './components/ucenter/app.vue';

new Vue({
    el: '#ucenter-app',
    render: h => h(App)
});
