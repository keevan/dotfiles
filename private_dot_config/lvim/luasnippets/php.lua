-- DOCS:
-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#textnode
return {
    s('dd', { t('echo"<pre>";print_r(${1:get_defined_vars()});die;') }),
    s('copy', {
        t({
            ' * @author    Kevin Pham <kevinpham@catalyst-au.net>',
            ' * @copyright Catalyst IT, 2023'
        }),
    }),
}
