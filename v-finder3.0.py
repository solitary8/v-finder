#Features to add : 

# button for modes :
#position : probably top left 
#available modes will be normal(default) and advanced (where the user can customise the nmap options)

# button for configuring scan types :
#position : either at left or right of the button to select scan types (only available in advanced mode)
#customisation would be :
#nmap options
# name of  config

# repetition button and vriations in scans :
# position : under or at the side
#the user would be able to repeat scan and also to add a variation in the following scans
#customisation would be :
#scan 1 : basic options : scan2 : user would be able to change the options etc. with all options

import tkinter as tk 
import customtkinter
import subprocess
import time
import threading 
root = customtkinter.CTk()
root.title("V-finder")
subprocess.run('source','.venv.sh', shell=False)
#Definition of frame

#quit tool function
def quit_tool():
    root.quit()

customtkinter.set_appearance_mode("Dark")
customtkinter.set_default_color_theme("green")
root.geometry("1200x800")




def distro():
    result = subprocess.run(["bash", "distro.sh"], capture_output=True, text=True)
    if "Debian" in result.stdout.strip():
        command = f'sudo nmap {text} -oN results.txt'
        terminal_command = f'lxterminal -e "{command}; read -p \'Press Enter to close...\'"' 
        process = subprocess.Popen(terminal_command, shell=True)
        process.wait()

    elif "Ubuntu" in result.stdout.strip():
        command = f'sudo nmap {text} -oN results.txt'
        terminal_command = f'xterm -e bash -c"{command}; read -p \'Press Enter to close...\'"'
        subprocess.Popen(terminal_command, shell=True)

    elif "Kali" or "Fedora" in result.stdout.strip():
        command = f'sudo nmap {text} -oN results.txt'
        terminal_command = f'gnome-terminal -- bash -c"{command}; read -p \'Press Enter to close...\'"'
        subprocess.Popen(terminal_command, shell=True)

    elif "Manjaro" in result.stdout.strip():
        command = f'sudo nmap {text} -oN results.txt'
        terminal_command = f'konsole --hold -e  -- bash -c"{command}; read -p\'Press Enter to close...\'"'
        subprocess.Popen(terminal_command, shell=True)

def option():
    scan_type = my_combo.get()
    if scan_type in ["Normal", "Advanced", "Aggressive", "Hardcore", "Stealth"]:
        distro()

    else:
        print("Combo box error")


#def start_progress():
#    global progress
#    progress.start()

#def stop_progress():
#    global progress
#    progress.stop()
#    root.after(0, stop_progress)

def ask_for_ip():
    #That's the small window dialog that pops up and ask for ip
    global text
    dialog = customtkinter.CTkInputDialog(text="Type the ip to scan ", title="IP Entry")
    text = dialog.get_input()


#This function defines what happens whzn the start scan button is clicked,
# normally it launches the scan with the details given by the user 
# but for the moment I can't get python to open a new terminal 
# and then run the scan from there or I would like to display the result in the ui itself but for the moment it's too complicated because I would also need to filter the output.



def start_scan():
    global text
    global command
    global terminal_command
    global progress 

    init_scan.configure(root, text="Initiating Scan...")
    init_scan.update()
    #progress = customtkinter.CTkProgressBar(root, orientation="horizontal", mode="inderterminate",progress_color="#00ff00")
    #progress.pack(pady=12, padx=10)
    #threading.Thread(target=start_progress).start()
    option()
    stop()

def stop():
    init_scan.configure(root, text="Start Scan")

#this function enable the start scan button after the user checks the box saying that if he gets arrested it's his fault not the maker's fault
def enable_start_scan_button():
    init_scan.configure(state="normal")


#That's the label with the title
custom_font = customtkinter.CTkFont(family="Roboto", size=50) 
 
label = customtkinter.CTkLabel(root, text="V-Finder", font=custom_font, text_color="#00ff00")
label.pack(pady=12, padx=10)


ip_prompt_button = customtkinter.CTkButton(root, text="Enter Ip", fg_color="black", text_color="white", hover_color="blue", command=ask_for_ip )
ip_prompt_button.pack(pady=12, padx=10)

#combo box for selecting scan type
combo = customtkinter.CTkLabel(root, text="Pick a scan type")
combo.pack(pady=5, padx=10)

scan_type = ["Normal", "Advanced", "Aggressive", "Hardcore", "Stealth"]
my_combo = customtkinter.CTkComboBox(root, values=scan_type)
my_combo.pack(pady=5, padx=10)


#other options for experienced users only
#other_options = customtkinter.CTkEntry(master=frame, placeholder_text="Other Options", bg_color="black", border_color="black", text_color="#00ff00", fg_color="black")
#other_options.pack(pady=12, padx=20)


#checkbox
check_var = customtkinter.StringVar(value="off")
checkbox = customtkinter.CTkCheckBox(root, text="I Take on full responsibility if I do any illegal stuff and get arrested.", onvalue="on", offvalue="off", variable=check_var, command=enable_start_scan_button )
checkbox.pack(pady=12, padx=10)


#Start Scan button
init_scan = customtkinter.CTkButton(root, text="Start Scan", fg_color='red', hover_color='green', command=start_scan, state="disabled")
init_scan.pack(pady=12, padx=10)

#quit tool button
quit_button = customtkinter.CTkButton(root, text="Exit", hover_color='red', command=quit_tool)
quit_button.pack(pady=0, padx=100)




root.mainloop()

