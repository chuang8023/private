/**
 * 判断文字是否超出指定高度并应用了Ellipsis
 * FOR: popper是否disable
 */

// 高度达最大高度&以...结尾
// 好假 我自己都不信了
const isEllipsis = ($el, height) => {
    if ($el) {
        let {innerText, offsetHeight} = $el;

        if (/…$/.test(innerText) && offsetHeight === height) {
            return true;
        }
    }

    return false;
};

export default isEllipsis;
