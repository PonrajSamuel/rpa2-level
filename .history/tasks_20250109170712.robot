*** Settings ***
Documentation     Orders robots from RobotSpareBin Industries Inc.
...               Saves the order HTML receipt as a PDF file.
...               Saves the screenshot of the ordered robot.
...               Embeds the screenshot of the robot to the PDF receipt.
...               Creates ZIP archive of the receipts and the images.
Library    RPA.Browser.Selenium    auto_close=${False}
Library    RPA.Excel.Files
Library    RPA.HTTP
*** Variables ***
${orders}   https://robotsparebinindustries.com/orders.csv
${path}    C:\\Users\\Ponraj\\OneDrive - Yitro Business Consultants India Private Limited\\Pictures\\Saved Pictures
*** Tasks ***
Order robots from RobotSpareBin Industries Inc
  Open the robot order website
  Open Available Browser
  Maximize Browser Window
  Download the Excel file
  Fill the fo
*** Keywords ***
Open the robot order website
  Open Available Browser  https://robotsparebinindustries.com/#/robot-order
  Maximize Browser Window
Download the Excel file 
  Download    ${orders}    target_file=${path}    overwrite=${True}
Fill the form
Minimal task
    Log    Done.