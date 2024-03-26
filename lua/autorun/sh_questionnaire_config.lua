--[[
Created by
_______ _____  _____ __  __           _            _ 
|__   __/ ____|/ ____|  \/  |         | |          | |
   | | | |    | (___ | \  / | __ _ ___| | _____  __| |
   | | | |     \___ \| |\/| |/ _` / __| |/ / _ \/ _` |
   | | | |____ ____) | |  | | (_| \__ \   <  __/ (_| |
   |_|  \_____|_____/|_|  |_|\__,_|___/_|\_\___|\__,_|
]]--

questionnaire = {}
questionnaire.config = {}
questionnaire.author = "TCSMasked"
questionnaire.description = "A custom chat-based questionnaire addon for Ethereal Gaming."

// General Config
questionnaire.config.TimeForQuestion = "300" -- This is how long the addon will take before resending a message (e.g 300 = 5mins) | IN SECONDS
questionnaire.config.AnswerRevealTime = "30" -- How long before it reveals the correct answer | IN SECONDS
questionnaire.config.AnsweredNewQuestionTime = "10" -- How many seconds before a new round starts after a question being answered correctly!
questionnaire.config.WinMoneyAmount = "250000" -- This is how much money the winning player will recieve
questionnaire.config.minAmount = 50000
questionnaire.config.maxAmount = 250000

// Color Config
questionnaire.config.prefix = "Questionnaire"
questionnaire.config.colorBrackets = Color(255, 10, 255)
questionnaire.config.prefixColor = Color(0, 10, 255)
questionnaire.config.textColor = Color(255, 255, 255)