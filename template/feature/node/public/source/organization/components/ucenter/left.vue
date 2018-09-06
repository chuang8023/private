    <template>
    <div class="card">
        <img class="avatar" :src="data.avatar">
        <div class="name">
            <p class="zh-name">
                <span class="real-name" :title="data.real_name">{{data.real_name}}</span>
                <span class="iconfont" v-if="data.sex !== undefined" :class="data.sex === 1 ? 'icon-nv' : 'icon-MAN'"></span>
            </p>
            <p class="spell-name">
                {{data.pinying}}
            </p>
        </div>

        <div class="signature">
            <popper :width="popWidth">
                {{data.sign || '暂无签名'}}
                <p slot="reference" class="sign-text" ref="sign">{{data.sign || '暂无签名'}}</p>
            </popper>
        </div>

        <div class="intimacy" :class="{hidden: self}">
            <span class="count">{{data.intimacyNum || 0}}</span>
            <span class="mark"><i class="iconfont icon-shangyi"></i>亲密度</span>
        </div>

        <div class="intersection" :class="{hidden: self}">
            <p class="job">
                <span class="count">{{data.workNum || 0}}</span> 条
                <span class="mark">共同工作</span>
            </p>
            <p class="talk">
                <span class="count">{{data.communicateNum || 0}}</span> 条
                <span class="mark">互动沟通</span>
            </p>
        </div>

        <a class="back" href="/organization/contacts">返回通讯录</a>
    </div>
</template>

<style scoped>
    .card {
        width: 300px;
        text-align: center;
        padding-top: 50px;

        .hidden {
            visibility: hidden;
        }

        .avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
        }

        /* 内容固定高度 */

        .name {
            margin: 24px 0 8px 0;

            .zh-name {
                position: relative;
                font-size: 22px;

                .real-name {
                    display: inline-block;
                    max-width: 110px;
                    overflow: hidden;
                    white-space: nowrap;
                    text-overflow: ellipsis;
                    vertical-align: bottom;
                    height: 26px;
                }

                .iconfont {
                    position: absolute;
                    bottom: 4px;
                    margin-left: 10px;
                }

                .icon-MAN {
                    color: #00b0f5;
                }

                .icon-nv {
                    color: #ef6651;
                }
            }

            .spell-name {
                font-size: 14px;
                line-height: 20px;
                height: 20px;
            }
        }

        .signature {
            font-size: 12px;
            color: #999;
            line-height: 20px;
            height: 40px;
            text-align: left;
            padding: 0 90px;

            .sign-text {
                max-width: 120px;
                margin: 0 auto;
                word-wrap: break-word;
            }
        }

        .count {
            color: #ff8c31;
        }

        .mark {
            color: #999;
        }

        .intimacy {
            margin-top: 42px;
            margin-bottom: 16px;
            height: 40px;

            .count {
                font-size: 40px;
            }

            .mark {
                position: relative;

                .iconfont {
                    position: absolute;
                    color: #fa4e51;
                }
            }
        }

        .intersection {
            line-height: 30px;
            height: 60px;
            margin-bottom: 24px;
            font-size: 16px;
            color: #666;

            .mark {
                font-size: 14px;
            }
        }

        .back {
            display: block;
            width: 104px;
            height: 32px;
            line-height: 32px;
            text-align: center;
            color: #fff;
            background-color: #4680ff;
            font-size: 16px;
            margin: 0 auto;
            border-radius: 2px;
        }
    }
</style>

<script>
    import Ellipsis from 'ellipsis.js';
    import Vue from 'vue';

    import Popper from '../../../global/components/popper.vue';
    import isEllipsis from './is-ellipsis';

    export default {
        props: ['data', 'self'],
        data() {
            return {
                popDisable: true,
                popWidth: '200px'
            }
        },
        components: {
            popper: Popper
        },
        updated() {
            const LINE = 2;

            Ellipsis({
                lines: LINE,
                class: '.sign-text'
            });

            Vue.nextTick(_ => {
                let $sign = this.$refs.sign;
                if (isEllipsis($sign, 20 * LINE)) {
                    this.popDisable = false;
                }
            });
        }
    }
</script>
