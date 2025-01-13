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
Library    RPA.PDF
# Resource    .history/tasks_20250110195501.robot
Library    OperatingSystem
*** Variables ***
# ${row}   https://robotsparebinindustries.com/orders.csv
${OUTPUT_DIR}    c:\\Users\\Ponraj\\OneDrive - Yitro Business Consultants India Private Limited\\Pictures\\Saved Pictures
${order}         orders.csv
# ${FILE_NAME}        robot_preview_image.png
# ${FULL_PATH}        ${OUTPUT_DIR}/${FILE_NAME}
# ${CSV_FILE_PATH}  C:\\Users\\Ponraj\\OneDrive - Yitro Technology Solutions Pvt Ltd\\rpa2
*** Tasks ***
Order robots from RobotSpareBin Industries Inc
    Open the robot order website
    Download the Excel file
    
    # Fill and submit the form for one person  
    Fill the form using the data from the Excel file
    # collect the receipt
    # Convert Receipt To Pdf
    # Export the receipt as pdf
*** Keywords ***
Open the robot order website
  Open Available Browser  https://robotsparebinindustries.com/#/robot-order
  Maximize Browser Window
  Sleep    5s
Download the Excel file 
  Download    https://robotsparebinindustries.com/orders.csv  overwrite=True

Fill and submit the form for one person 
    [Arguments]    ${order}
    Click Button    //*[@id="root"]/div/div[2]/div/div/div/div/div/button[1]
    Click Button    //*[@id="root"]/div/div[1]/div/div[2]/div[1]/button
    Wait Until Element Is Visible    //*[@id="head"]
    Select From List By Value    //*[@id="head"]    ${order}[Head]
    Click Element     //*[@id="root"]/div/div[1]/div/div[1]/form/div[2]/div/div[1]/label
    Click Element    //input[@placeholder='Enter the part number for the legs']
    Input Text    //input[@placeholder='Enter the part number for the legs']    ${order}[Legs]
    Input Text    //*[@id="address"]    ${order}[Address]
    Scroll Element Into View    //*[@id="order"]
    Sleep    5s
    Click Button   //*[@id="order"]
    Sleep    5s
    # Generate a unique filename for the screenshot
    ${order_number}=    Set Variable    ${order}[Order number]
    ${screenshot_file}=    Set Variable   receipt${order}[Order number].png
    RPA.Browser.Selenium.Screenshot  //*[@id="root"]/div/div[1]   ${OUTPUT_DIR}${/} ${screenshot_file}
    # ${pdf}=    Convert Receipt To Pdf   ${order}[Order number].${pdf}
    # # RPA.Browser.Selenium.Screenshot   //*[@id="robot-preview-image"]   ${OUTPUT_DIR}${/}receipts.png

    # ${pdf}=    Store the receipt as a PDF file    ${order}[Order number]
  #  ${screenshot}=    Take a screenshot of the robot    ${order}[Order number]
  #  Embed the robot screenshot to the receipt PDF file    ${screenshot}    ${pdf}
# Store the receipt as a PDF file   
#     ${pdf}=    Store the receipt as a PDF file   ${order}[Address]
#      ${screenshot}=    png_to_pdf  ${OUTPUT_DIR}${/}receipts.png    ${OUTPUT_DIR}${/}receipts.pdf
#      Store Receipt As PDF

    # Capture Page screenshot    ${OUTPUT_DIR}${/}receipts.png
    # Sleep    5s
    # Wait Until Element Is Visible    //*[@id="order-another"]
    Click Button    //*[@id="order-another"]
Fill the form using the data from the Excel file
  Read table from CSV  orders.csv
  ${orders}=    Read table from CSV    orders.csv
  Close Workbook
  FOR    ${order}    IN    @{orders}
        Fill and submit the form for one person     ${order}
  END  
# collect the receipt
#    RPA.Browser.Selenium.Screenshot  //*[@id="receipt"]   ${OUTPUT_DIR}${/}receipts.png
Minimal task
    Log    Done.