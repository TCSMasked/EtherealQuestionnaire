AddCSLuaFile()
include("autorun/sh_questionnaire_config.lua")

net.Receive("Questionnaire_ChatMessage", function()
    local msg = net.ReadString()
    chat.AddText(questionnaire.config.colorBrackets, "[", questionnaire.config.prefixColor, questionnaire.config.prefix, questionnaire.config.colorBrackets, "] ", Color(255, 255, 255), msg)
end)

net.Receive("Questionnaire_DarkRPNotification", function()
    local message = net.ReadString()
    notification.AddLegacy(message, NOTIFY_GENERIC, 5)
end)