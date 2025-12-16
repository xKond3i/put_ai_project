import clips

class ClipsHandler:
    def __init__(self, files):
        self.env = clips.Environment()
        self.files = files
        self.loaded = False

    def load(self):
        if self.loaded:
            return
        for f in self.files:
            self.env.load(f)
        self.loaded = True

    def start(self):
        self.load()
        self.env.reset()
        self.env.run()
        return self.get_state()

    def reset(self):
        self.env.reset()
        self.env.run()
        return self.get_state()

    def submit_answer(self, key, value):
        self._remove_questions()
        fact = self._make_fact(key, value)
        self.env.assert_string(fact)
        self.env.run()
        return self.get_state()

    # -------- state --------

    def get_state(self):
        # to be implemented
        return
