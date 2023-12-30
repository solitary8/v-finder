import tkinter as tk
from tkinter import ttk
#setting up
a = 0 
root = tk.Tk()
root.title("Scan Status")
bar = ttk.Progressbar(mode="indeterminate")
bar.place(x=30, y=60, width=200)
root.geometry("300x200")
bar.start()

root.mainloop()
