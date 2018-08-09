import Vue from 'vue';

import Resource from 'vue-resource';
import Tinycon from 'tinycon';
import Ellipsis from 'ellipsis.js';
import Ps from 'perfect-scrollbar';
import Box from './components/box.vue';

// import QRCode from 'qrcodejs2';

import './components/customer';
import 'perfect-scrollbar/src/css/main.scss';

const icon = {
    checked: 'fa-check-square',
    unchecked: 'fa-square'
};

// http request
Vue.use(Resource);

/**
 * 移除初始主题色
 */
const _removeDefTheme = $dom => {
    $dom.className = $dom.className.replace(/\s+(black|purple|blue|year)/g, '');
};

const query = document.querySelector.bind(document);
const _ = require('lodash');

const entIds = ['BaoXianFuWuAnQuanTiJ', 'BaoXianFuWu', 'APICeShiQiYe'];

const default51Buttons = [
    {
        link: '/eai/project/exam/index.do',
        title: '在线考试',
        icon: 'fa fa-graduation-cap'
    },
    {
        link: '/eai/project/safetycheck.do',
        title: '安全体检',
        icon: 'iconfont icon-anquanjiancha'
    }
];

const safetyHost = 'tools.51safety.com.cn';

// side component
let side;

// header app
new Vue({
    el: '#x-header-app',
    data: {
        showSkinList: false,
        showUserSet: false,
        showSearchBox: false,

        showInform: false,

        sideOpen: false,

        theme: '',

        modules: [], // 搜索时可跳转的模块

        timer: '', // 运营通告周期性调用

        key: '', // 全局搜索关键词

        showHistory: false, // 全局搜索历史记录
        showModuleSearch: false, // 全局搜索模块智能提醒,

        countDown: '', // 倒计时，通知公告倒计时
        qrcodeShow: false,
        bothShow: false,
        qycodeFlag: '',
        qycode: false,
        safecode: false,
        qycodeShow: true,
        box: {
            title: '提示',
            mask: true,
            show: false,
            content: '该用户已经禁用托管功能!',
            btns: [
                {
                    name: '关闭',
                    cb: 'sure'
                }
            ]
        },
        more51Buttons: null
    },
    computed: {
        is51Safety: () => location.hostname === safetyHost,
        existsIcon: () => _.some(entIds, entId => entId === window.Safirst.user.entId)
    },
    components: {
        'x-box': Box
    },
    methods: {
        // 切换皮肤列表显示
        toggleSkinList: function() {
            this.showSkinList = !this.showSkinList;

            //
            // if (this.showUserSet) {
            //     this.showUserSet = false;
            // }
        },

        // 切换用户设置显示
        toggleUserSet: function() {
            this.showUserSet = !this.showUserSet;

            if (this.showSkinList) {
                this.showSkinList = false;
            }
        },

        // 切换皮肤
        toggleSkin: function(skin) {
            if (skin === this.theme) {
                return;
            }

            // toggle checked
            let origin = query(`.skin-li .${icon.checked}`).classList;
            let current = query(`.skin-li .${skin}`).classList;

            origin.add(icon.unchecked);
            origin.remove(icon.checked);

            current.add(icon.checked);
            current.add(icon.unchecked);

            // 切换header和side中的样式
            // 移除主题样式
            _removeDefTheme(this.$el.parentNode);

            this.theme = skin;
            side && side.$emit('theme', skin);

            // 隐藏皮肤列表
            this.showSkinList = false;

            // 更新数据(综合体验考虑，此处不考虑失败情况)
            this.$http.put('/common/theme', {
                theme: skin,
                userId: query('.changeTheme').dataset.trusterid
            });
        },

        // 切换搜索框的显示
        toggleSearchBox: function(show) {
            let _this = this;

            this.showSearchBox = show;

            if (show) {
                this.$nextTick(function() {
                    _this.$refs.search.focus();
                });
            } else {
                this.$refs.search.value = '';
            }
        },

        // 搜索
        search: function() {
            // 添加搜索数据
            this.$http.get('/common/addHistory', {
                params: {
                    keyword: query('.search-input').value
                }
            });

            if (this.key) {
                location.href = `/globalsearch/#!/all/${this.key}`;
            } else {
                location.href = '/globalsearch/suggestion/';
            }
        },

        // 历史记录中搜索
        histroySearch: function(key) {
            location.href = `/globalsearch/#!/all/${key}`;
        },

        // 模块搜索
        changeSearch: function() {
            let _this = this;
            let value = this.$refs.search.value;

            if (value) {
                this.$http.get('/common/addHistory', {
                    params: {
                        keyword: value
                    }
                }).then(function(res) {
                    if (res.ok) {
                        if (res.body.result.data.length) {
                            _this.modules = res.body.result.data;
                            _this.showHistory = false;
                            _this.showModuleSearch = true;
                        } else {
                            _this.showModuleSearch = false;
                            _this.showHistory = false;
                        }
                    }
                });
            } else {
                _this.showModuleSearch = false;
                _this.showHistory = true;
            }
        },

        // 是否显示历史记录
        doHistory: function() {
            let value = this.$refs.search.value;

            if (!value) {
                this.showHistory = true;
            }
        },

        // 隐藏历史记录和模块搜索
        hideHistroy: function() {
            this.showHistory = false;
            this.showModuleSearch = false;
        },

        // 删除一条历史记录
        deleteOneHistory: function(e) {
            e.stopPropagation();
            let history = e.target.parentNode.querySelector('.history-content');

            this.$http.get('/common/clearOneHistory', {
                params: {
                    keyword: history.innerText
                }
            }).then(function(res) {
                if (res.ok) {
                    e.target.style.display = 'none';
                    history.parentNode.removeChild(history);
                }
            });
        },

        // 删除所有历史记录
        deleteAllHistory: function() {
            let _this = this;

            this.$http.get('/common/clearAllHistory').then(function(res) {
                if (res.ok) {
                    _this.showHistory = false;
                    query('.search-box').removeChild(query('.search-history'));
                }
            });
        },

        // 切换用户
        toggleRole: function(id) {
            this.$http.get('/common/switchUser', {
                params: {
                    id: id
                }
            }).then(function(res) {
                if (res.body.success) {
                    window.location.href = '/user/workbench';
                } else if (res.body.error.indexOf('禁用') !== -1) {
                    // alert('您好，' + name + '的账号已被禁用，请切换到其它账号登录！');
                    this.box.show = true;
                } else {
                    history.go(0);
                }
            });

        },

        // 关闭提示弹框
        dialogEvent: function() {
            this.box.show = false;
        },

        // 切换企业
        toggleEnt: function(id) {
            this.$http.get('/common/switchEnterprise', {
                params: {
                    id: id
                }
            }).then(function(res) {
                if (res.ok) {
                    window.location.href = '/user/workbench';
                }
            });
        },

        // 关闭运营通告
        closeInform: function(informId, userId) {
            this.showInform = false;
            clearInterval(this.timer);

            if (window.localStorage) {
                window.localStorage.setItem(userId + '_closeIntroduceText', true);
                console.log(localStorage.getItem(userId + '_closeIntroduceText'));
                window.localStorage.setItem(userId + '_informId', informId);
            }
        },

        // 移入／出企业切换或账户切换展示／隐藏列表
        inLi: function(type, inOrOut) {
            let $el = document.getElementsByClassName(`${type}-list`)[0];

            if (!$el) {
                return;
            }

            if (inOrOut) {
                $el.style.display = 'block';
            } else {
                this.time = setTimeout(function() {
                    $el.style.display = 'none';
                }, 100);
            }
        },

        // 移入子列表则取消消失的time
        // 某些浏览器滚动条不属于移入区域
        hoverList: function() {
            if (this.time) {
                clearTimeout(this.time);
            }
        },

        // 当前企业
        activeEnt: function() {
            let _entid = query('.ent-list');

            if (_entid) {
                query('li[data-eid = "' + _entid.dataset.entid + '" ]').classList.add('active');
            }
        },

        // 当前用户
        activeUser: function(_userId) {
            let _user = query('li[data-uid = "' + _userId + '" ]');

            if (_user) {
                _user.classList.add('active');
            }
        },

        // 显示二维码
        qrcode: function() {
            if (this.qycodeFlag === 'one') {
                this.qrcodeShow = true;
                this.bothShow = false;
            } else if (this.qycodeFlag === 'both') {
                this.qrcodeShow = false;
                this.bothShow = true;
            }
        },

        // 隐藏二维码
        qrcodeNotshow: function() {
            this.qrcodeShow = false;
            this.bothShow = false;
        },

        // 生成二维码
        setqrcode: function() {
            var list = query('.changeTheme');
            var appId;
            var _this = this;

            if (list) {
                appId = list.dataset.entid;
                if (appId === 'TianJinJinAnZhongGo1') { // 金岸重工二维码隐藏
                    this.qycodeShow = false;
                    this.qrcodeShow = false;
                    this.bothShow = false;
                }
                this.$http.get('/api/apk/getapk', {
                    params: {
                        ent: appId
                    }
                }).then(function(res) {
                    var apkent = res.body.apkent;

                    if (apkent === 'public_cloud') { // 公有云
                        _this.qycodeFlag = 'one';
                        _this.qycode = true;
                        _this.safecode = false;
                    } else if (apkent === '51safety') {  // 私有云
                        _this.qycodeFlag = 'one';
                        _this.qycode = false;
                        _this.safecode = true;
                    } else {
                        _this.qycodeFlag = 'both';
                    }
                });
            }
        },

        fetch51Buttons() {

            function getCheckFlag() {
                return !window.sessionStorage.getItem('safetycheck') && !window.localStorage.getItem('safetycheck');
            }

            function setCheckFlag() {
                window.sessionStorage.setItem('safetycheck', true);
                window.localStorage.setItem('safetycheck', true);
            }

            this.$http.get('eai/project/api/user/getUserLevel.do')
                .then(response => response.json())
                .then(result => {
                    if (result.data.userLevel === 'ent') {
                        this.more51Buttons = default51Buttons;
                        if (getCheckFlag()) {
                            location.href = '/eai/project/safetycheck.do';
                            setCheckFlag();
                        }
                    }
                    if (result.data.userLevel === 'org') {
                        if (getCheckFlag()) {
                            location.href = '/professional/drcmermcpv2/index';
                            setCheckFlag();
                        }
                    }
                });
        }
    },

    created: function() {
        this.setqrcode();
        let _userId = query('.skin.tool').dataset.uid;

        let _number = query('.countdown-number');

        if (_number) {
            this.countDown = _number.dataset.count * 1;

            setInterval(() => {
                --this.countDown;
            }, 60000);
        }

        // 运营通告是否显示
        // 判断该运营通告是否已关闭过
        let _closeInfo = query('.close-inform');

        if (_closeInfo && localStorage.getItem(_userId + '_informId') !== _closeInfo.dataset.ifid) {
            localStorage.removeItem(_userId + '_closeIntroduceText');
        }

        // 判断是否显示运营通告
        if (!localStorage.getItem(_userId + '_closeIntroduceText')) {
            this.showInform = true;
        }

        // 当前企业
        this.activeEnt();

        // 当前用户
        this.activeUser(_userId);

        query('body').addEventListener('click', () => {
            this.showSkinList = false;
            this.showUserSet = false;
        });

        // 判断是否需要展示安全无忧按钮
        if (this.is51Safety && this.existsIcon) {
            this.fetch51Buttons();
        }
    },

    mounted() {
        Ellipsis({
            lines: 3,
            class: '.inform-intro'
        });

        let $ent = document.getElementById('ent-list');
        let $role = document.getElementById('role-list');

        $ent && Ps.initialize($ent);
        $role && Ps.initialize($role);
    },

    delimiters: ['[[', ']]']
});

// side app
side = new Vue({
    el: '#x-aside-app',
    data: {
        isOne: false,
        isOpen: false,
        activeLink: window.location.pathname + window.location.hash,
        theme: '',
        menulist: [],
        secondlistShow: false,
        MenuShow: false,
        noticeList: [],
        noticeShow: false,
        target: '',
        hideTimer: null,
        itemList: [],
        delayShow: null,
        dialogbox: {
            title: '退出登录',
            mask: true,
            show: false,
            content: '确定退出当前账号？',
            btns: [
                {
                    name: '取消',
                    cb: 'cancel'
                },
                {
                    name: '确定',
                    cb: 'sure'
                }
            ]
        },
    },
    components: {
        'x-dialog': Box
    },
    mounted() {
        let $menu = document.getElementById('menu-content');
        let $second = document.getElementById('second-content');

        $menu && Ps.initialize($menu);
        $second && Ps.initialize($second);
    },
    methods: {
        // 全局菜单
        menuSwitch: function() {
            this.$http.get('/api2/appcenter/applist/id').then(function(res) {
                this.menulist = res.body.result;
            });
        },

        // menu通知显示
        showmenuNotices: function() {
            var obj, objlist, noticecount, appid, node, nodeNotice, span, a;

            this.$http.get('/api2/notice/all', {
                params: {
                    url: this.activeLink.replace('app/#!', 'app/!')
                }
            }).then(function(res) {
                this.noticeList = res.body.result.menu.count;
                _.each(this.noticeList, function(id, count) {
                    appid = count;
                    obj = document.getElementsByClassName('menu-name');
                    for (let i = 0; i < obj.length; i++) {
                        if (obj[i].dataset.appid === appid) {
                            node = document.createElement('em');
                            obj[i].appendChild(node);
                        }
                    }

                    objlist = document.getElementsByClassName('noticeMenu');
                    _.each(objlist, function(val) {
                        if (val.dataset.appid === appid) {
                            // nodeNotice = document.createElement('em');

                            nodeNotice = document.createElement('div');
                            nodeNotice.className = 'bubble';

                            noticecount = Number(id) > 99 ? '99+' : Number(id);
                            nodeNotice.innerHTML = noticecount;
                            span = document.getElementById(appid);
                            a = span.getElementsByTagName('a')[0];

                            a.appendChild(nodeNotice);
                        }
                    });
                });
            });
        },
        btnleave: function(show) {
            if (show) {
                this.MenuShow = true;
            } else {
                query('.second-content').style.display = 'none';
                this.MenuShow = false;
            }
        },

        // 显示一级菜单
        showMenuList: function(event, show) {
            var left = event.clientX, x,
                top = event.clientY;

            top = top > 172 || top < 112 ? false : true;
            if (top && left < 56) {
                this.MenuShow = true;
                query('.second-content').style.display = 'none';
                for (x = 0; x < this.itemList.length; x++) {
                    this.itemList[x].classList.remove('itemactive');
                }
            } else {
                this.MenuShow = show;
                if (!show) {
                    query('.second-content').style.display = 'none';
                    for (x = 0; x < this.itemList.length; x++) {
                        this.itemList[x].classList.remove('itemactive');
                    }
                }

            }
        },

        switchMenuDiv: function(event, show, level, index) {
            var _this = this;

            if (this.hideTimer !== null) {
                clearTimeout(this.hideTimer);
            }
            if (this.delayShow !== null) {
                clearTimeout(this.delayShow);
            }
            switch (level) {
                case 1:
                    if (show) {  // 一级菜单控制二三级菜单
                        _this.delayShow = setTimeout(function() {
                            _this.showSecondList(event, index, show);
                        }, 160);

                        // _this.showSecondList(event, index, show);
                    }
                    break;
                case 3:
                    if (show) { // 二三级菜单显示或隐藏
                        _this.showLast(true);
                    } else {
                        this.hideTimer = setTimeout(function() {
                            query('.second-content').style.display = 'none';
                        }, 100);
                    }
                    break;
                default:
                    if (show) { // 菜单消失
                        clearTimeout(_this.delayshow);
                        _this.showMenuList(event, true);
                    } else {
                        this.hideTimer = setTimeout(function() {
                            _this.showMenuList(event, false);
                        }, 100);
                    }
                    break;
            }
        },
        showLast: function(flag) {
            if (flag) {
                query('.second-content').style.display = 'flex';
            }
        },
        changeActive: function(flag) {
            var activeList = document.querySelectorAll('.bt-img');

            for (let x = 0; x < activeList.length; x++) {
                activeList[x].classList.remove('bt-theme-active');
            }
            if (!flag) {
                if (this.activeLink.indexOf('user/workbench') > -1) {
                    query('.bt-workbench').className += ' bt-theme-active';
                } else if (this.activeLink.indexOf('dashboard') > -1) {
                    query('.bt-dashboard').className += ' bt-theme-active';
                } else {
                    query('.bt-appcenter').className += ' bt-theme-active';
                }
            }
        },

        // 二三级菜单显示
        showSecondList: function(event, index, flag) {
            var itemlist = document.getElementsByClassName('second-content-wrap'),
                show = '#category-item-' + index,
                scrollWidth,
                clientWidth, actualWidth = document.documentElement.clientWidth || document.body.clientWidth,
                newWidth, leaveWidth;

            query('.second-content').style.display = 'flex';
            for (let i = 0; i < itemlist.length; i++) {
                itemlist[i].style.display = 'none';
            }
            if (flag) {
                this.itemList = document.querySelectorAll('.menu-list');
                for (let x = 0; x < this.itemList.length; x++) {
                    this.itemList[x].classList.remove('itemactive');
                }
                query('.fore-' + index).className += ' itemactive';
                query(show).style.display = 'flex';
                scrollWidth = query(show).scrollWidth;
                clientWidth = query('.second-content').offsetWidth;
                if (scrollWidth + 265 > actualWidth || scrollWidth + 30 > actualWidth) {
                    if (actualWidth <= 1500 && actualWidth >= 1200) {
                        newWidth = 959;
                    } else if (actualWidth > 1500 && actualWidth <= 1750) {
                        newWidth = 1150;
                    } else if (actualWidth > 1750) {
                        newWidth = 1528;
                    } else {
                        newWidth = 777;
                    }
                    leaveWidth = newWidth - 10;
                    query(show).style.width = newWidth + 'px';
                    query(show).style.minWidth = newWidth + 'px';
                    if (query(show).offsetLeft < 0) {
                        query('.leftButton').style.display = 'block';
                    } else {
                        query('.rightButton').style.display = 'block';
                    }

                    query('.rightButton').onclick = function() {
                        if (query(show).offsetLeft > -leaveWidth) {
                            query(show).style.position = 'relative';
                            query(show).style.left = (-leaveWidth) + 'px';
                        }
                        query('.rightButton').style.display = 'none';
                        query('.leftButton').style.display = 'block';
                        query('.leftButton').onclick = function() {
                            if (query(show).offsetLeft < 0) {
                                query(show).style.left = '0px';
                                query('.rightButton').style.display = 'block';
                                query('.leftButton').style.display = 'none';
                            }
                        };
                    };
                } else if (scrollWidth > clientWidth) {
                    query(show).style.width = scrollWidth + 16 + 'px';
                    query(show).style.minWidth = scrollWidth + 16 + 'px';
                    query('.rightButton').style.display = 'none';
                    query('.leftButton').style.display = 'none';
                } else if (scrollWidth + 16 === clientWidth) {
                    query('.rightButton').style.display = 'none';
                    query('.leftButton').style.display = 'none';
                } else {
                    query('.rightButton').style.display = 'none';
                    query('.leftButton').style.display = 'none';
                }
            } else {
                query('.second-content').style.display = 'none';
                for (let x = 0; x < this.itemList.length; x++) {
                    this.itemList[x].classList.remove('itemactive');
                }
            }
        },

        // 退出二次确认
        logoutDialog: function() {
            this.dialogbox.show = true;
        },

        // 关闭提示弹框
        dialogEvent: function(cb) {
            if (cb === 'cancel' || cb === 'close') {
                this.dialogbox.show = false;
            } else {
                window.location = '/user/signout';
            }
        },
    },
    filters: {
        filterFun: function(value) {
            return value.substr(0, 8);
        }
    },
    delimiters: ['[[', ']]'],
    created: function() {
        const _this = this;

        this.menuSwitch();
        this.showmenuNotices();

        // 由header组件改变theme
        this.$on('theme', function(skin) {
            _removeDefTheme(this.$el.parentNode);
            _this.theme = skin;
        });

        
        if ((window.location.pathname).indexOf('/appcenter') > -1) {
            query('.bt-appcenter').className += ' year-class ';
        }
    }
});

//  title气泡
let count = document.title.match(/^\((\d)*\)/);

if (count) {
    count = count[1];

    Tinycon.setOptions({
        width: 4,
        height: 5,
        background: '#f00',
        color: '#f00'
    });

    Tinycon.setBubble('.'); // . for placeholder
}





