
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

        take -[transition(intent == )]-> node::state else { #instead of using utterance replace with prompt that has the highest number from the encoder
            take here;
        }


    }
}