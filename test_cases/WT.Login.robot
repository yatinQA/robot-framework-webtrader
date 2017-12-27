*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.

Resource          ../common/WT.resources.robot

Library           Selenium2Library


*** Test Cases ***

Webtrader Login & Switch

        Switch Virtual Account

