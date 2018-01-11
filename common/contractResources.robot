*** Settings ***
Documentation     A resource file with reusable keywords and variables for contract.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library		      String
Library           Selenium2Library

*** Variables ***
${duration_value}
${duration_unit}
${profit_lost_evaluate}
${tick_value}
${status}


*** Keywords ***

Select market to trade
    [Arguments]     ${market}       ${sub_market}        ${underlying}
    mouse over  xpath=//*[@id="nav-menu"]/div/ul/li[1]/a
    sleep   1
    mouse over   xpath=//*[contains(text(),'${market}')]
    sleep   1
    mouse over   xpath=//*[contains(text(),'${sub_market}')]
    sleep   1
    click element  xpath=//*[contains(text(),'${underlying}')]
    wait until page contains  Purchase  10


Purchase a Contract
#this method to purchase a contract based on test case option
    [Arguments]     ${duration_value}   ${duration_unit}
    Set global variable     ${duration_value}
    Set global variable     ${duration_unit}
    sleep   5
    input text      xpath=//INPUT[@class='duration-count']      ${duration_value}
    click element   xpath=//SPAN[@class='ui-selectmenu-text'][text()='ticks']
    click element   xpath=//DIV[contains(text(),'${duration_unit}')]
    sleep  3
    click button    xpath=//BUTTON[@rv-on-click='purchase.onclick'][text()='Purchase']
    wait until page contains        Contract Confirmation   10
    wait until element is visible   xpath=//SPAN[text()='Total Cost']/following-sibling::SPAN
    wait until page contains    Final price       20
    [Return]    ${duration_value}   ${duration_unit}

Verify Contract Result
# This is used for Tick contract - verifying result on trading page
    ${buy_price}=	get text    xpath=//SPAN[text()='Buy price']/following-sibling::SPAN
    ${final_price}=	Get Text	xpath=//SPAN[text()='Final price']/following-sibling::SPAN


    ${profit_lost_evaluate}=	Evaluate	${final_price} - ${buy_price}
    ${profit_lost_evaluate}=	Evaluate      "%.2f" % ${profit_lost_evaluate}
    Set Global Variable		${profit_lost_evaluate}
    ${status}=	Evaluate	${final_price} > ${buy_price}
    set global variable    ${status}

    Run Keyword If	${status} == 1	Tick Contract Won
    Run Keyword If	${status} == 0	Tick Contract Lost


Tick Contract Won
# This is used for Tick contract - verifying result on trading page
    Page Should Contain	This contract won
    ${profit_lost}=	Get Text	xpath=//SPAN[@rv-text='buy.potential_profit_text'][text()='Profit']/following-sibling::SPAN
    Should Be True	'${profit_lost}' == '${profit_lost_evaluate}'



Tick Contract Lost
# This is used for Tick contract - verifying result on trading page
    Page Should Contain	This contract lost
    ${profit_lost}=	Get Text	xpath=//SPAN[@rv-text='buy.potential_profit_text'][text()='Lost']/following-sibling::SPAN
    ${profit_lost_evaluate}=	Convert To String	${profit_lost_evaluate}
    #${profit_lost_evaluate}=	Catenate	-${profit_lost_evaluate}
    Should Be True	'${profit_lost}' == '${profit_lost_evaluate}'
