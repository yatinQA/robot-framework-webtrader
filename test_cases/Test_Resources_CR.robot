*** Settings ***

Documentation  This is to test Resources module of WebTrader



Resource          ../common/resources.robot
Resource          ../common/contractResources.robot
Resource          ../common/ResourcesTestResource.robot


Library      Selenium2Library
Library      String
Library      Collections



*** Test Cases ***

Login to WebTrader
   open browser then login
   valid login details
   Switch Virtual Account

Test Asset Index
   Navigate to Asset Index pop up

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

Asset Index - Volatility Indices
   Navigate to Volatility Indices
   Volatility Indices pop up validation - Continuous Indices
   Search for Volatility Indices - Continuous Indices
   Volatility Indices pop up validation - Daily Reset Indices
   Search for Volatility Indices - Daily Reset Indices

Close Asset Index
   Close Asset Index pop up
   [teardown]    close browser