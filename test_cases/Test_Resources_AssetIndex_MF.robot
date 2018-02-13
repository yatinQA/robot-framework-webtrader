*** Settings ***

Documentation  This is to test Resources module  - Asset Index of WebTrader for MF broker



Resource          ../common/resources.robot
Resource          ../common/contractResources.robot
Resource          ../common/ResourcesTestResource.robot


Library      Selenium2Library
Library      String
Library      Collections


*** Variables ***

${VALID USER}     yatin+mf@binary.com
${VALID PASSWORD}  Binary@123

*** Keywords ***

Navigate to Asset Index pop up
    wait until element is visible             xpath=//*[@id="nav-menu"]/div/ul/li[3]/a   5s
    Mouse Over          xpath=//*[@id="nav-menu"]/div/ul/li[3]/a
    sleep               3s
    Click Element       id=ui-id-2
    Mouse Out           xpath=//*[@id="nav-menu"]/div/ul/li[3]/a

Asset Index list validation
    wait until element is visible           xpath://INPUT[@class='search-input']/../../../../../../..//SPAN[@class='ui-selectmenu-text'][text()='Forex']   10s
    Click Element           xpath://INPUT[@class='search-input']/../../../../../../..//SPAN[@class='ui-selectmenu-text'][text()='Forex']
    sleep    5s
    wait until element is visible          xpath://*[@class='ui-menu ui-corner-bottom ui-widget ui-widget-content']    5s
    ${count}=       Get Element count       xpath://*[@class='ui-menu ui-corner-bottom ui-widget ui-widget-content']/li
    ${actual_list}=    create list
    :For    ${i}    IN RANGE    1   ${count}+1
    \       ${actual_index}=          Get Text        xpath=//*[@class='ui-menu ui-corner-bottom ui-widget ui-widget-content']/li[${i}]
    \       Append to List       ${actual_list}      ${actual_index}
    ${expected_index}       create list             Forex       Indices      OTC Stocks        Commodities
    log     ${actual_index}
    lists should be equal    ${actual_list}    ${expected_index}
    #Capture Page Screenshot          T1.png

*** Test Cases ***

Login to WebTrader
   open browser then login
   valid login details
   Reality check pop up

Test Asset Index
   Navigate to Asset Index pop up
   #Capture Page Screenshot  A1.png

Asset Index - Validation
   Indices pop up validation
   Asset Index list validation

Asset Index - Forex
   Navigate to Forex
   Forex pop up validation - Major Pairs
   Forex - Major Pairs validation
   Search for Forex - Major Pairs
   Forex pop up validation - Minor Pairs
   Search for Forex - Minor Pairs
   Forex pop up validation - Smart FX
   Search for Forex - Smart FX

Asset Index - Indices
   Sub Indices Validation
   Indices - Asia/Oceania Contract Validation
   Indices market validation - Asia/Oceania
   Search for Indices - Asia/Oceania
   Indices - Asia/Oceania - Bombay Index
   Indices - Asia/Oceania - Hong Kong Index Index
   Indices Table validation - Europe/Africa
   Search for Indices - Europe/Africa
   Indices Table validation - OTC Indices
   Search for Indices - OTC Indices

Asset Index - OTC Stocks
   Navigate to OTC Stocks
   OTC Stocks pop up validation - Germany
   Search for OTC Stocks - Germany
   OTC Stocks pop up validation - India
   Search for OTC Stocks - India
   OTC Stocks pop up validation - UK
   Search for OTC Stocks - UK
   OTC Stocks pop up validation - US
   Search for OTC Stocks - US

Asset Index - Commodities
   Navigate to Commodities
   Commodities pop up validation - Metals
   Search for Commodities - Metals
   Commodities pop up validation - Energy
   Search for Commodities - Energy

Close Asset Index
   Close Asset Index pop up
   [teardown]    close browser