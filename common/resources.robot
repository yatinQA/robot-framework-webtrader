*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.

Library		      String
Library           Selenium2Library 

*** Variables ***
#THESE ARE BROWSER VARIBALES
${BROWSER}        Chrome 
${DELAY}          0
${VALID USER}     fahad@binary.com
${VALID PASSWORD}  Silverlight24
${HOME URL}      https://webtrader.binary.com/beta/
@{chrome_arguments}	--disable-infobars    --headless    --disable-gpu

*** Keywords ***
Set Chrome Options
    [Documentation]    Set Chrome options for headless mode
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    : FOR    ${option}    IN    @{chrome_arguments}
    \    Call Method    ${options}    add_argument    ${option}
    [Return]    ${options}

Chrome Headless
    ${chrome_options}=    Set Chrome Options
    Create Webdriver    Chrome    chrome_options=${chrome_options}

Input Username
    [Arguments]    ${username}
    Input Text    txtEmail    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    txtPass    ${password}

Submit Credentials
    wait until element is visible   login
    Click Button    login

Grant Permission
    click button  confirm_scopes

Open browser then login
#    Open Browser    ${HOME URL}    ${BROWSER}
    Chrome Headless
    Go To   ${HOME URL}
    Sleep                               2
    Click element                       xpath=//*[@id="content"]//button
    #sleep   5
    #Wait Until Element Is Visible       xpath=//*[contains(text(),'Do you want')]   10
    #Click button                        id= cancel
    wait until element is visible        xpath=//*[@id="main-account"]//button      10
    Click element                       xpath=//*[@id="main-account"]//button
    Wait Until Element Is Visible       xpath=//*[contains(text(),'Click to log in with')]   10
    Click button                        xpath=//*[contains(text(),'Log in')]
    valid login details

Valid Login Details
    Input Username	${VALID USER}
    Input Password	${VALID PASSWORD}
    Submit Credentials
    ${GRANT} =                           run keyword and return status  page should not contain   Review Permissions
    run keyword if   ${GRANT}!=1    Grant Permission
    Wait Until Page Contains	         Resources  5

Switch Virtual Account
    Sleep  10
    Click Element	                        css=div.account-id
    Click Element	                        xpath=//*[contains(text(),'Virtual Account')]
    Wait Until Page Contains	            Resources   10

Close all current windows


    wait until page contains    Workspace
     Click Element       xpath=//*[contains(text(),'Resources')]
    Click Element       xpath=//*[contains(text(),'Workspace')]
    Sleep       5
    Click Element       xpath=//*[contains(text(),'Close')]