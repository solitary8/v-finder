# Features to add

# button for modes:
#   position: probably top left 
#   available modes:
#     - normal (default)
#     - advanced (user can customise the nmap options)

# button for configuring scan types:
#   position: either at left or right of the button to select scan types (only available in advanced mode)
#   customisation:
#     - nmap options
#     - name of config

# repetition button and variations in scans:
#   the user would be able to repeat scan and add a variation in subsequent scans
#   position: under or at the side
#   customization:
#     - scan 1: basic options
#     - scan 2: user would be able to change the options etc. with all options

import tkinter as tk
import customtkinter
import subprocess

def get_distro():
    """Retrieve the Linux distribution name."""
    try:
        result = subprocess.run(
            ["awk", "-F=", "/^NAME/{gsub(/\"/,\"\",$2); print $2}", "/etc/os-release"],
            capture_output=True,
            text=True,
            check=True
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError:
        print("Failed to determine the Linux distribution.")
        return None

def check_nmap():
    """Check if nmap is installed on the system."""
    try:
        subprocess.run(["nmap", "-v"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, check=True)
        return True
    except subprocess.CalledProcessError:
        print("nmap is not installed. Please install nmap to use this script.")
        return False

class VFinderApp:
    def __init__(self, root):
        self.root = root
        self.root.title("V-finder")
        customtkinter.set_appearance_mode("Dark")
        customtkinter.set_default_color_theme("green")
        self.root.geometry("1200x800")

        self.text = ""

        self.setup_ui()

    def setup_ui(self):
        custom_font = customtkinter.CTkFont(family="Roboto", size=50) 
        label = customtkinter.CTkLabel(self.root, text="V-Finder", font=custom_font, text_color="#00ff00")
        label.pack(pady=12, padx=10)

        self.ip_prompt_button = customtkinter.CTkButton(self.root, text="Enter IP", fg_color="black", text_color="white", hover_color="blue", command=self.ask_for_ip)
        self.ip_prompt_button.pack(pady=12, padx=10)

        combo_label = customtkinter.CTkLabel(self.root, text="Pick a scan type")
        combo_label.pack(pady=5, padx=10)

        scan_types = ["Normal", "Advanced", "Aggressive", "Hardcore", "Stealth"]
        self.scan_type_combo = customtkinter.CTkComboBox(self.root, values=scan_types)
        self.scan_type_combo.pack(pady=5, padx=10)

        self.checkbox = customtkinter.CTkCheckBox(self.root, text="I take full responsibility if I do any illegal stuff and get arrested.", onvalue="on", offvalue="off", command=self.toggle_start_scan_button)
        self.checkbox.pack(pady=12, padx=10)

        self.start_scan_button = customtkinter.CTkButton(self.root, text="Start Scan", fg_color='red', hover_color='green', command=self.start_scan, state="disabled")
        self.start_scan_button.pack(pady=12, padx=10)

        quit_button = customtkinter.CTkButton(self.root, text="Exit", hover_color='red', command=self.quit_tool)
        quit_button.pack(pady=0, padx=100)

    def ask_for_ip(self):
        dialog = customtkinter.CTkInputDialog(text="Type the IP to scan:", title="IP Entry")
        self.text = dialog.get_input()

    def toggle_start_scan_button(self):
        if self.checkbox.get() == "on":
            self.start_scan_button.configure(state="normal")
        else:
            self.start_scan_button.configure(state="disabled")

    def start_scan(self):
        scan_type = self.scan_type_combo.get()
        if scan_type in ["Normal", "Advanced", "Aggressive", "Hardcore", "Stealth"]:
            self.distro()
        else:
            print("Combo box error")

    def distro(self):
        if not check_nmap():
            return  # Exit if nmap is not installed

        distro_output = get_distro()
        if not distro_output:
            return  # Exit if the distribution could not be determined

        command = f'sudo nmap {self.text} -oN results.txt'
        terminal_map = {
            "Debian": 'lxterminal -e',
            "Ubuntu": 'xterm -e',
            "Kali": 'gnome-terminal --',
            "Fedora": 'gnome-terminal --',
            "Manjaro": 'konsole --hold -e'
        }

        terminal_command = next(
            (f'{terminal} "bash -c \'{command}; read -p \'Press Enter to close...\'\'"' for distro, terminal in terminal_map.items() if distro in distro_output),
            None
        )

        if terminal_command:
            subprocess.Popen(terminal_command, shell=True)
        else:
            print("Unsupported distribution")

    def quit_tool(self):
        self.root.quit()

if __name__ == "__main__":
    root = customtkinter.CTk()
    app = VFinderApp(root)
    root.mainloop()
