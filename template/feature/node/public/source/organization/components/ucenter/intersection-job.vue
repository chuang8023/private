<template>
    <div>  
        <ul class="intersection-job">
            <li v-for="(job, mainindex) in jobslist" class="clearfix">
                <p class="app-name left">{{job.definition_title}}</p>
                <ul class="sub left">
                    <li v-for="(data, index) in works[job.definition_id].data" class="clearfix">
                        <p class="update-time left">
                            {{data.updated_at}}
                            <span class="update-create-text right">更新</span>
                        </p>
                        <p class="title left">
                            <a :href="`/app/!/workflow/open/record/${job.definition_id}/${data.instance_id}`" target="_blank">{{data.title}}</a>
                        </p>
                        <p class="create-time right">
                            {{data.created_at}}
                            <span class="update-create-text">创建</span>
                        </p>
                    </li>
                </ul>
                <p class="icon" v-show="!isOver[job.definition_id]">
                    <span class="iconfont icon-xiazhankai" @click="more(job.definition_id)"></span>
                </p>
            </li>
        </ul>
        <p class="icon" v-show="!isLastOver">
            <span class="iconfont icon-xiazhankai" @click="lastmore"></span>
        </p>
    </div>
    
</template>

<style>
    .intersection-job {

         > li {
            padding: 15px 0;
            border-bottom: 1px solid #d8dde4;
            line-height: 30px;

            &:last-child {
                border-bottom: none;
            }
        }

        .app-name {
            width: 100px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            color: #666;
        }

        .sub {
            box-sizing: border-box;
            width: calc(100% - 100px);
        }

        .update-time {
            width: 182px;
            padding-right: 20px;
            text-align: right;
        }

        .title {
            padding-left: 20px;
            border-left: 1px solid #d8dde4;

            a {
                color: #4680ff;
                max-width: 600px;
                text-overflow: ellipsis;
                overflow: hidden;
                white-space: nowrap;

                /* for empty content link */
                display: block;
                min-height: 30px;
                min-width: 30px;
            }
        }

        .app-name,
        .title {
            font-size: 16px;
        }

        .update-time,
        .create-time {
            font-size: 14px;
            color: #999;
        }

        .update-create-text {
            display: inline-block;
            margin-left: 10px;
            width: 30px;
        }

        .icon {
            text-align: center;
            color: #bfbfbf;
            cursor: pointer;
        }
    }

    .icon {
        text-align: center;
        color: #bfbfbf;
        cursor: pointer;
    }
</style>

<script>
    import Vue from 'vue';

    export default {
        props: ['jobs', 'id', 'workflowCount'],
        data() {
            let works = {};
            let jobslist = _.clone(this.jobs);
            
            // init works
            _.forEach(jobslist, job => {
                let {definition_id, dataCount, data} = job;

                works[definition_id] = {
                    count: dataCount,
                    data: _.slice(data, 0, 3)
                }
            });
            let isLastOver = _.size(works) >= this.workflowCount;

            return {
                works: works,
                jobslist:jobslist,
                isLastOver:isLastOver
            };
        },
        computed: {
            start() {
                let _start = {};

                _.forEach(this.works, (work, id) => {
                    _start[id] = _.size(work.data);
                });

                return _start;
            },
            isOver() {
                let _end = {};

                _.forEach(this.works, (work, id) => {
                    _end[id] = _.size(work.data) >= work.count
                });

                return _end;
            }
        },
        methods: {
            more(appid) {
                const  _this = this;
                this.$http.get('/organization/job/more', {
                    params: {
                        appid,
                        uid: this.id,
                        start: this.start[appid] || 0
                    }
                }).then(response => {
                    if (response.ok && response.body.status === 200) {
                        let {data} = response.body.result;
                        _this.works[appid].data =  _.concat(this.works[appid].data, data);
                    }
                });
            },
            lastmore() {
                const  _this = this;

                this.$http.get('/organization/job/lastmore', {
                    params: {
                        uid: _this.id,
                        pagestart: _.size(_this.works) || 0
                    }
                }).then(response => {
                    if (response.ok && response.body.status === 200) {
                        let {data} = response.body.result;
                        _this.jobslist =  _.concat(_this.jobslist, data);

                        _.forEach(_this.jobslist, job => {
                            let {definition_id, dataCount, data} = job;
                                _this.$set(_this.works, definition_id, {
                                    count: dataCount,
                                    data: _.slice(data, 0, 3)
                                });
                        });
                        _this.isLastOver = _.size(_this.works) >= this.workflowCount;
                    }
                });
            }
        }
    }
</script>