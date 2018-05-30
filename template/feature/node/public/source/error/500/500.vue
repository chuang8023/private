<template>
    <div class="error-500">
        <div class="show-img"></div>
        <a href="/user/workbench"></a>
    </div>
</template>

<style scoped>
    .show-img {
        height: 272px;
        background: url('./img/500.png') no-repeat center center;
    }
    
    .error-500 a {
        display: block;
        width: 288px;
        height: 47px;
        margin: 20px auto 0;
        box-sizing: border-box;
        border-left: 10px solid white;
        background: url('../404/img/error-return.png') no-repeat center center;
        cursor: pointer;
    }
    
    .error-500 {
        position: absolute;
        left: calc(50% - 288px / 2);
        top: calc(50% - 339px / 2);
    }
</style>