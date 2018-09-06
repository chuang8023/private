/**
 * git hook执行体
 * eslint检查JS，stylelint检查CSS／SCSS
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/2/17
 */

const shelljs = require('shelljs');
const path = require('path');

// 执行git diff的标准输出
let files = {
    js: shelljs.exec('git diff --cached --name-only --diff-filter=ACM | grep .js$', {
        silent: true
    }).stdout,
    css: shelljs.exec('git diff --cached --name-only --diff-filter=ACM | grep .scss$', {
        silent: true
    }).stdout
};

let exec = {
    js: path.resolve(__dirname, './node_modules/.bin/eslint'),
    css: path.resolve(__dirname, './node_modules/.bin/stylelint')
};

let result = {
    js: '',
    css: ''
};

// Windows 平台需要加后缀
let ext = process.platform === 'win32' ? '.cmd' : '';

// 在执行检查脚本的时候，不显示npm错误日志
if (!shelljs.grep('npm run -s', path.resolve('./.git/hooks/pre-commit')).stdout.trim()) {
    shelljs.sed('-i', 'npm run', 'npm run -s', path.resolve('./.git/hooks/pre-commit'));
}

if (files.js) {
    result.js = shelljs.exec(`${exec.js}${ext} -c .eslintrc --cache --fix ${files.js.replace(/\n/g, ' ')}`);
}

if (files.css) {
    result.css = shelljs.exec(`${exec.css}${ext} --config .stylelintrc ${files.css.replace(/\n/g, ' ')}`);
}

if (result.js && result.js.code || result.css && result.css.code) {
    process.exit(result.js.code || result.css.code); // eslint-disable-line
}
