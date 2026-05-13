local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("php", {
    s("dd", { t('echo"<pre>";print_r('), i(1, "get_defined_vars()"), t(");die;"), i(2) }),
    s("copy", {
        t({
            " * @author     Kevin Pham <kevinpham@catalyst-au.net>",
            " * @copyright  Catalyst IT, " .. os.date("%Y"),
        }),
    }),
    s("cpr", {
        t({
            " * @author     Kevin Pham <kevinpham@catalyst-au.net>",
            " * @copyright  Catalyst IT, " .. os.date("%Y"),
        }),
    }),
    s("copyright", {
        t({
            " * @author     Kevin Pham <kevinpham@catalyst-au.net>",
            " * @copyright  Catalyst IT, " .. os.date("%Y"),
        }),
    }),
    s("version", { t(os.date("%Y%m%d00")) }),
    s("dt", { t(os.date("%Y%m%d00")) }),
    s("time", { t(os.date("%Y%m%d00")) }),
})
