#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import clips

import tkinter as tk
import ctypes

import sys

class WineExpertGUI:
    def __init__(self, root):
        self.root = root
        
        # --- okno ---
        self.root.title("Wine Expert")
        self.root.geometry("650x550")
        self.root.resizable(False, False)

        # --- ikona aplikacji ---
        try: ctypes.windll.shell32.SetCurrentProcessExplicitAppUserModelID('tkinter.python.wine.expert.app')
        except: pass
        try: self.root.iconbitmap("icon.ico")
        except: pass
        else: self.root.iconphoto(True, tk.PhotoImage(file="icon.png"))
        
        # --- CLIPS ---
        self.env = clips.Environment()
        
        # Load knowledge base
        try:
            for f in ['questions.clp', 'recommendations.clp']: self.env.load(f)
        except Exception as e:
            print(f"[err] failed to load CLIPS: {e}")
            sys.exit(-1)

        self.env.reset()
        
        # --- widgets ---
        self.answer_var = tk.StringVar(value=-1)
        self.current_param = None
        self.create_widgets()

        # --- start processing clips :)
        self.process_clips()
    
    def create_widgets(self):
        """create GUI components"""
        # --- header ---
        header_frame = tk.Frame(self.root, bg='#8B0000', height=70)
        header_frame.pack(fill=tk.X)
        header_frame.pack_propagate(False)
        
        title_label = tk.Label(
            header_frame, 
            text="🍷 Wine Expert System",
            font=('Arial', 20, 'bold'),
            bg='#8B0000',
            fg='white'
        )
        title_label.pack(expand=True)
        
        # Main frame
        self.main_frame = tk.Frame(self.root, padx=20, pady=20, bg='white')
        self.main_frame.pack(fill=tk.BOTH, expand=True)
        
        # Question label
        self.question_label = tk.Label(
            self.main_frame,
            text="",
            font=('Arial', 13, 'bold'),
            wraplength=600,
            justify=tk.LEFT,
            bg='white',
            fg='#2C3E50'
        )
        self.question_label.pack(pady=(0, 15))
        
        # Options frame
        self.options_frame = tk.Frame(self.main_frame, bg='white')
        self.options_frame.pack(fill=tk.BOTH, expand=True)
        
        # Buttons frame
        button_frame = tk.Frame(self.main_frame, bg='white')
        button_frame.pack(pady=(15, 0))
        
        self.submit_button = tk.Button(
            button_frame,
            text="Submit Answer",
            command=self.submit_answer,
            font=('Arial', 11, 'bold'),
            bg='#27AE60',
            fg='white',
            padx=20,
            pady=8,
            cursor='hand2',
            relief=tk.FLAT
        )
        self.submit_button.pack(side=tk.LEFT, padx=10)
        
        self.reset_button = tk.Button(
            button_frame,
            text="Start Over",
            command=self.reset_system,
            font=('Arial', 11, 'bold'),
            bg='#E74C3C',
            fg='white',
            padx=20,
            pady=8,
            cursor='hand2',
            relief=tk.FLAT
        )
        self.reset_button.pack(side=tk.LEFT, padx=10)
    
    def process_clips(self):
        """Run CLIPS and parse output"""
        # Run CLIPS
        self.env.run()
        
        # Check all facts for questions/recommendations
        found_question = False
        found_recommendation = False
        
        for fact in self.env.facts():
            fact_str = str(fact)
            
            # Look for question pattern: (question "QUESTION|...")
            if fact_str.startswith('(question '):
                # Extract content between quotes
                if '"' in fact_str:
                    content = fact_str.split('"')[1]
                    if content.startswith('QUESTION|'):
                        self.show_question(content)
                        fact.retract()  # Remove question fact
                        found_question = True
                        break
            
            # Look for recommendation pattern: (recommendation "RECOMMENDATION|...")
            elif fact_str.startswith('(recommendation '):
                if '"' in fact_str:
                    content = fact_str.split('"')[1]
                    if content.startswith('RECOMMENDATION|'):
                        self.show_recommendation(content)
                        found_recommendation = True
                        break
        
        if not found_question and not found_recommendation:
            # Check if there are any unknowns left
            has_unknowns = any('unknown' in str(f) for f in self.env.facts())
            if not has_unknowns:
                self.question_label.config(text="⚠️ No recommendation found. Please restart.")
    
    def show_question(self, line):
        """Parse and display question from CLIPS"""
        # Clear previous options
        for widget in self.options_frame.winfo_children():
            widget.destroy()
        
        self.answer_var.set('')
        
        # Parse: QUESTION|param|question_text|val1|text1|val2|text2|...
        parts = line.split('|')
        
        if len(parts) < 3:
            return
        
        self.current_param = parts[1]
        question_text = parts[2]
        
        # Extract options (pairs of value|display_text)
        options = []
        for i in range(3, len(parts), 2):
            if i + 1 < len(parts):
                value = parts[i]
                display = parts[i + 1]
                options.append((display, value))
        
        # Display question
        self.question_label.config(text=question_text)
        
        # Display options as radio buttons
        for display_text, value in options:
            rb = tk.Radiobutton(
                self.options_frame,
                text=display_text,
                variable=self.answer_var,
                value=value,
                font=('Arial', 11),
                padx=10,
                pady=5,
                anchor='w',
                bg='white',
                fg='#34495E',
                selectcolor='#ECF0F1',
                activebackground='white',
                activeforeground='#2C3E50',
                cursor='hand2'
            )
            rb.pack(fill=tk.X, pady=2)
        
        self.submit_button.config(state=tk.NORMAL)
    
    def show_recommendation(self, line):
        """Display final recommendation"""
        # Clear frame
        for widget in self.options_frame.winfo_children():
            widget.destroy()
        
        # Parse: RECOMMENDATION|text
        parts = line.split('|', 1)
        rec_text = parts[1] if len(parts) > 1 else "No recommendation"
        
        self.question_label.config(text="🎉 Your Recommendation:")
        self.submit_button.config(state=tk.DISABLED)
        
        # Create recommendation display
        rec_frame = tk.Frame(
            self.options_frame, 
            relief=tk.RAISED, 
            borderwidth=3, 
            bg='#FFFACD',
            highlightbackground='#8B0000',
            highlightthickness=2
        )
        rec_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)
        
        rec_label = tk.Label(
            rec_frame,
            text=rec_text,
            font=('Arial', 16, 'bold'),
            bg='#FFFACD',
            fg='#8B0000',
            wraplength=550,
            justify=tk.CENTER,
            pady=40
        )
        rec_label.pack(expand=True)
    
    def submit_answer(self):
        """Submit answer to CLIPS"""
        answer = self.answer_var.get()
        
        if not answer:
            return
        
        # Assert answer to CLIPS
        self.env.assert_string(f'({self.current_param} {answer})')
        
        # Process next step
        self.process_clips()
    
    def reset_system(self):
        """Reset system"""
        self.env.reset()
        self.submit_button.config(state=tk.NORMAL)
        self.process_clips()


def main():
    root = tk.Tk()
    app = WineExpertGUI(root)
    root.mainloop()


if __name__ == '__main__':
    main()
