import Vue from 'vue';
import error from './404.vue';

new Vue({
    el: '#error-404',
    render: h => h(error)
});