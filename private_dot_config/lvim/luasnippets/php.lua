-- DOCS:
-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#textnode
return {
    s('dd', { t('echo"<pre>";print_r('), i(1, 'get_defined_vars()'), t(');die;'), i(2) }),
    s('copy', {
        t({
            ' * @author    Kevin Pham <kevinpham@catalyst-au.net>',
            ' * @copyright Catalyst IT, 2023'
        }),
    }),
    s('version', { t(os.date("%Y%m%d00")) }),
    s('dt', { t(os.date("%Y%m%d00")) }),
    s('time', { t(os.date("%Y%m%d00")) }),
}
