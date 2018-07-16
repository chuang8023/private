<template>
    <div class="um-outside">
        <div class="u-and-me" v-if="show">
            <ul class="tabs clearfix">
                <li class="tab" v-show="worksCount" :class="{'focus': focus === 'WORK'}" @click="tabFocus('WORK')">
                    共同工作 ({{worksCount}}条)
                </li>
                <li class="tab" v-show="talkCount" :class="{'focus': focus === 'TALK'}" @click="tabFocus('TALK')">
                    互动沟通 ({{talkCount}}条)
                </li>
            </ul>
            <div class="contents">
                <job v-show="worksCount" v-if="focus === 'WORK'" :jobs="works" :workflowCount="workflowCount" :id="id"></job>
                <talk v-show="talkCount" v-if="focus === 'TALK'" :initTalk="talks" :count="talkCount" :id="id"></talk>
            </div>
        </div>
    </div>
</template>

<style>
    .u-and-me {
        box-shadow: 0 0 8px rgba(0,0,0,0.1);
        margin-top: 24px;
        border-radius: 5px;
        padding: 21px 68px 0 35px;

        .tabs {
            padding-top: 11px;
            border-bottom: 1px solid #d8dde4;
        }

        .tab {
            position: relative;
            float: left;
            border-bottom: 2px solid transparent;
            font-size: 14px;
            padding-bottom: 10px;
            margin-left: 35px;
            color: #999;
            cursor: pointer;
            bottom: -1px;

            &:first-child {
                margin-left: 0;
            }

            &.focus {
                border-color: #4680ff;
                color: #333;
            }
        }

        .contents {
            overflow: hidden;
        }
    }
</style>

<script>
    import Job from './intersection-job.vue';
    import Talk from './intersection-talk.vue';

    import _ from 'lodash';

    export default {
        data() {
            return {
                id: '',
                focus: '',
                works: [],
                worksCount: 0,
                talks: [],
                talkCount: 0,
                workflowCount : 0
            }
        },
        computed: {
            show() {
                return this.worksCount || this.talkCount;
            }
        },
        components: {
            job: Job,
            talk: Talk
        },
        methods: {
            tabFocus(index) {
                this.focus = index;
            }
        },
        created() {
            let id = location.pathname.replace(/\/organization\/usercontactinfo\//, '');

            this.id = id;

            // 共同工作
            const workPromise = this.$http.get('/organization/interwork', {
                params: {
                    id
                }
            });

            // 互动沟通
            const talkPromise = this.$http.get('/organization/intertalk', {
                params: {
                    id
                }
            });

            Promise.all([workPromise, talkPromise]).then(response => {
                let work = response[0];
                let talk = response[1];

                if (work.ok && work.body.status === 200) {
                    let {count, data, workflowCount} = work.body.result;
                    this.works = data;
                    this.worksCount = count || 0;
                    this.workflowCount = workflowCount || 0;
                }

                if (talk.ok && talk.body.status === 200) {
                    let {count, data} = talk.body.result;

                    this.talks = data;
                    this.talkCount = count ? +count : 0;
                }

                // focus第一个显示的tab
                if (this.worksCount || this.talkCount) {
                    this.focus = this.worksCount ? 'WORK' : 'TALK';
                }

            });
        }
    }
</script>