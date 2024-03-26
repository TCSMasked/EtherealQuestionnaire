sam.command.set_category("Questionnaire Commands")

sam.command.new("startround")
    :SetPermission("startround", "owner")
    :Help("This will force the questionnaire to start a new round!")
    :OnExecute(function(calling_ply)
        QuestionnaireStartQuestion()
    end)
:End()