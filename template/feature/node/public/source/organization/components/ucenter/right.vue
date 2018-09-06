<template>
    <div class="station-info">
        <p class="title">岗位信息</p>
        <section class="station block">
            <p class="sub-title">岗位名称</p>
            <ul class="station-list" :class="{'only': data.jobs && data.jobs.length <= 1}">
                <li v-for="job in data.jobs">
                    <i class="icon iconfont icon-duoxuanweixuanzhong"></i>
                    {{job}}
                </li>
            </ul>
        </section>
        <section class="chief block" v-if="data.chiefs">
            <p class="sub-title">直接上级</p>
            <div v-if="data.chiefs.length > 0">
                <ul class="chief-list clearfix">
                    <li v-for="(chief, index) in data.chiefs" v-show="index >= 16 ? moreChief : true" :title="chief.name">
                        <a :href="`/organization/usercontactinfo/${chief.id}`">
                            <img class="avatar" :src="chief.avatar">
                            <p class="name">{{chief.name}}</p>
                        </a>
                    </li>
                </ul>
                <p class="icon-wrap">
                    <span class="iconfont icon-xiazhankai" v-if="data.chiefs.length > 16" @click="toggleChiefs" :class="{'spread': moreChief}"></span>
                </p>
            </div>
            <div class="no-one" v-else>
                暂无直接上级
            </div>
        </section>
        <section class="junior block" v-if="data.juniors">
            <p class="sub-title">直接下级</p>
            <div v-if="data.juniors.length > 0">
                <ul class="junior-list clearfix">
                    <li v-for="(junior, index) in data.juniors" v-show="index >= 16 ? moreJunior : true" :title="junior.name">
                        <a :href="`/organization/usercontactinfo/${junior.id}`">
                            <img class="avatar" :src="junior.avatar">
                            <p class="name">{{junior.name}}</p>
                        </a>
                    </li>
                </ul>
                <p class="icon-wrap">
                    <span class="iconfont icon-xiazhankai" v-if="data.jobs && data.juniors.length > 16" @click="toggleJuniors" :class="{'spread': moreJunior}"></span>
                </p>
            </div>
            <div class="no-one" v-else>
                暂无直接下级
            </div>
        </section>
    </div>
</template>

<style>
    $border: 1px solid #d8dde4;

    .station-info {
        width: 340px;
        height: 100%;
        overflow: auto;
        padding: 40px 30px 0;

        .block {
            border-top: $border;
        }

        .station {
            padding-bottom: 24px;
            border-top: none;

            .sub-title {
                margin-bottom: 10px;
            }
        }

        .icon-wrap {
            text-align: center;
            padding-bottom: 15px;
            color: #bfbfbf;
            cursor: pointer;

            .iconfont {
                display: inline-block;
                transition: transform 0.15s ease-in;

                &.spread {
                    transform: rotate(-180deg);
                }
            }
        }

        .station-list {
            margin-left: 7px;

            $height: 34px;
            li {
                position: relative;
                font-size: 14px;
                color: #666;
                padding-left: 28px;
                line-height: $height;
            }

            &:not(.only) li {
                &:before {
                    content: "";
                    display: block;
                    position: absolute;
                    left: 0;
                    height: 100%;
                    width: 1px;
                    border-left: $border;
                }

                &:first-child:before {
                    height: calc(100% - #{$height} / 2);
                    bottom: 0;
                }

                &:last-child:before {
                    height: calc(#{$height} / 2);
                    top: 0;
                }
            }

            .icon {
                position: absolute;
                font-size: 12px;
                left: -6px;
                color: #4680ff;

                &:before {
                    background: #fff;
                }
            }
        }

        .chief,
        .junior {
            padding-top: 24px;

            .sub-title {
                margin-bottom: 16px;
            }
        }

        $width: 50px;
        $margin: 14px;
        .chief-list,
        .junior-list {
            width: calc(4 * #{$width} + 3 * #{$margin});

            li {
                float: left;
                margin-left: $margin;
                color: #666;
                font-size: 12px;
                text-align: center;
                margin-bottom: 24px;

                &:nth-child(4n + 1) {
                    margin-left: 0;
                }
            }
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }

        .name {
            width: $width;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            height: 20px;
            line-height: 20px;
        }

        .title {
            font-size: 16px;
            color: #999;
            margin-bottom: 14px;
        }

        .sub-title {
            font-size: 12px;
            color: #666;
        }

        .no-one {
            color: #aaa;
            font-size: 12px;
            margin-bottom: 24px;
        }
    }
</style>

<script>
    export default {
        props: ['data'],
        data() {
            return {
                moreChief: false, // 更多上级
                moreJunior: false // 更多下级
            };
        },
        methods: {
            // 上级更多
            toggleChiefs() {
                this.moreChief = !this.moreChief;
            },
            // 下级更多
            toggleJuniors() {
                this.moreJunior = !this.moreJunior;
            }
        }
    }
</script>