import tkinter as tk
from tkinter import ttk
import ctypes


class App(tk.Tk):
    def __init__(self, clips_handler):
        super().__init__()
        self.clips_handler = clips_handler
        self.title("Wine Expert")
        self.geometry("600x400")

        # --- ikona aplikacji ---
        try: ctypes.windll.shell32.SetCurrentProcessExplicitAppUserModelID('tkinter.python.wine.expert.app')
        except: pass
        try: self.iconbitmap("icon.ico")
        except: pass
        else: self.iconphoto(True, tk.PhotoImage(file="icon.png"))

        # --- stan aplikacji ---
        self.qid = 1
        self.selected_answer = tk.StringVar(value="")

        # --- UI ---
        self.question_lbl = ttk.Label(
            self, text="1. Question Placeholder", wraplength=500, font=("Segoe UI", 16)
        )
        self.question_lbl.pack(pady=24)

        self.options_frame = ttk.Frame(self)
        self.options_frame.pack(pady=6)

        self.actions_frame = ttk.Frame(self)
        self.actions_frame.pack(pady=10)

        self.submit_btn = ttk.Button(self.actions_frame, text="Zatwierdź odpowiedź", command=self.on_submit)
        self.submit_btn.pack(side=tk.LEFT, padx=8)

        self.reset_btn = ttk.Button(self.actions_frame, text="Reset", command=self.on_reset)
        self.reset_btn.pack(side=tk.LEFT, padx=8)

        self.result_lbl = ttk.Label(self, text="", wraplength=500, font=("Segoe UI", 12))
        self.result_lbl.pack(pady=24)

        self.render(self.qid)

    # --- helpers UI ---
    def clear_options(self):
        for w in self.options_frame.winfo_children():
            w.destroy()

    def set_submit_enabled(self, enabled: bool):
        self.submit_btn.config(state=tk.NORMAL if enabled else tk.DISABLED)

    # --- render ---
    def render(self, qid: int = 1):
        self.qid = qid
        self.clear_options()
        self.selected_answer.set("")
        self.set_submit_enabled(False)

        # TODO: to ciągnąć z CLIPSa
        question = "Silly little question?"
        result = "Still figuring out your wine type..."
        options = ["A", "B", "C"]

        self.question_lbl.config(text=f"{qid}. {question}")
        self.result_lbl.config(text=result)

        for opt in options:
            rb = ttk.Radiobutton(
                self.options_frame,
                text=opt,
                value=opt,
                variable=self.selected_answer,
                command=self.on_select_option,
            )
            rb.pack(anchor="w", padx=24, pady=4)

    # --- events ---
    def on_select_option(self):
        self.set_submit_enabled(self.selected_answer.get() != "")

    def on_submit(self):
        value = self.selected_answer.get()
        if not value: return

        self.on_answer(self.qid, value)

    def on_answer(self, qid: int, value: str):
        self.render(qid + 1)

    def on_reset(self):
        self.result_lbl.config(text="")
        self.render(1)


if __name__ == "__main__":
    App().mainloop()
