*** Settings ***
Documentation     Orders robots from RobotSpareBin Industries Inc.
...               Saves the order HTML receipt as a PDF file.
...               Saves the screenshot of the ordered robot.
...               Embeds the screenshot of the robot to the PDF receipt.
...               Creates ZIP archive of the receipts and the images.
Library    RPA.Browser.Selenium    auto_close=${False}
Library    RPA.Excel.Files
Library    RPA.HTTP
Library    RPA.Windows
*** Variables ***
${orders}   https://robotsparebinindustries.com/orders.csv
# ${path}    C:\\Users\\Ponraj\\OneDrive - Yitro Business Consultants India Private Limited\\Pictures\\Saved Pictures  overwrite=True
*** Tasks ***
Order robots from RobotSpareBin Industries Inc
  Open the robot order website
  Open Available Browser
  Maximize Browser Window
  Fill and submit the form  
#   Download the Excel file
#   Fill the form using the data from the Excel file
*** Keywords ***
Open the robot order website
  Open Available Browser  https://robotsparebinindustries.com/#/robot-order
  Maximize Browser Window
  Sleep    5s
  Click Button    //*[@id="root"]/div/div[2]/div/div/div/div/div/button[1]
  Click Button    //*[@id="root"]/div/div[1]/div/div[2]/div[1]/button
 
  Select From List By Value    //*[@id="head"]   2
  Click Element    //*[@id="root"]/div/div[1]/div/div[1]/form/div[2]/div/div[1]/label
  Input Text  //*[@id="1736427999136"]   value2
  Input Text    //*[@id="address"]     chennai
  Click Button   //*[@id="preview"] 
# Download the Excel file 
#   Download    ${orders}    target_file=${path}    overwrite=${True}
Fill and submit the form

  Select From List By Value    //*[@id="head"]   2
  Is Radio Button Selected    //*[@id="root"]/div/div[1]/div/div[1]/form/div[2]/div Peanut crusher body
  Input Text     //*[@id="1736424460430"]    2  
  Input Text    //*[@id="address"]     chennai
  Click Button   //*[@id="preview"] 
# Fill the form using the data from the Excel file
#   Open Workbook    orders.csv
#    ${orders}=    Read Worksheet As Table    header=True
#   Close Workbook
#   FOR    ${orders}    IN    @{orders}
#         Fill and submit the form for one person    ${orders}
#   END
Minimal task
    Log    Done.