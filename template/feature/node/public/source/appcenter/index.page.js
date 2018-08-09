/**
 * 应用中心
 * @author: xuqi<xuqi@i0011.com>
 * @date: 2017/3/9
 */

import '../global/global.scss';
import '../global/global.js';
import './css/index.scss';
import Vue from 'vue';
import Sortable from 'sortablejs';
import Resource from 'vue-resource';
import App from './components/app.vue';
import Dialog from '../global/components/dialog.vue';
import Box from '../global/components/box.vue';

// sortable
// Vue.directive('sortable', {
//     inserted: function(el, binding) {
//         new Sortable(el, binding.value || {});
//     }
// });

// http request
Vue.use(Resource);

new Vue({
    delimiters: ['[[', ']]'],
    el: '#appcenter',
    http: {
        root: '/appcenter'
    },
    data: {
        apps: [],
        remnant: 200,
        dialog: {
            title: '新创建系统',
            mask: false,
            show: false,
            btns: [
                {
                    name: '完成',
                    cb: 'sure'
                }
            ]
        },
        admin: false,

        // 表单：名称、描述
        name: '',
        desc: '',

        // 推荐图标
        icons: [
            'home', 'edit', 'chain', 'dollar', 'globe', 'clipboard', 'inbox', 'laptop'
        ],

        // 默认/选中图标
        def: 'globe',
        box: {
            title: '提示',
            mask: true,
            show: false,
            content: '',
            btns: [
                {
                    name: '关闭',
                    cb: 'sure'
                }
            ]
        },
    },
    components: {
        app: App,
        'x-dialog': Dialog,
        'x-box': Box
    },
    methods: {
        add: function() {
            let dialog = document.getElementById('dialog'),
                appadd = document.getElementById('app-add'),
                left = appadd.offsetLeft + 300 + 'px',
                i = Math.floor(Math.random() * 8);

            dialog.style.left = left;
            this.def = this.icons[i];
            this.clear();
            this.dialog.show = true;
        },

        boxEvent: function(cb) {
            this.box.show = false;
        },

        // dialog event
        dialogEvent: function(type) {
            this[type]();
        },
        close: function() {
            this.dialog.show = false;
        },
        cancel: function() {
            this.close();
        },
        descInput: function() {
            this.remnant = 200 - this.desc.length;
        },
        sure: function() {
            var _this = this;

            if (!this.name) {
                alert('请输入系统名称');
                return;
            }
            if (!this.def) {
                alert('请选择图标');
                return;
            }
            this.$http.post('setapp', {
                name: _this.name,
                description: _this.desc,
                icon_name: _this.def,
                order: +this.apps.slice(-1)[0].order + 1 // 取最后一个app的order+1为新建app的order
            }).then(function(response) {
                if (response.ok) {
                    let id = response.body.id;

                    if (response.body.status === 500) {
                        this.box.show = true;
                        this.box.content = response.body.msg;
                    } else {
                        if (id) {
                            _this.close();
                            location.href = `/appcenter/appsystem/${id}`;
                        }
                    }

                }
            });
        },

        // 清除数据
        clear: function() {
            this.remnant = 200;
            this.name = '';
            this.desc = '';
        },

        // 设置图标
        setIcon: function(icon) {
            this.def = icon;
        }
    },
    created: function() {
        let _this = this;

        this.$http.get('apps').then(response => {
            if (response.ok) {
                let data = response.body;

                _this.admin = data.admin;
                _this.sortable && _this.sortable.option('disabled', !_this.admin);
                _this.apps = data.apps;
            }
        });
    },
    mounted: function() {
        let _this = this;
        let $appList = document.querySelector('.appcenter');
        let center = document.getElementById('apps-center');

        this.sortable = new Sortable(document.getElementById('app-list'), {
            disabled: !_this.admin,
            filter: '.app-add',
            onUpdate: function(e) {
                let order = 0;

                // swip app
                let from = e.oldIndex;
                let to = e.newIndex;
                let $from = _this.apps[from];

                _this.apps.splice(from, 1);
                _this.apps.splice(to, 0, $from);
                let apps = _this.apps.map(app => {
                    return {
                        id: app.id,
                        order: order++
                    };
                });
                let target = _this.apps[from].id;

                // notice: 用户不做拖拽失败处理
                _this.$http.put('drag', {
                    parentId: 0,
                    childs: JSON.stringify(apps),
                    nodeId: target
                });
            },
            onMove: function(e) {
                return e.related.className.indexOf('app-add') === -1;
            }
        });

        // width & margin of single app
        const single = 315; // width + margin
        const resize = function() {
            let width = $appList.offsetWidth;

            // 算式：n * single - 15
            // Notice: 每个app的margin-left:15px,并且整个列表margin-left:-15px以控制对齐，因此最后-15

            center.style.width = `${Math.floor((width - 30) / single) * single - 15}px`;
        };

        // resize，整数倍app宽度自适应
        requestAnimationFrame(function() {
            window.onresize = resize;
        });

        // init
        resize();

        // 初始化后再显示，减少margin计算带来的闪烁
        center.style.display = 'block';
    },
});
