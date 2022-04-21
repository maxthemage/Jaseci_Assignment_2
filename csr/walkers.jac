
walker talker {
    has utterance, answers, question, answer;
    can use.enc_question, use.enc_answer, net.max;

    state {
        std.out(here.message, here.prompts);
        answer_scores = [];

        if(here.title == "Quit"): disengage;
        utterance = std.input("> ");

        answers = here.prompts;
        question = utterance;

        que_enc = use.enc_question(question);
        ans_enc = use.enc_answer(answers);

        for i in ans_enc:
            answer_scores.l::append(vector.cosine_sim(que_enc, i));
        std.out(net.max(answer_scores));

        take -[transition(intent == utterance)]-> node::state else {
            take here;
        }


    }
}