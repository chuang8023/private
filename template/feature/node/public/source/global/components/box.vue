<template>
    <div v-show="show" >
        <div class="boxmask" v-if="mask"></div>
        <div class="box" id="box">
            <header class="header" v-if="title">
                <span>{{title}}</span>
                <i class="close iconfont icon-guanbi" aria-hidden="true" @click.stop="dispatch('close')"></i>
            </header>
            <div class="content">
                <span>{{content}}</span>
            </div>
            <footer class="footer" v-if="btns">
                <span class="boxbtn" v-for="btn in btns" :class="btn.class" @click.stop="dispatch(btn.cb)">
                    {{btn.name}}
                </span>
            </footer>
        </div>
    </div>
</template>

<script>
    export default {
        props: ['show', 'title', 'btns', 'mask','content'],
        methods: {
            pos() {
                var el = this.$el;
                el.style.marginLeft = -(el.offsetWidth) / 2;
                el.style.marginTop = -(el.offsetHeight) / 2;
            },
            dispatch(cb) {
                this.$emit('dialog', cb);
            }
        },
        watch: {
            show(val) {
                val && this.pos();
            }
        }
    }
</script>

<style>
    .boxmask {
        position: fixed;
        top: 0;
        left: 0;
        bottom: 0;
        right: 0;
        background: rgba(0, 0, 0, .6);
        z-index: 400;
    }

    .box {
        position: fixed;
        box-sizing: border-box;
        margin-top: -90px;
        margin-left: -200px;
        left: 50%;
        top: 50%;
        background: #fff;
        border: 1px solid rgba(0, 0, 0, 0.3);
        min-width: 400px;
        min-height: 180px;
        font-size: 14px;
        z-index: 401;

        .header {
            padding: 0 15px;
            height: 40px;
            line-height: 40px;
            cursor: move;
            color: #404040;
            background: #f5f5f5;
            border-bottom: 1px solid #ccc;
            font-weight: bold;
        }

        .content {
            padding: 20px;
            margin-top: 16px;
            margin-bottom: 16px;

            span {
                display: block;
                text-align: center;
                font-size: 14px;
                color: #404040;
            }
        }

        .close {
            position: relative;
            float: right;
            color: #c1c1c1;
            cursor: pointer;
            font-size: 12px;
            top: 2px;

            &:hover {
                color: #000;
            }
        }

        .footer {
            margin-bottom: 20px;
            text-align: center;
        }

        .boxbtn {
            display: inline-block;
            cursor: pointer;
            width: 80px;
            height: 30px;
            line-height: 30px;
            text-align: center;
            color: #fff;
            box-sizing: border-box;
            border-radius: 2px;
            font-size: 14px;

            background-color: #acacac;
            margin-right: 5px;

            &:last-child {
                margin-right: 0;
            }

            &.gray {
                background-color: #acacac;
            }
        }
    }
</style>