<template>
    <div class="intersection-talk">
        <ul class="talk-list">
            <li v-for="talk in talks" class="clearfix">
                <p class="datetime left">{{talk.time}}</p>
                <div class="info left">
                    <p class="app-name">
                        <a :href="appLink(talk.appInfo)" target="_blank">{{talk.appTitle}}</a>
                    </p>
                    <p class="content" v-html="at(talk.msg)"></p>
                </div>
            </li>
        </ul>
        <p class="icon" v-show="!isOver">
            <span class="iconfont icon-xiazhankai" @click="more"></span>
        </p>
    </div>
</template>

<style>
    .intersection-talk {

        .talk-list {
            > li {
                margin-top: 32px;
                margin-bottom: 32px;
            }

            .datetime {
                width: 170px;
                text-align: right;
                padding-right: 24px;
                color: #666;
                box-sizing: border-box;
                font-size: 14px;
            }

            .info {
                box-sizing: border-box;
                max-width: calc(100% - 170px);
                border-left: 1px solid #d8dde4;
                padding-left: 24px;
            }

            .app-name {
                font-size: 14px;

                a {
                    color: #4680ff;

                    /* for empty content link */
                    display: block;
                    min-height: 30px;
                    min-width: 30px;
                }
            }

            .content {
                font-size: 14px;
                color: #666;
                margin-top: 11px;
                line-height: 20px;

                /* emoji */
                img {
                    width: 26px;
                    height: 26px;
                    vertical-align: middle;
                }
            }
        }

        .icon {
            text-align: center;
            color: #bfbfbf;
            cursor: pointer;
            margin-bottom: 32px;
        }
    }

</style>

<script>
    export default {
        props: ['initTalk', 'id', 'count'],
        data() {
            return {
                talks: _.slice(this.initTalk, 0, 20) // 首屏10个
            };
        },
        computed: {
            start() {
                return _.size(this.talks);
            },
            isOver() {
                return _.size(this.talks) >= this.count;
            }
        },
        methods: {
            at(msg) {
                return _.replace(msg, /@\[(.*?)\]\(at:.*?\)\(type:.*?\)/g, '<span class="at-user">$1</span>');
            },
            appLink(info) {
                let {type, appId, dataId} = info;

                return `/app/!/${type}/open/record/${appId}/${dataId}`;
            },
            more() {
                this.$http.get('/organization/talk/more', {
                    params: {
                        uid: this.id,
                        start: this.start || 0
                    }
                }).then(response => {
                    if (response.ok && response.body.status === 200) {
                        let {data} = response.body.result;

                        this.talks = _.concat(this.talks, data);
                    }
                });
            }
        }
    }
</script>