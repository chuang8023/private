<template>
    <div class="error-404">
        <div class="show-img"></div>
        <a href="/user/workbench"></a>
    </div>
</template>

<script>
    export default {
        name: 'error-404',
        data() {
            return {
                showApp: true,
                isSysAdmin: false,
            }
        }
    }
</script>

<style scoped>
    .show-img {
        height: 199px;
        background: url('./img/error-title.png') no-repeat center center;
    }
    
    .error-404 a {
        display: block;
        width: 455px;
        height: 63px;
        margin: 0 auto;
        box-sizing: border-box;
        border-left: 10px solid white;
        background: url('./img/error-return.png') no-repeat center center;
        cursor: pointer;
    }
    
    .error-404 {
        position: absolute;
        left: calc(50% - 450px / 2);
        top: calc(50% - 262px / 2);
    }
</style>