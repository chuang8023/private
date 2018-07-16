<template>
    <div class="x-popper">
        <div class="popper" ref="popper" v-show="!disable && show" :style="{width: width}">
            <slot></slot>
        </div>
        <slot name="reference"></slot>
    </div>
</template>

<style>
    .x-popper {
        position: relative;

        .popper {
            box-sizing: border-box;
            position: absolute;
            border: 1px solid #dcdcdc;
            background: #fff;
            font-size: 12px;
            line-height: 16px;
            padding: 15px;
            text-align: left;
            z-index: 99;
            color: #b3b3b3;
            word-wrap: break-word;

            &:after {
                content: "";
                position: absolute;
                border: 10px solid transparent;
                border-bottom-color: #fff;
                left: 10px;
                top: -20px;
            }

            &:before {
                content: "";
                position: absolute;
                border: 10px solid transparent;
                border-bottom-color: #ccc;
                left: 10px;
                top: -21px;
            }
        }
    }
</style>

<script>
    import Vue from 'vue';

    const on = (el, event, handler) => {
        if (el && event && handler) {
            document.addEventListener ?
                el.addEventListener(event, handler, false) :
                el.attachEvent('on' + event, handler);
        }
    };

    export default {
        props: {
            disable: {
                type: Boolean,
                default: false
            },
            width: {
                type: String,
                default: ''
            }
        },
        data() {
            return {
                show: false
            }
        },
        mounted() {
            Vue.nextTick(_ => {

                let $popper = this.$refs.popper;

                let $trigger = this.$slots.reference[0].elm;

                on($trigger, 'mouseover', _ => {
                    let {offsetWidth, offsetHeight} = $trigger;

                    $popper.style.top = offsetHeight + 10 + 'px';

                    this.show = true;
                });

                on($trigger, 'mouseout', _ => {
                    this.show = false;
                });
            });
        }
    }
</script>