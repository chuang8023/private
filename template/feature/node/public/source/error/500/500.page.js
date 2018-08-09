import Vue from 'vue';
import error from './500.vue';

new Vue({
    el: '#error-500',
    render: h => h(error)
});