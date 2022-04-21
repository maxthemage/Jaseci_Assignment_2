
walker talker {
    has utterance;

    state {
        std.out(here.message, here.prompts);

        if(here.title == "quit"): disengage;
        utterance = std.input("> ");
        #take  <-[transition(intent == utterance)]- node::state else {
        #    take here;
        #}
        take -[transition(intent == utterance)]-> node::state else {
            take here;
        }

    }
}