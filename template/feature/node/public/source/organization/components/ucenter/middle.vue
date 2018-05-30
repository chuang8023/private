<template>
    <div class="basic-info">
        <section class="contact block">
            <p class="title">联系信息</p>
            <div class="info">
                <div class="row clearfix">
                    <div class="info-item">
                        <p class="label">电话</p>
                        <p class="value">{{phone}}</p>
                    </div>
                    <div class="info-item">
                        <p class="label">QQ</p>
                        <p class="value">{{qq}}</p>
                    </div>
                </div>
                <div class="row clearfix">
                    <div class="info-item">
                        <p class="label">邮箱</p>
                        <!-- <p class="value">{{email}}</p> -->
                        <popper :width="emailPopWidth" :disable="emailPopDisable">
                            {{email}}
                            <p slot="reference" class="value email-ellipsis" ref="email">{{email}}</p>
                        </popper>
                    </div>
                    <div class="info-item">
                        <p class="label">分机号</p>
                        <p class="value">{{ext}}</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="job block">
            <p class="title">工作信息</p>
            <div class="info">
                <div class="row clearfix">
                    <div class="info-item">
                        <p class="label">任职年限</p>
                        <p class="value">{{ageLimit}}</p>
                    </div>
                    <div class="job-addr info-item">
                        <p class="label">地址</p>
                        <popper :width="addPopWidth" :disable="addPopDisable">
                            {{addr}}
                            <p slot="reference" class="value addr-ellipsis" ref="addr">{{addr}}</p>
                        </popper>
                    </div>
                </div>
                <div class="job-des info-item">
                    <p class="label">分工描述</p>
                    <popper :width="desPopWidth" :disable="desPopDisable">
                        {{jobdesc}}
                        <p slot="reference" class="value des-ellipsis" ref="desc">{{jobdesc}}</p>
                    </popper>
                </div>
            </div>
        </section>
    </div>
</template>

<style>
    $border: 1px solid #d8dde4;

    .basic-info {
        box-sizing: border-box;
        width: 560px;
        border-left: $border;
        border-right: $border;

        .title {
            font-size: 16px;
            color: #999;
        }

        .row {
            margin-bottom: 28px;

            .info-item {
                float: left;
                width: 50%;
            }

            &:last-child {
                margin-bottom: 0;
            }
        }

        .block {
            padding: 0 56px 56px;
        }

        .label {
            color: #333;
            font-size: 12px;
            font-weight: bold;
        }

        .value {
            font-size: 14px;
            color: #666;
        }

        .contact {
            padding-top: 40px;
            border-bottom: $border;

            .title {
                margin-bottom: 26px;
            }

            .label {
                margin-bottom: 16px;
            }
        }

        .job {
            padding-top: 24px;

            .title {
                margin-bottom: 18px;
            }

            .label {
                margin-bottom: 18px;
            }
        }

        .job-des .value,
        .job-addr .value,
        .email-ellipsis {
            line-height: 20px;
            word-break: break-all;
        }
    }
</style>

<script>
    const PLACEHOLDER = '--';

    import Ellipsis from 'ellipsis.js';
    import Vue from 'vue';

    import Popper from '../../../global/components/popper.vue';
    import isEllipsis from './is-ellipsis';

    export default {
        props: ['data'],
        components: {
            popper: Popper
        },
        data() {
            return {
                desPopDisable: true,
                desPopWidth: '816px',
                addPopDisable: true,
                addPopWidth: '400px',
                emailPopWidth: '400px',
                emailPopDisable: true

            }
        },
        computed: {
            phone() {
                return this.data.phone || PLACEHOLDER;
            },
            qq() {
                return this.data.qq || PLACEHOLDER;
            },
            email() {
                return this.data.email || PLACEHOLDER;
            },
            ageLimit() {
                return this.data.ageLimit;
            },
            ext() {
                return this.data.ext || PLACEHOLDER;
            },
            addr() {
                return this.data.addr || PLACEHOLDER;
            },
            jobdesc() {
                return this.data.jobdesc || PLACEHOLDER;
            }
        },
        updated() {

            const DESC_LINE = 4;

            // after dom updated
            Ellipsis({
                lines: DESC_LINE,
                class: '.des-ellipsis'
            });

            const ADDR_LINE = 3;
            Ellipsis({
                lines: ADDR_LINE,
                class: '.addr-ellipsis'
            });

            const EMAIL_LINE = 1;
            Ellipsis({
                lines: EMAIL_LINE,
                class: '.email-ellipsis'
            });

            Vue.nextTick(_ => {
                let $desc = this.$refs.desc;
                if (isEllipsis($desc, 20 * DESC_LINE)) {
                    this.desPopDisable = false;
                }

                let $addr = this.$refs.addr;
                if (isEllipsis($addr, 20 * ADDR_LINE)) {
                    this.addPopDisable = false;
                }

                let $email = this.$refs.email;
                if (isEllipsis($email, 20 * EMAIL_LINE)) {
                    this.emailPopDisable = false;
                }
            });
        }
    }
</script>