---@diagnostic disable: undefined-global

local helper = require("snippets.utils.helper")

return {
    s("todo", t("TODO: ")),
    s("fix", t("FIX: ")),
    s("note", t("NOTE: ")),
}
