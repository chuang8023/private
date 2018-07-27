<template>
    <div class="ucenter-app">
        <section class="main clearfix">
            <left :data="left" :self="self"></left>
            <middle :data="middle"></middle>
            <right :data="right"></right>
        </section>

        <u-and-me v-if="!self"></u-and-me>
    </div>
</template>


<style>
    .ucenter-app {
        margin: 24px 0;

        .main {
            height: 560px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
            border-radius: 5px;

            > * {
                float: left;
                box-sizing: border-box;
                height: 100%;
            }
        }
    }

</style>

<script>
    import Vue from 'vue';
    import Resource from 'vue-resource';

    import Left from './left.vue';
    import Middle from './middle.vue';
    import Right from './right.vue';

    import YouAndMe from './u-and-me.vue';

    Vue.use(Resource);

    export default {
        data() {
            return {
                left: {},
                middle: {},
                right: {},
                self: true
            }
        },
        components: {
            left: Left,
            middle: Middle,
            right: Right,
            'u-and-me': YouAndMe
        },
        created() {
            let id = location.pathname.replace(/\/organization\/usercontactinfo\//, '');

            this.$http.get(`/organization/usercontactinfo/info/${id}`).then(response => {
                if (response.ok) {
                    let {left, middle, right, self} = response.body;

                    this.left = left;
                    this.middle = middle;
                    this.right = right;
                    this.self = self; //是否为自身
                }
            });
        }
    }
</script>

