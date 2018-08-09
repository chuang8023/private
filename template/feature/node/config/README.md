# 配置说明

开发环境、测试环境、正式环境对应各自不同配置，测试环境和正式环境配置走git统一维护  

**开发环境**配置需要手动配置：基本模板为
```javascript
module.exports = {
    api: 'http://www.xuqi.aysaas.com/',
    static: '//localhost:8080',
    fileio: 'http://fileio.xuqi.aysaas.com'
};
```
当前目录下新建development.js，copy上述内容，将 api 改为自己的配置即可