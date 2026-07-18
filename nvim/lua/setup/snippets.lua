local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local cf_off_on = s("cf", {
  t("// clang-format off"),
  t({ "", "" }),
  i(1),
  t({ "", "" }),
  t("// clang-format on"),
})

local cf_export = s("ce", {
  i(1), t("// IWYU pragma: export")
})

for _, ft in ipairs({ "c", "cpp", "h", "hpp" }) do
  ls.add_snippets(ft, { cf_off_on, cf_export })
end
