/**
 * sub app appcenter
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/3/9
 */

'use strict';

const path = require('path');

const express = require('express');
const hbs = require('express-hbs');

const app = express();

const view = '../../doraemon/view';

app.engine('hbs', hbs.express4({
    extname: '.hbs',
    layoutsDir: path.join(__dirname, view),
    defaultLayout: path.resolve(__dirname, view, 'layout/layout.hbs'),
    partialsDir: path.resolve(__dirname, view, 'partial')
}));
app.set('view engine', 'hbs');
app.set('views', [path.join(__dirname, 'view'), path.join(__dirname, view)]);

// router
app.use(require('./router'));

module.exports = app;
