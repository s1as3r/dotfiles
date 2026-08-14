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

local scratch_begin = s("sb", {
  t("Temp "),
  i(1, "scratch"),
  t(" = scratch_begin("),
  i(2, "0"),
  t(", "),
  i(3, "0"),
  t(")")
})

for _, ft in ipairs({ "c", "cpp", "h", "hpp" }) do
  ls.add_snippets(ft, { cf_off_on, cf_export, scratch_begin })
end
