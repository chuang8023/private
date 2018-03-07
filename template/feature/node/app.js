/**
 * QYCloud app
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/2/15
 */

'use strict';

const path = require('path');

const express = require('express');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const compression = require('compression');
const favicon = require('serve-favicon');
const hbs = require('express-hbs');

// 注册组件(HTTP/Config/Logger)
const lib = require('./lib');
const config = require('./config');

lib.registerGlobal(config);

const app = express();

app.use(favicon(path.join(__dirname, '/public/favicon.ico')));
app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));
app.use(cookieParser());
app.use(compression());

app.engine('hbs', hbs.express4({
    extname: '.hbs',
    layoutsDir: path.join(__dirname, 'doraemon/view/layout'),
    defaultLayout: path.resolve(__dirname, 'doraemon/view/layout.hbs'), // absolute path
    partialsDir: path.join(__dirname, '/doraemon/view/partial')
}));
app.set('view engine', 'hbs');
app.set('views', path.join(__dirname, 'doraemon/view'));

// Logger
const logger = global[config.app].logger;

try {
    const render = require('./doraemon/middleware/render');
    const pageNotFound = require('./doraemon/middleware/404');
    const internalServerError = require('./doraemon/middleware/500');

    app.use(require('./doraemon/middleware/display'));

    app.use(render(require('./public/.manifest.json')));

    require('./dispatch')(app);

    app.all('*', pageNotFound);

    app.use(internalServerError);
} catch (err) {

    logger.serviceErrror('Service error', err);
}

app.listen(config.port || 3000, function() {
    logger.info(`${config.app} service start`);
});
