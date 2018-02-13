*** Settings ***

Documentation  This is to test Resources module - Asset Index of WebTrader MLT broker



Resource          ../common/resources.robot
Resource          ../common/contractResources.robot
Resource          ../common/ResourcesTestResource.robot


Library      Selenium2Library
Library      String
Library      Collections


*** Variables ***

${VALID USER}     yatin+mlt@binary.com
${VALID PASSWORD}  Binary@123
${text}     Volatility Indices
${text1}    Continuous Indices

*** Keywords ***

Indices pop up validation
    wait until element is visible           xpath://SPAN[@class='ui-selectmenu-text'][text()='Volatility Indices']    5s
    ${Gettext}                       Get Text         xpath://SPAN[@class='ui-selectmenu-text'][text()='Volatility Indices']
    should be equal                                   ${text}    ${Gettext}
    ${Gettext}                       Get Text       xpath=//SPAN[@class='ui-selectmenu-text'][text()='Continuous Indices']
    should be equal                                     ${Gettext}      ${text1}


Asset Index list validation
    wait until element is visible           xpath://INPUT[@class='search-input']/../../../../../../..//SPAN[@class='ui-selectmenu-text'][text()='Volatility Indices']   10s
    Click Element                           xpath://INPUT[@class='search-input']/../../../../../../..//SPAN[@class='ui-selectmenu-text'][text()='Volatility Indices']
    sleep    5s
    wait until element is visible           xpath://*[@class='ui-menu ui-corner-bottom ui-widget ui-widget-content']    5s
    ${count}=       Get Element count       xpath://*[@class='ui-menu ui-corner-bottom ui-widget ui-widget-content']/li
    ${actual_list}=    create list
    :For    ${i}    IN RANGE    1   ${count}+1
    \       ${actual_index}=          Get Text        xpath=//*[@class='ui-menu ui-corner-bottom ui-widget ui-widget-content']/li[${i}]
    \       Append to List       ${actual_list}      ${actual_index}
    ${expected_index}       create list              Volatility Indices
    log     ${actual_index}
    lists should be equal    ${actual_list}    ${expected_index}
    #Capture Page Screenshot          T1.png

Navigate to Asset Index pop up
    wait until element is visible             xpath=//*[@id="nav-menu"]/div/ul/li[3]/a   5s
    Mouse Over          xpath=//*[@id="nav-menu"]/div/ul/li[3]/a
    sleep               3s
    Click Element       id=ui-id-2
    Mouse Out           xpath=//*[@id="nav-menu"]/div/ul/li[3]/a


*** Test Cases ***

Login to WebTrader
   open browser then login
   valid login details
   Reality check pop up

Test Asset Index
   Navigate to Asset Index pop up
   Capture Page Screenshot  A1.png

Asset Index - Validation
   Indices pop up validation
   Asset Index list validation

Asset Index - Volatility Indices
   Volatility Indices pop up validation - Continuous Indices
   Search for Volatility Indices - Continuous Indices
   Volatility Indices pop up validation - Daily Reset Indices
   Search for Volatility Indices - Daily Reset Indices

Close Asset Index
   Close Asset Index pop up
   [teardown]    close browser