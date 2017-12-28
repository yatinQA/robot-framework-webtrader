*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.

Resource          ../common/resources.robot

Library           Selenium2Library


*** Test Cases ***

Webtrader Login & Switch
      open browser then login
      Switch Virtual Account
      [teardown]    close browser