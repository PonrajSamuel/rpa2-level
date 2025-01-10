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
Library    RPA.Tables
*** Variables ***
# ${order}   https://robotsparebinindustries.com/orders.csv
# ${path}    C:\\Users\\Ponraj\\OneDrive - Yitro Business Consultants India Private Limited\\Pictures\\Saved Pictures  overwrite=True
# ${CSV_FILE_PATH}  C:\\Users\\Ponraj\\OneDrive - Yitro Technology Solutions Pvt Ltd\\rpa2
*** Tasks ***
Order robots from RobotSpareBin Industries Inc
    Open the robot order website
    Download the Excel file
    # Fill and submit the form for one person  
    Fill the form using the data from the Excel file
*** Keywords ***
Open the robot order website
  Open Available Browser  https://robotsparebinindustries.com/#/robot-order
  Maximize Browser Window
  Sleep    5s
#   Click Button    //*[@id="root"]/div/div[2]/div/div/div/div/div/button[1]
#   Click Button    //*[@id="root"]/div/div[1]/div/div[2]/div[1]/button
 
#   Select From List By Value    //*[@id="head"]   2
#   Click Element    //*[@id="root"]/div/div[1]/div/div[1]/form/div[2]/div/div[1]/label
#   Click Element    //input[@placeholder='Enter the part number for the legs']
#   Input Text    //input[@placeholder='Enter the part number for the legs']    2  
#   Input Text    //*[@id="address"]     chennai
#   Scroll Element Into View    //*[@id="order"]
#   Click Button   //*[@id="order"] 
#   Sleep    5s
#    Scroll Element Into View   //*[@id="order-another"]
#   Click Button    //*[@id="order-another"]
Download the Excel file 
  Download    https://robotsparebinindustries.com/orders.csv  overwrite=True

Fill and submit the form for one person 
    [Arguments]    ${orders}
    Click Button    //*[@id="root"]/div/div[2]/div/div/div/div/div/button[1]
    Click Button    //*[@id="root"]/div/div[1]/div/div[2]/div[1]/button
    Wait Until Element Is Visible    //*[@id="head"]
    Select From List By Value    //*[@id="head"]    ${orders}[head]
    Click Element    //label[contains(text(), '${orders}[body]')]
    Input Text    //input[@placeholder='Enter the part number for the legs']    ${orders}[legs]
    Input Text    //*[@id="address"]    ${orders}[address]
    Scroll Element Into View    //*[@id="order"]
    Click Button   //*[@id="order"]
    Sleep    5s
    # Click Button    //*[@id="order-another"]
Fill the form using the data from the Excel file
  Read table from CSV  orders.csv
  ${orders}=    Read table from CSV    orders.csv
  Close Workbook
  FOR    ${order}    IN    @{orders}
        Fill and submit the form for one person  ${order}
  END  
# Fill and submit the form

#   Click Button    //*[@id="root"]/div/div[2]/div/div/div/div/div/button[1]
#   Click Button    //*[@id="root"]/div/div[1]/div/div[2]/div[1]/button
 
#   Select From List By Value    //*[@id="head"]   2
#   Click Element    //*[@id="root"]/div/div[1]/div/div[1]/form/div[2]/div/div[1]/label
#   Click Element    //input[@placeholder='Enter the part number for the legs']
#   Input Text    //input[@placeholder='Enter the part number for the legs']    2  
#   Input Text    //*[@id="address"]     chennai
#   Scroll Element Into View    //*[@id="order"]
#   Click Button   //*[@id="order"]
# Fill the form using the data from the Excel file
#   Open Workbook    orders.csv
#    ${orders}=    Read Worksheet As Table    header=True
#   Close Workbook
#   FOR    ${orders}    IN    @{orders}
#         Fill and submit the form for one person    ${orders}
#   END
Minimal task
    Log    Done.