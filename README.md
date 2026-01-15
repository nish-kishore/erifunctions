# erifunctions
A suite of helper functions for the Epidemiology, Research and Innovation Team of the Health Unit in The Carter Center

# Background
Purpose of "erifunctions" repository is to standardize code base and make easier for anyone in ERI group to download functions and use the system.
More functions we do regularly will be added to this repository.

# How to Download

1) Ensure you have the latest versions of [R and R Studio](https://posit.co/download/rstudio-desktop/) downloaded.
2) Create a GitHub account [here](https://github.com/) (if not done already).
3) Download [GitHub Desktop](https://desktop.github.com/download/) and sign in with your credentials.
4) Access the [erifunctions repository](https://github.com/nish-kishore/erifunctions).
5) At the top right of the repository page, you should see a green button that says "< > Code". Click the drop down button and select "Open with GitHub Desktop".
6) You now have access to the erifunctions repository! Click on the "Repository" menu item on GitHub Desktop and select "Show in Explorer".
7) **Important**: Ensure the filepath that the repository is saved to is outside of OneDrive (e.g., on your personal device).
8) Within the erifunctions repository folder in your Explorer filepath, open the "erifunctions" RStudio Project File.
8) As that loads, install Rtools44 [here](https://cran.r-project.org/bin/windows/Rtools/rtools44/rtools.html).
9) Within the Console (bottom panel) in RStudio, type `install.packages("devtools")`. This installs the "devtools" package, which will be necessary to run certain features of the code found in the repository. 
If you are asked within the Console if you want to proceed, type "Y".
10) Next, type `devtools::load_all()` into the Console. If you are asked to install required packages (e.g., "dplyr", "here", "httr", etc.), select "Yes".

# How to Set Up Initial Interaction

1) Go to the erifunctions repository in your Explorer (remember: you can click on the "Repository" menu item on GitHub Desktop and select "Show in Explorer").
2) Right click and make a new folder called "sandbox".
3) Go back to R Studio and make a new R Script (can either click the white paper with a green plus sign in the top left or go via "File" -> "New File" -> "R Script").
4) Save this R Script immediately in the new "sandbox" folder and title the script "keys.yaml". Change the "Save as type:" field from "R" to "All Files". Select "Yes" on the pop-up message asking
 for permission to change the R script into a different file type.
    a) The purpose of the "keys.yaml" script is to save your ODK username and password, which will be needed to use the entire package of functions in the repository without having to retype them manually every time.
5) Type the following code into "keys.yaml": 
```
odk:
    url: "https://rblf.tccodk.org/"
    name: "[FIRST NAME].[LAST NAME]@cartercenter.org"
    pass: "[PASS]"
```
Replace the items in brackets with your first name, last name, and ODK password.

6) In your Console, type `devtools::load_all()`.
    a) This will load the erifunctions repository as if it were a package.
6) Type `init_odk_connection()` into your Console to create an active ODK token. After your token expires in 24 hours, you can just type this code again to create a new token.
7) You should now be able to use other functions in the repository! Try typing `list_odk_projects()` in the Console and see if all existing ODK projects for the RBLFSCHMAL team appear.

# Key functions and definitions
list_odk_projects doesn't require anything
list_odk_forms needs project number to run
Each fxn has stuff written out for it: just make it digestible for someone to use this



