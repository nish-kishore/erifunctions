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
6) Select a path to save. **Important**: this filepath must be outside of OneDrive. 
7) Install Rtools44 [here](https://cran.r-project.org/bin/windows/Rtools/rtools44/rtools.html).
8) Within your Console in RStudio, type `install.packages("devtools")`. This installs the "devtools" package. which will be necessary to run certain features of the code found in the repository. 
If you are asked within the Console if you want to proceed, type "Y".
9) Next, type `devtools::load_all()` into the Console. If you are asked to install required packages (e.g., "dplyr", "here", "httr", etc.), select "Yes".
