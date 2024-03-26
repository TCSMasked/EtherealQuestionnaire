# EtherealQuestionnaire
This is a simple Garry's Mod addon for the popular DarkRP server called "Ethereal Gaming". This was made soley for Ethereal Gaming so you will have to change the questions.
## Installation 
This addon does not require any third-party dependencies. It will work on any gamemode standalone. To install it to a server all you have to do is download the latest release of the addon on this GitHub repository and put it in this directory of you're Garry's Mod server, `garrysmod/addons`.
## Features
- Customisable configuration file
- SAM Intergration (Round Starter Command)
- Random Math Question Generator
- Random payout for correct answers
## Configuration File
```
// General Config
questionnaire.config.TimeForQuestion = "300" -- This is how long the addon will take before resending a message (e.g 300 = 5mins) | IN SECONDS
questionnaire.config.AnswerRevealTime = "30" -- How long before it reveals the correct answer | IN SECONDS
questionnaire.config.AnsweredNewQuestionTime = "10" -- How many seconds before a new round starts after a question being answered correctly!
questionnaire.config.WinMoneyAmount = "250000" -- This is how much money the winning player will recieve
questionnaire.config.minAmount = 50000 -- Min amount a player could win
questionnaire.config.maxAmount = 250000 -- Maximum amount a player could win

// Color Config
questionnaire.config.prefix = "Questionnaire"
questionnaire.config.colorBrackets = Color(255, 10, 255)
questionnaire.config.prefixColor = Color(0, 10, 255)
questionnaire.config.textColor = Color(255, 255, 255)
```
