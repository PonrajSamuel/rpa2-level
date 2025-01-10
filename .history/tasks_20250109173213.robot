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
${path}    C:\\Users\\Ponraj\\OneDrive - Yitro Business Consultants India Private Limited\\Pictures\\Saved Pictures
*** Tasks ***
Order robots from RobotSpareBin Industries Inc
  Open the robot order website
  Open Available Browser
  Maximize Browser Window
  Download the Excel file
  Fill the form using the data from the Excel file
*** Keywords ***
Open the robot order website
  Open Available Browser  https://robotsparebinindustries.com/#/robot-order
  Maximize Browser Window
  Click Button    //*[@id="root"]/div/div[2]/div/div/div/div/div/button[1]
Download the Excel file 
  Download    ${orders}    target_file=${path}    overwrite=${True}
Fill and submit the form for one person 
  [Arguments]    ${orders}
  Input Text    //*[@id="firstname"]    ${orders}[First Name]
  Input Text    //*[@id="lastname"]    ${orders}[First Name]
  Input Text    //*[@id="salesresult"]   ${orders}[Sales]
  Select From List By Value     //*[@id="salestarget"]      ${orders}[Sales Target]
  Click Button    //*[@id="sales-form"]/button  
Fill the form using the data from the Excel file
  Open Workbook    orders.csv
   ${orders}=    Read Worksheet As Table    header=True
  Close Workbook
  FOR    ${orders}    IN    @{orders}
        Fill and submit the form for one person    ${orders}
  END
Minimal task
    Log    Done.