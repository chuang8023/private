/**
 * render重写
 * 根据模块解析静态资源并加载
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/2/16
 */

'use strict';

const _ = require('lodash');
const config = global[global.app].config;

/**
 * 过滤css/js
 * @param manifest 过滤对象
 */
const splitManifest = (manifest) => {
    let js, css;

    if (manifest instanceof Array) {
        let group = _.groupBy(manifest, mani => {
            return _.endsWith(mani, '.js') ? 'js' : 'css';
        });

        js = group.js;

        css = group.css;
    } else {
        if (_.endsWith(manifest, '.js')) {
            js = [manifest];
        } else {
            css = [manifest];
        }
    }

    // 添加前缀
    return {
        js: _.map(js, theJs => `${config.static}/${theJs}`),
        css: _.map(css, theCss => `${config.static}/${theCss}`)
    };
};

/**
 * 从manifest解析静态资源文件名
 */
const getStatic = (manifests, page) => {
    let lib = splitManifest(manifests.lib);
    let manifest = splitManifest(manifests[page]);

    // attention：合并数组时，lib在前
    return {
        js: _.concat(lib.js, manifest.js),
        css: _.concat(lib.css, manifest.css)
    };
};

module.exports = (manifests) => {

    return (req, res, next) => {
        let render = res.render;

        res.render = (view, options, cb) => {
            let {module, page} = options;
            let myStatic = {};

            if (module && page) {
                myStatic = getStatic(manifests, `${module}.${page}`);
            }

            render.call(res, view, _.assign(options, myStatic), cb);
        };
        next();
    };
};
