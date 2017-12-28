*** Settings ***
Documentation     A Test case file  to test purchase contract.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.

Resource          ../common/resources.robot
Resource          ../common/contractResources.robot

Library           Selenium2Library

*** Test Cases ***
Purchase and verify contract result
    open browser then login
    valid login details
    Switch Virtual Account
    capture page screenshot
    close all current windows
    select market to trade    Volatility Indices      Continuous Indices      Volatility 10 Index
    purchase a contract     5      ticks
    verify contract result
    [teardown]  Close browser