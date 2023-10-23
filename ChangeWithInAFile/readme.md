How to Use

    Open the bash script in a text editor of your choice.
    Replace yourPath in the line FILES="yourPath/*" with the actual path to the directory where your files are located. Make sure to append /* to the end of the path.
    Replace some word you want to replace in the line sed -i 's/some word you want to replace/replace with/g' $f with the word you want to replace.
    Replace replace with in the line sed -i 's/some word you want to replace/replace with/g' $f with the word you want to replace it with.
    Save the changes to the bash script.

Running the Script

To run the script, open the terminal and navigate to the location where the bash script is saved. Then, type the following command and press Enter:

code
 
 
Copy code

bash script_name.sh

Make sure to replace script_name.sh with the actual name of your bash script.
Notes

    The script will only replace the specified word in files within the specified directory. Subdirectories or nested files will not be included.
    If there are any issues with a file during the replace process, a warning message will be displayed.

Please let me know if you have any further questions!
