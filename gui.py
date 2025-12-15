import tkinter as tk
from tkinter import ttk

class App(tk.Tk):
    def __init__(self) -> None:
        super().__init__()
        self.title("Wine Expert")
        self.geometry("600x400")
        self.iconphoto(True, tk.PhotoImage(file="icon.png"))

        self.question_lbl = ttk.Label(self, text="1. Question Placeholder", wraplength=500, font=("Segoe UI", 16))
        self.question_lbl.pack(pady=24)

        self.buttons_frame = ttk.Frame(self)
        self.buttons_frame.pack()

        self.result_lbl = ttk.Label(self, text="", wraplength=500, font=("Segoe UI", 12))
        self.result_lbl.pack(pady=24)

        self.render()

    def clear_buttons(self):
        for w in self.buttons_frame.winfo_children():
            w.destroy()

    def render(self, qid = 1):
        self.clear_buttons()

        question = "Silly little question?"
        result = "Still figuring out your wine type..."
        options = ["A", "B", "C"]

        self.question_lbl.config(text=f'{qid}. {question}')
        self.result_lbl.config(text=result)

        for opt in options:
            b = ttk.Button(self.buttons_frame, text=opt, command=lambda o=opt, qid=qid: self.on_answer(qid, o))
            b.pack(side=tk.LEFT, padx=16)

    def on_answer(self, qid, value):
        self.render(qid+1)
