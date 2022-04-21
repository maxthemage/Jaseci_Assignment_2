
walker talker {
    has utterance, answers, question;
    can use.enc_question, use.enc_answer;

    state {
        std.out(here.message, here.prompts);

        question = here.message;
        answers = here.prompts;

        que_enc = use.enc_question(question);
        ans_enc = use.enc_answer(answers);

        if(here.title == "Quit"): disengage;
        utterance = std.input("> ");
        if utterance == "back": take <-- node::state;
        #take node::state <-[transition(intent == utterance)]- else {
        #    take here;
        #}
        take <-[transition(intent == utterance)]-> node::state else {
            take here;
        }

    }
}