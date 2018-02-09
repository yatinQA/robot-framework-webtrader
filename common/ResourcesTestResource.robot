*** Settings ***

Documentation           This file contains resources for WebTrader Resources module



Library      Selenium2Library
Library      String
Library      Collections


*** Variables ***

${text}     Forex
${text1}    Major Pairs
${text2}    Bombay Index
${text3}    Japanese Index
${text4}    Belgian Index
${text5}    French Index
${text6}    German OTC Index
${text7}    Wall Street OTC Index
${text8}    Forex
${text9}    Major Pairs
${text10}   EUR/AUD
${text11}   USD/JPY
${text12}   GBP/PLN
${text13}   EUR/NZD
${text14}   EUR Index
${text15}   USD Index
${text16}   Deutsche Bank
${text17}   Siemens
${text18}   Bharti Airtel
${text19}   Reliance Industries
${text20}   British American Tobacco
${text21}   Standard Chartered
${text22}   Johnson & Johnson
${text23}   Electronic Arts
${text24}   Palladium/USD
${text25}   Silver/USD
${text26}   Oil/USD
${text27}   Volatility 100 Index
${text28}   Volatility 50 Index
${text29}   Bear Market Index
${text30}   Bull Market Index
${text31}   Commodities
${text32}   Metals
${text33}   Volatility Indices
${text34}   Continuous Indices
${actual_index}
${expected_index}
${count}
${count1}
${i}
${Gettext}
${actual_subindex}
${expected_subindex}
${j}


*** Keywords ***

Navigate to Asset Index pop up
    wait until element is visible             xpath=//*[@id="nav-menu"]/div/ul/li[3]/a   5s
    Mouse Over          xpath=//*[@id="nav-menu"]/div/ul/li[3]/a
    sleep               3s
    Click Element       id=ui-id-2
    Mouse Out           xpath=//*[@id="nav-menu"]/div/ul/li[3]/a
    wait until element is visible       //INPUT[@class='search-input']/../../../../../../..//SPAN[@class='ui-icon custom-icon-maximize'][text()='maximize'][text()='maximize']   5s
    sleep               5s
    Click Element       //INPUT[@class='search-input']/../../../../../../..//SPAN[@class='ui-icon custom-icon-maximize'][text()='maximize'][text()='maximize']

Indices pop up validation
    wait until element is visible           xpath://SPAN[@class='ui-selectmenu-text'][text()='Forex']    5s
    ${Gettext}                       Get Text         xpath://SPAN[@class='ui-selectmenu-text'][text()='Forex']
    should be equal                                   ${text}    ${Gettext}
    ${Gettext}                       Get Text       xpath=//SPAN[@class='ui-selectmenu-text'][text()='Major Pairs']
    should be equal                                     ${Gettext}      ${text1}

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
    ${expected_index}       create list             Forex       Indices      OTC Stocks        Commodities     Volatility Indices
    log     ${actual_index}
    lists should be equal    ${actual_list}    ${expected_index}
    Capture Page Screenshot          T1.png

Sub Indices Validation
    Click Element           //span[contains(@class, 'ui-selectmenu-text') and text() = 'Forex']
    Click Element           //*[@class='ui-selectmenu-menu ui-front ui-selectmenu-open']/ul/li[2]
    Click Element           //span[contains(@class, 'ui-selectmenu-text') and text() = 'Asia/Oceania']
    wait until element is visible        xpath://*[@class='ui-selectmenu-menu ui-front ui-selectmenu-open']/ul   10s
    ${count}=       Get matching xpath count        //*[@class='ui-selectmenu-menu ui-front ui-selectmenu-open']/ul/li
    ${actual_sublist}=     create list
    :For      ${i}  IN RANGE    1   ${count}+1
    \         ${actual_subindex}=          Get Text        xpath://*[@class='ui-selectmenu-menu ui-front ui-selectmenu-open']/ul/li[${i}]
    \          Append to List       ${actual_sublist}      ${actual_subindex}
    ${expected_subindex}        create list     Asia/Oceania        Europe/Africa       OTC Indices
    log         ${actual_subindex}
    lists should be equal        ${expected_subindex}      ${actual_sublist}

Indices - Asia/Oceania Contract Validation
        Click Element                        //span[contains(@class, 'ui-selectmenu-text') and text() = 'Asia/Oceania']
        Wait until element is visible        //*[@id="DataTables_Table_0"]/thead/tr/th[2]
        ${count} =  Get matching xpath count    //*[@id="DataTables_Table_0"]/thead/tr/th
        ${actual_contract}=     create list
        :For        ${i}    IN RANGE  2    ${count}+1
        \           ${actual_con}=        Get Text       //*[@id="DataTables_Table_0"]/thead/tr/th[${i}]
        \           append to list   ${actual_contract}     ${actual_con}
        log     ${actual_contract}
        ${expected_contract}        create list     Up/Down  Touch/No Touch  Ends Between/Outside  Stays Between/Goes Outside
        log     ${expected_contract}
        lists should be equal       ${actual_contract}        ${expected_contract}
        #Capture Page Screenshot         T2.png

Indices - Asia/Oceania - Bombay Index
        ${count} =  Get matching xpath count    //*[@id="DataTables_Table_0"]/thead/tr/th
        ${actual_duration}=         CREATE LIST
        :For        ${i}    IN RANGE  2    ${count}+1
        \           ${contract_duration}=       Get text      //*[@id="DataTables_Table_0"]/tbody/tr[1]/td[${i}]
        \           append to list     ${actual_duration}        ${contract_duration}
        log  ${actual_duration}
        ${expected_duration}       create list     5m - 365d  -  -  -
        Log     ${expected_duration}
        lists should be equal       ${actual_duration}         ${expected_duration}

Indices - Asia/Oceania - Hong Kong Index Index
        ${count} =  Get matching xpath count    //*[@id="DataTables_Table_0"]/thead/tr/th
        ${actual_duration}=         CREATE LIST
        :For        ${i}    IN RANGE  2    ${count}+1
        \           ${contract_duration}=       Get text      //*[@id="DataTables_Table_0"]/tbody/tr[2]/td[${i}]
        \           append to list     ${actual_duration}        ${contract_duration}
        log  ${actual_duration}
        ${expected_duration}       create list     5m - 365d  7d - 365d  7d - 365d  7d - 365d
        Log     ${expected_duration}
        lists should be equal       ${actual_duration}         ${expected_duration}

Search for Indices - Asia/Oceania
        Click Element       xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input       Bombay Index
        ${Gettext}          Get Text       xpath=//*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}         ${text2}
        Clear Element text      xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input        Japanese
        ${Gettext}          Get Text        //*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}          ${text3}
        Clear Element Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input

Search for Indices - Europe/Africa
        Click Element       xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input       Belgian Index
        ${Gettext}          Get Text       xpath=//*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}         ${text4}
        Clear Element text      xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input        French
        ${Gettext}          Get Text        //*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}          ${text5}
        Clear Element Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input

Search for Indices - OTC Indices
        Click Element       xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input       German OTC Index
        ${Gettext}          Get Text       xpath=//*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}         ${text6}
        Clear Element text      xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input        Wall
        ${Gettext}          Get Text        //*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}          ${text7}
        Clear Element Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input

Indices market validation - Asia/Oceania
        Wait until element is visible       xpath=//*[@id="DataTables_Table_0"]/tbody/tr[1]/td[1]     10s
        ${count}=    Get matching xpath count   xpath=//*[@id="DataTables_Table_0"]/tbody/tr
        ${actual_content}=      create list
        :For        ${i}    IN RANGE    1   ${count}+1
        \           ${actual_IAcontent}=        Get Text    xpath=//*[@id="DataTables_Table_0"]/tbody/tr[${i}]/td[1]
        \            Append to List     ${actual_content}       ${actual_IAcontent}
        ${expected_content}     create list     Bombay Index        Hong Kong Index     Japanese Index      Singapore Index
        log     ${actual_content}
        Lists should be equal        ${expected_content}         ${actual_content}

Indices Table validation - Europe/Africa
        Wait until element is visible       xpath=//SPAN[@class='ui-selectmenu-text'][text()='Asia/Oceania']     10s
        Click Element         xpath=//SPAN[@class='ui-selectmenu-text'][text()='Asia/Oceania']
        Click Element         //*[@class='ui-selectmenu-menu ui-front ui-selectmenu-open']/ul/li[2]
        Wait until element is visible       xpath=//*[@id="DataTables_Table_0"]/tbody/tr[1]/td[1]       10s
        ${count}=   Get matching xpath count         xpath=//*[@id="DataTables_Table_0"]/tbody/tr
        ${actual_content}=  create list
        :For        ${i}      IN RANGE    1   ${count}+1
        \           ${actual_EAcontent}=        Get Text        xpath=//*[@id="DataTables_Table_0"]/tbody/tr[${i}]/td[1]
        \           Append to List      ${actual_content}       ${actual_EAcontent}
        ${expected_content}     create list         Belgian Index   Dutch Index     French Index    German Index    Irish Index     Norwegian Index     South African Index     Swiss Index
        log     ${actual_content}
        Lists should be equal           ${actual_content}       ${expected_content}

Indices Table validation - OTC Indices
        Click Element                        xpath=//SPAN[@class='ui-selectmenu-text'][text()='Europe/Africa']
        sleep                                5s
        Click Element                        //*[@class='ui-selectmenu-menu ui-front ui-selectmenu-open']/ul/li[3]
        Wait until element is visible        xpath=//*[@id="DataTables_Table_0"]/tbody/tr[1]/td[1]     10s
        ${count}=   Get matching xpath count     xpath=//*[@id="DataTables_Table_0"]/tbody/tr
        ${actual_content}=     create list
        :For        ${i}    IN RANGE    1   ${count}+1
        \           ${actual_OTCcontent}=       Get text        //*[@id="DataTables_Table_0"]/tbody/tr[${i}]/td[1]
        \           Append to list      ${actual_content}      ${actual_OTCcontent}
        ${expected_content}     create list     Dutch OTC Index		Euro 50 OTC Index     French OTC Index    German OTC Index	Japanese OTC Index	Spanish OTC Index   UK OTC Index   US OTC Index	  Wall Street OTC Index
        log     ${actual_content}
        Lists should be equal       ${actual_content}       ${expected_content}

Navigate to Forex
        Wait until element is visible          //span[contains(@class, 'ui-selectmenu-text') and text() = 'Forex']        5s
        Click Element                          //span[contains(@class, 'ui-selectmenu-text') and text() = 'Forex']
        #Click Element                          xpath://*[@class='ui-menu ui-corner-bottom ui-widget ui-widget-content']/li[1]
        Capture Page Screenshot                Forex_navigation.png

Forex pop up validation - Major Pairs
        Wait until element is visible           //span[contains(@class, 'ui-selectmenu-text') and text() = 'Forex']     5s
        ${Gettext1}=            Get Text        //span[contains(@class, 'ui-selectmenu-text') and text() = 'Forex']
        should be equal         ${Gettext1}       ${text8}
        ${Gettext2}=            Get Text        //span[contains(@class, 'ui-selectmenu-text') and text() = 'Major Pairs']
        should be equal         ${Gettext2}        ${text9}

Forex - Major Pairs validation
        Wait until element is visible                        //*[@id="DataTables_Table_0"]/tbody/tr[1]/td[1]         5s
        ${count}=           Get Matching xpath count        //*[@id="DataTables_Table_0"]/tbody/tr
        ${actual_content}=      create list
        :For        ${i}        IN RANGE    1   ${count}+1
        \           ${actual_major}=        Get Text        //*[@id="DataTables_Table_0"]/tbody/tr[${i}]/td[1]
        \           Append to list          ${actual_content}       ${actual_major}
        ${expected_major}       create list         AUD/JPY	  AUD/USD	EUR/AUD	  EUR/CAD	EUR/CHF  EUR/GBP  EUR/JPY  EUR/USD  GBP/AUD  GBP/JPY  GBP/USD  USD/CAD  USD/CHF  USD/JPY
        log     ${actual_content}
        Lists should be equal       ${actual_content}       ${expected_major}

Search for Forex - Major Pairs
        Click Element       xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input       EUR/AUD
        ${Gettext}          Get Text       xpath=//*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}         ${text10}
        Clear Element text      xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input        USD/JPY
        ${Gettext}          Get Text        //*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}          ${text11}
        Clear Element Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input

Forex pop up validation - Minor Pairs
        Click Element                        //span[contains(@class, 'ui-selectmenu-text') and text() = 'Major Pairs']
        Click Element                        //*[@class='ui-selectmenu-menu ui-front ui-selectmenu-open']/ul/li[2]
        Wait until element is visible        //*[@id="DataTables_Table_0"]/tbody/tr     10s
        ${count}=   Get matching xpath count     //*[@id="DataTables_Table_0"]/tbody/tr
        ${actual_content}=     create list
        :For        ${i}    IN RANGE    1   ${count}+1
        \           ${actual_minor}=       Get text        //*[@id="DataTables_Table_0"]/tbody/tr[${i}]/td[1]
        \           Append to list      ${actual_content}      ${actual_minor}
        ${expected_content}     create list     AUD/CAD	 AUD/CHF  AUD/NZD  AUD/PLN  EUR/NZD  GBP/CAD  GBP/CHF  GBP/NOK  GBP/NZD  GBP/PLN  NZD/JPY  NZD/USD  USD/MXN  USD/NOK  USD/PLN  USD/SEK
        log     ${actual_content}
        Lists should be equal       ${actual_content}       ${expected_content}

Search for Forex - Minor Pairs
        Click Element       xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input       GBP/PLN
        ${Gettext}          Get Text       xpath=//*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}         ${text12}
        Clear Element text      xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input        EUR/NZD
        ${Gettext}          Get Text        //*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}          ${text13}
        Clear Element Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input

Forex pop up validation - Smart FX
        Click Element                        //span[contains(@class, 'ui-selectmenu-text') and text() = 'Minor Pairs']
        Click Element                        //*[@class='ui-selectmenu-menu ui-front ui-selectmenu-open']/ul/li[3]
        Wait until element is visible        //*[@id="DataTables_Table_0"]/tbody/tr[1]/td[1]     10s
        ${count}=   Get matching xpath count     //*[@id="DataTables_Table_0"]/tbody/tr
        ${actual_content}=     create list
        :For        ${i}    IN RANGE    1   ${count}+1
        \           ${actual_SFX}=       Get text        //*[@id="DataTables_Table_0"]/tbody/tr[${i}]/td[1]
        \           Append to list      ${actual_content}      ${actual_SFX}
        ${expected_content}     create list     AUD Index	EUR Index	GBP Index	USD Index
        log     ${actual_content}
        Lists should be equal       ${actual_content}       ${expected_content}

Search for Forex - Smart FX
        Click Element       xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input       EUR Index
        ${Gettext}          Get Text       xpath=//*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}         ${text14}
        Clear Element text      xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input        USD
        ${Gettext}          Get Text        //*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}          ${text15}
        Clear Element Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input

Navigate to OTC Stocks
        Wait until element is visible          xpath://span[contains(@class, 'ui-selectmenu-text') and text() = 'Indices']        5s
        Click Element                          xpath://span[contains(@class, 'ui-selectmenu-text') and text() = 'Indices']
        Click Element                          //*[@class='ui-menu ui-corner-bottom ui-widget ui-widget-content']/li[3]

OTC Stocks pop up validation - Germany
        Wait until element is visible           //span[contains(@class, 'ui-selectmenu-text') and text() = 'Germany']   5s
        ${Gettext}          Get Text            //span[contains(@class, 'ui-selectmenu-text') and text() = 'Germany']
        should be equal         ${Gettext}          Germany
        ${count}=   Get matching xpath count     //*[@id="DataTables_Table_0"]/tbody/tr
        ${actual_content}=     create list
        :For        ${i}    IN RANGE    1   ${count}+1
        \           ${actual_OTC}=       Get text        //*[@id="DataTables_Table_0"]/tbody/tr[${i}]/td[1]
        \           Append to list      ${actual_content}      ${actual_OTC}
        ${expected_content}     create list     Airbus  Allianz  BMW  Daimler  Deutsche Bank	Novartis  SAP  Siemens
        log     ${actual_content}
        Lists should be equal       ${actual_content}       ${expected_content}

Search for OTC Stocks - Germany
        Click Element       xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input       Deutsche
        ${Gettext}          Get Text       xpath=//*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}         ${text16}
        Clear Element text      xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input        Siemens
        ${Gettext}          Get Text        //*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}          ${text17}
        Clear Element Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input

OTC Stocks pop up validation - India
        Click Element                        //span[contains(@class, 'ui-selectmenu-text') and text() = 'Germany']
        Click Element                        //*[@class='ui-selectmenu-menu ui-front ui-selectmenu-open']/ul/li[2]
        Wait until element is visible        //*[@id="DataTables_Table_0"]/tbody/tr[1]/td[1]     5s
        ${count}=   Get matching xpath count     //*[@id="DataTables_Table_0"]/tbody/tr
        ${actual_content}=     create list
        :For        ${i}    IN RANGE    1   ${count}+1
        \           ${actual_OTC}=       Get text        //*[@id="DataTables_Table_0"]/tbody/tr[${i}]/td[1]
        \           Append to list      ${actual_content}      ${actual_OTC}
        ${expected_content}     create list     Bharti Airtel	Maruti Suzuki	Reliance Industries	 Tata Steel
        log     ${actual_content}
        Lists should be equal       ${actual_content}       ${expected_content}

Search for OTC Stocks - India
        Click Element       xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input       ${text18}
        ${Gettext}          Get Text       xpath=//*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}         ${text18}
        Clear Element text      xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input        ${text19}
        ${Gettext}          Get Text        //*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}          ${text19}
        Clear Element Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input

OTC Stocks pop up validation - UK
        Click Element                        //span[contains(@class, 'ui-selectmenu-text') and text() = 'India']
        Click Element                        //*[@class='ui-selectmenu-menu ui-front ui-selectmenu-open']/ul/li[3]
        Wait until element is visible        //*[@id="DataTables_Table_0"]/tbody/tr[1]/td[1]     5s
        ${count}=   Get matching xpath count     //*[@id="DataTables_Table_0"]/tbody/tr
        ${actual_content}=     create list
        :For        ${i}    IN RANGE    1   ${count}+1
        \           ${actual_OTC}=       Get text        //*[@id="DataTables_Table_0"]/tbody/tr[${i}]/td[1]
        \           Append to list      ${actual_content}      ${actual_OTC}
        ${expected_content}     create list     BP  Barclays    British American Tobacco	HSBC  Lloyds Bank	Rio Tinto	Standard Chartered	 Tesco
        log     ${actual_content}
        Lists should be equal       ${actual_content}       ${expected_content}

Search for OTC Stocks - UK
        Click Element       xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input       ${text20}
        ${Gettext}          Get Text       xpath=//*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}         ${text20}
        Clear Element text      xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input        ${text21}
        ${Gettext}          Get Text        //*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}          ${text21}
        Clear Element Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input

OTC Stocks pop up validation - US
        Click Element                        //span[contains(@class, 'ui-selectmenu-text') and text() = 'UK']
        Click Element                        //*[@class='ui-selectmenu-menu ui-front ui-selectmenu-open']/ul/li[4]
        Wait until element is visible        //*[@id="DataTables_Table_0"]/tbody/tr[1]/td[1]     5s
        ${count}=   Get matching xpath count     //*[@id="DataTables_Table_0"]/tbody/tr
        ${actual_content}=     create list
        :For        ${i}    IN RANGE    1   ${count}+1
        \           ${actual_OTC}=       Get text        //*[@id="DataTables_Table_0"]/tbody/tr[${i}]/td[1]
        \           Append to list      ${actual_content}      ${actual_OTC}
        ${expected_content}     create list     Alibaba   Alphabet   Amazon.com	  American Express	 Apple  Berkshire Hathaway	 Boeing   Caterpillar  Citigroup	Electronic Arts	  Exxon Mobil	 Facebook	 Goldman Sachs	 IBM  Johnson & Johnson	  MasterCard	 McDonald's	 Microsoft  PepsiCo	  Procter & Gamble
        log     ${actual_content}
        Lists should be equal       ${actual_content}       ${expected_content}

Search for OTC Stocks - US
        Click Element       xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input       ${text22}
        ${Gettext}          Get Text       xpath=//*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}         ${text22}
        Clear Element text      xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input        ${text23}
        ${Gettext}          Get Text        //*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}          ${text23}
        Clear Element Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input

Navigate to Commodities
        Wait until element is visible          //span[contains(@class, 'ui-selectmenu-text') and text() = 'OTC Stocks']        5s
        Click Element                          //span[contains(@class, 'ui-selectmenu-text') and text() = 'OTC Stocks']
        Click Element                          //*[@class='ui-menu ui-corner-bottom ui-widget ui-widget-content']/li[4]

Commodities pop up validation - Metals
        Wait until element is visible           //span[contains(@class, 'ui-selectmenu-text') and text() = 'Commodities']     5s
        ${Gettext1}=            Get Text        //span[contains(@class, 'ui-selectmenu-text') and text() = 'Commodities']
        should be equal         ${Gettext1}       ${text31}
        ${Gettext2}=            Get Text        //span[contains(@class, 'ui-selectmenu-text') and text() = 'Metals']
        should be equal         ${Gettext2}        ${text32}
        Wait until element is visible        //*[@id="DataTables_Table_0"]/tbody/tr[1]/td[1]     5s
        ${count}=   Get matching xpath count     //*[@id="DataTables_Table_0"]/tbody/tr
        ${actual_content}=     create list
        :For        ${i}    IN RANGE    1   ${count}+1
        \           ${actual_Commo}=       Get text        //*[@id="DataTables_Table_0"]/tbody/tr[${i}]/td[1]
        \           Append to list      ${actual_content}      ${actual_commo}
        ${expected_content}     create list     Gold/USD	Palladium/USD	Platinum/USD	Silver/USD
        log     ${actual_content}
        Lists should be equal       ${actual_content}       ${expected_content}

Search for Commodities - Metals
        Click Element       xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input       ${text24}
        ${Gettext}          Get Text       xpath=//*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}         ${text24}
        Clear Element text      xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input        ${text25}
        ${Gettext}          Get Text        //*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}          ${text25}
        Clear Element Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input

Commodities pop up validation - Energy
        Click Element                        //span[contains(@class, 'ui-selectmenu-text') and text() = 'Metals']
        Click Element                        //*[@class='ui-selectmenu-menu ui-front ui-selectmenu-open']/ul/li[2]
        Wait until element is visible        //*[@id="DataTables_Table_0"]/tbody/tr[1]/td[1]     5s
        ${count}=   Get matching xpath count     //*[@id="DataTables_Table_0"]/tbody/tr
        ${actual_content}=     create list
        :For        ${i}    IN RANGE    1   ${count}+1
        \           ${actual_OTC}=       Get text        //*[@id="DataTables_Table_0"]/tbody/tr[${i}]/td[1]
        \           Append to list      ${actual_content}      ${actual_OTC}
        ${expected_content}     create list     Oil/USD
        log     ${actual_content}
        Lists should be equal       ${actual_content}       ${expected_content}

Search for Commodities - Energy
        Click Element       xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input       ${text26}
        ${Gettext}          Get Text       xpath=//*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}         ${text26}
        Clear Element Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input

Navigate to Volatility Indices
        Wait until element is visible          //span[contains(@class, 'ui-selectmenu-text') and text() = 'Commodities']        5s
        Click Element                          //span[contains(@class, 'ui-selectmenu-text') and text() = 'Commodities']
        Click Element                          //*[@class='ui-menu ui-corner-bottom ui-widget ui-widget-content']/li[5]

Volatility Indices pop up validation - Continuous Indices
        Wait until element is visible           //span[contains(@class, 'ui-selectmenu-text') and text() = 'Volatility Indices']     5s
        ${Gettext1}=            Get Text        //span[contains(@class, 'ui-selectmenu-text') and text() = 'Volatility Indices']
        should be equal         ${Gettext1}       ${text33}
        ${Gettext2}=            Get Text        //span[contains(@class, 'ui-selectmenu-text') and text() = 'Continuous Indices']
        should be equal         ${Gettext2}        ${text34}
        Wait until element is visible        //*[@id="DataTables_Table_0"]/tbody/tr[1]/td[1]     5s
        ${count}=   Get matching xpath count     //*[@id="DataTables_Table_0"]/tbody/tr
        ${actual_content}=     create list
        :For        ${i}    IN RANGE    1   ${count}+1
        \           ${actual_CI}=       Get text        //*[@id="DataTables_Table_0"]/tbody/tr[${i}]/td[1]
        \           Append to list      ${actual_content}      ${actual_CI}
        ${expected_content}     create list     Volatility 10 Index	  Volatility 100 Index	  Volatility 25 Index	  Volatility 50 Index	 Volatility 75 Index
        log     ${actual_content}
        Lists should be equal       ${actual_content}       ${expected_content}

Search for Volatility Indices - Continuous Indices
        Click Element       xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input       ${text27}
        ${Gettext}          Get Text       xpath=//*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}         ${text27}
        Clear Element text      xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input        ${text28}
        ${Gettext}          Get Text        //*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}          ${text28}
        Clear Element Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input

Volatility Indices pop up validation - Daily Reset Indices
        Click Element                        //span[contains(@class, 'ui-selectmenu-text') and text() = 'Continuous Indices']
        Click Element                        //*[@class='ui-selectmenu-menu ui-front ui-selectmenu-open']/ul/li[2]
        Wait until element is visible        //*[@id="DataTables_Table_0"]/tbody/tr[1]/td[1]     5s
        ${count}=   Get matching xpath count     //*[@id="DataTables_Table_0"]/tbody/tr
        ${actual_content}=     create list
        :For        ${i}    IN RANGE    1   ${count}+1
        \           ${actual_DRI}=       Get text        //*[@id="DataTables_Table_0"]/tbody/tr[${i}]/td[1]
        \           Append to list      ${actual_content}      ${actual_DRI}
        ${expected_content}     create list     Bear Market Index	        Bull Market Index
        log     ${actual_content}
        Lists should be equal       ${actual_content}       ${expected_content}

Search for Volatility Indices - Daily Reset Indices
        Click Element       xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input       ${text29}
        ${Gettext}          Get Text       xpath=//*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}         ${text29}
        Clear Element text      xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input
        Input Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input        ${text30}
        ${Gettext}          Get Text        //*[@id="DataTables_Table_0"]/tbody/tr/td[1]
        should be equal                     ${Gettext}          ${text30}
        Clear Element Text          xpath=//*[@id="DataTables_Table_0"]/thead/tr/th[1]/input

Close Asset Index pop up
        Wait until element is visible       xpath://INPUT[@class='search-input']/../../../../../../..//SPAN[@class='ui-button-icon ui-icon custom-icon-close']     5s
        Click Element                       xpath://INPUT[@class='search-input']/../../../../../../..//SPAN[@class='ui-button-icon ui-icon custom-icon-close']
        Capture page screenshot             AssetIndexClose.png

