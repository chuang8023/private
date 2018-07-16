/**
 * 美洽客服模块
 * @author: wangkai<1021475334@qq.com>
 * @date: 2017/4/26
 */

import Vue from 'vue';

import Resource from 'vue-resource';

// http request
Vue.use(Resource);

function meiQiaAnimation() {
    const MEIQIA_BTN = document.getElementById('MEIQIA-BTN');
    const MEIQIA_BTN_TEXT = document.getElementById('MEIQIA-BTN-TEXT');

    if (MEIQIA_BTN_TEXT) {
        MEIQIA_BTN.onmousemove = function() {
            MEIQIA_BTN_TEXT.style.cssText = `height: ${ MEIQIA_BTN_TEXT.innerHTML.length * 20 + 5}px !important`;
        };

        MEIQIA_BTN.onmouseleave = function() {
            MEIQIA_BTN_TEXT.style.cssText = 'height: 0px!important';
        };
    }
}

Vue.http.get('/common/customer').then(response => {
    if (response.ok) {
        let { customerStatus, customerToken, enterpriseName, userName, userId } = response.body.result;

        let meiQiaId = 55929;

        if (customerToken && customerStatus === '1') {
            (function(m, ei, q, i, a, j, s) {
                m[i] = m[i] || function() {
                    (m[i].a = m[i].a || []).push(arguments);
                };
                j = ei.createElement(q);
                s = ei.getElementsByTagName(q)[0];
                j.async = true;
                j.charset = 'UTF-8';
                j.src = '//static.meiqia.com/dist/meiqia.js';
                s.parentNode.insertBefore(j, s);
            }(window, document, 'script', '_MEIQIA'));

            _MEIQIA('entId', meiQiaId);
            _MEIQIA('allSet', meiQiaAnimation);
            _MEIQIA('metadata', {
                name: userName, // 美洽默认字段
                company: enterpriseName
            });
            _MEIQIA('clientId', userId);

            _MEIQIA('assign', {
                agentToken: customerToken
            });
        }
    }
});
