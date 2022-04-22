
walker talker {
    has utterance, answers, question;
    can use.enc_question, use.enc_answer;

    state {
        std.out(here.message, here.prompts);
        answers = here.prompts;
        answer_scores = [];

        if(here.title == "Quit"): disengage;
        utterance = std.input("> ");
        question = utterance;
        
        que_enc = use.enc_question(question);
        ans_enc = use.enc_answer(answers);

        for i in ans_enc:
            answer_scores.l::append(vector.cosine_sim(que_enc, i));

        max_score = answer_scores[0];
        for num in answer_scores:
            if(num > max_score): max_score = num;
        index = answer_scores.list::index(max_score);
        take -[transition(intent == answers[index])]-> node::state else { #instead of using utterance replace with prompt that has the highest number from the encoder
            take here;
        }

        if utterance == "back": take <-- node::state;
        #take node::state <-[transition(intent == utterance)]- else {
        #    take here;
        #}
        #take <-[transition(intent == utterance)]-> node::state else {
        #    take here;
        #}

    }
}