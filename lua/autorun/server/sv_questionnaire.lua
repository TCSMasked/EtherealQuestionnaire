include("autorun/sh_questionnaire_config.lua")
util.AddNetworkString("Questionnaire_ChatMessage")
util.AddNetworkString("Questionnaire_DarkRPNotification")

local currentQuestionData = nil
local answerRevealTimer = nil

local questions =  {
    {question = "Who owns Ethereal?", answer = "George Gruber"},
}

local function SendChatMessageToClient(msg)
    net.Start("Questionnaire_ChatMessage")
    net.WriteString(msg)
    net.Broadcast()
end

local function Sleep(seconds, callback)
    timer.Simple(seconds, callback)
end

local function AskQuestion()
    currentQuestionData = nil

    local randomNumber = math.random(1, 3)
    if randomNumber == 1 then
        currentQuestionData = table.Random(questions)
    else
        local operand1 = math.random(1, 10)
        local operand2 = math.random(1, 10)
        local operand3 = math.random(1, 10)
        local operation = math.random(1, 5)
        local question, answer
        if operation == 1 then
            question = string.format("%d + %d", operand1, operand2)
            answer = operand1 + operand2
        elseif operation == 2 then
            question = string.format("%d - %d", operand1, operand2)
            answer = operand1 - operand2
        elseif operation == 3 then
            question = string.format("%d * %d", operand1, operand2)
            answer = operand1 * operand2
        elseif operation == 4 then
            question = string.format("%d / %d", operand1 * operand2, operand2)
            answer = operand1
        else
            question = string.format("(%d + %d) * %d", operand1, operand2, operand3)
            answer = (operand1 + operand2) * operand3
        end
        currentQuestionData = {question = question, answer = tostring(answer)}
    end
    
    MsgC(questionnaire.config.colorBrackets, "[", questionnaire.config.prefixColor, "Questionnaire", questionnaire.config.colorBrackets, "] ", Color(255, 255, 255), "New Round Started!\n")
    SendChatMessageToClient(currentQuestionData.question)
    
    if answerRevealTimer then
        timer.Remove(answerRevealTimer)
    end
    
    answerRevealTimer = "AnswerRevealTimer_" .. os.time()
    timer.Create(answerRevealTimer, questionnaire.config.AnswerRevealTime, 1, function()
        MsgC(questionnaire.config.colorBrackets, "[", questionnaire.config.prefixColor, "Questionnaire", questionnaire.config.colorBrackets, "] ", Color(255, 255, 255), "No one was correct. Round ended!\n")
        SendChatMessageToClient("Round Ended! The Correct Answer Was: " .. currentQuestionData.answer)
        currentQuestionData = nil
        timer.Stop("QuestionTimer")
        Sleep(1, function()
            AskQuestion()
        end)
    end)
end

_G.QuestionnaireStartQuestion = function()
    timer.Stop("QuestionTimer")
    AskQuestion()
end

local function QuestionnaireStartQuestionTimed()
    timer.Simple(questionnaire.config.AnsweredNewQuestionTime, function() timer.Stop("QuestionTimer") AskQuestion() end )
end

hook.Add("Initialize", "StartQuestionTimer", function()
    timer.Create("QuestionTimer", questionnaire.config.TimeForQuestion, 0, AskQuestion)
end)

local function SendDarkRPNotificationToClient(ply, message)
    net.Start("Questionnaire_DarkRPNotification")
    net.WriteString(message)
    net.Send(ply)
end

hook.Add("PlayerSay", "CheckAnswer", function(ply, text, team)
    if team then return end
    if currentQuestionData then
        if string.lower(text) == string.lower("// " .. currentQuestionData.answer) or string.lower(text) == string.lower("/ooc " .. currentQuestionData.answer) or string.lower(text) == string.lower("/a " .. currentQuestionData.answer) then
            Sleep(0.1, function()
                SendDarkRPNotificationToClient(ply, "Congratulations! You answered correctly.")
                local randomAmount = math.random(questionnaire.config.minAmount, questionnaire.config.maxAmount)
                ply:addMoney(randomAmount)
                SendChatMessageToClient("Player " .. ply:Nick() .. " Won The Round!")
                MsgC(questionnaire.config.colorBrackets, "[", questionnaire.config.prefixColor, "Questionnaire", questionnaire.config.colorBrackets, "] ", questionnaire.config.textColor, "Player " .. ply:Nick() .. " Won The Round!\n")
                if answerRevealTimer then
                    timer.Remove(answerRevealTimer)
                end
                currentQuestionData = nil
                QuestionnaireStartQuestionTimed()
            end)
        end
    else
        return
    end
end)

hook.Add("Initialize", "QuestionnaireServerStartLoader", function()
    AskQuestion()
end)