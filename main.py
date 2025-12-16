from gui import App
from engine import ClipsHandler

if __name__ == "__main__":
    clips_handler = ClipsHandler(['baza-wiedzy.clp', 'rezultaty.clp'])
    App(clips_handler).mainloop()
