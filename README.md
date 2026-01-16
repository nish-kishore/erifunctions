---
title: "Guide to the `erifunctions` Repository"
output: distill::distill.article
  html_document: 
    toc: true
    toc_float: true
---

--------------------------------------------------
# Background
The "erifunctions" repository is intended for use by the Epidemiology, Research, and Innovation unit of the River Blindness, Lymphatic Filariasis, Schistosomiasis, and Malaria team at The Carter Center.
The purpose of its suite of helper functions is to create a standardized code base and assist anyone in the group with streamlining certain tasks related to data analysis.
Additional functions used by the ERI unit will be added continuously to this repository.

# How to Download

1) Ensure you have the latest versions of [R and R Studio](https://posit.co/download/rstudio-desktop/) downloaded.
2) Create a GitHub account [here](https://github.com/) (if not done already).
3) Download [GitHub Desktop](https://desktop.github.com/download/) and sign in with your credentials.
4) Access the [erifunctions repository](https://github.com/nish-kishore/erifunctions).
5) At the top right of the repository page, you should see a green button that says "< > Code". Click the drop down button and select "Open with GitHub Desktop".
6) You now have access to the repository! Click on the "Repository" menu item on GitHub Desktop and select "Show in Explorer".
7) **Important**: Ensure the filepath that the repository is saved to is outside of OneDrive (e.g., on your personal device).
8) Within the "erifunctions" repository folder in your Explorer filepath, open the "erifunctions" RStudio Project File.
8) As that loads, install Rtools44 [here](https://cran.r-project.org/bin/windows/Rtools/rtools44/rtools.html).
9) Within the Console (bottom panel) in RStudio, type `install.packages("devtools")`. This installs the "devtools" package, which will be necessary to run certain features of the code found in the repository. 
If you are asked within the Console if you want to proceed, type "Y".
10) Next, type `devtools::load_all()` into the Console. If you are asked to install required packages (e.g., "dplyr", "here", "httr", etc.), select "Yes".
    a) This will load the "erifunctions" repository as if it were a package.

# How to Set Up the Initial Interaction

1) In the Console, type:
```
init_odk_connection(url = "https://rblf.tccodk.org/", user = "[FIRST NAME].[LAST NAME]@cartercenter.org", pass = "[PASS]")
``` 
Replace the items in brackets with your first name, last name, and ODK password. This will create an active ODK token. After your token expires in 24 hours, you can just type this code again to create a new token.
2) You should now be able to use other functions in the repository! Try typing `list_odk_projects()` in the Console and see if all existing ODK projects for the RBLFSCHMAL team appear.

*Note:* The parameters of the `init_odk_connection()` function are the ODK URL, username (TCC email), and password, along with items that indicate if testing is needed (`testing`, automatically set as "FALSE") and if
 a full explanation of the ODK token is needed so details can be specified (`verbose`, automatically set as "TRUE"). If you would just like a simple answer that the ODK token has been established or not,
 just type the same code in Step 1 and add `, verbose = FALSE` after the password.

# Key Functions and Definitions

- `init_odk_connection()`: This establishes an active ODK token and confirms with the user that this occurred. See the above section for how to use.
- `list_odk_projects()`: Simply produces all country projects that exist in ODK for the RBLFSCHMAL team. No additional parameters are needed to use this function.
* `list_odk_forms()`: Lists out all existing ODK forms within each project. This requires a project ID to run, which you are able to obtain from the previous function. 
    - Example: `list_odk_forms(project_id = 2)` will provide all forms for Nigeria. If there are no existing forms for a country (e.g., if no active data collection or project is archived), you will receive an error that the subscript is out of bounds.
* `download_odk_form()`: Allows a user to download all data from a particular ODK form into a zipped CSV file. This requires a project ID and form ID to run, which you are able to obtain from the previous two functions. 
    - Example: `download_odk_form(project_ID = 2, form_id = 3)` will provide all data from the Nigeria PTS Results Form.
* `list_all_odk_app_users(project_id = 1)`: Lists all users with access to an ODK project. The required parameter for this is a project ID.
    - Example: `list_all_odk_app_users(project_id = 1)` will provide all users who have access to the Ethiopia forms.
* `list_odk_form_users()`: Lists all users with access to a specific ODK form. The required parameters for this are a project ID and form ID.
    - Example: `list_odk_form_users(project_id = 1, form_id = 3)` will provide all users who have access to the Ethiopia EMS Results Form.
* `update_odk_app_user_role()`: Allows you to create, delete, assign, or un-assign app users. You will need an action ("create", "delete", "assign", or "revoke") and a project ID. A form ID is necessary to change permissions on any specific form. 
An actor name is necessary to create a new user, while an actor ID is needed to delete an existing user or assign certain permissions. A role ID indicates the type of role that someone should be assigned to (typically 2).
    - Example 1: `update_odk_app_user_role(action = "create", project_id = 2, actor_name = "amehtaTEST")` will create a new user called "amehtaTEST" in the Nigeria project.
    - Example 2: `update_odk_app_user_role(action = "delete", project_id = 2, actor_id = 960)` will delete the user "amehtaTEST" in the Nigeria project.

# Coding Example with Data
