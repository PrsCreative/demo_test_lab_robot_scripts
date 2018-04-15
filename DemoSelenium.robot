*** Settings ***
Library           Selenium2Library
Library           String

*** Test Cases ***
Demo Open Browser
    Open Chrome Browser
    Go To    https://www.google.com
    Input Text    Id=lst-ib    Robotframework
    Wait Until Page Contains Element    css=input.lsb    5 seconds
    Click Element    css=input.lsb
    Page Should Contain    robotframework.org
    ${result stat} =    Get Text    Id=resultStats
    LOG    ${result stat}
    ${total result} =    Get Regexp Matches    ${result stat}    ([0-9]+,[0-9]+)
    LOG    ${total result}
    ${total result} =    Replace String    ${total result[0]}    ,    ${EMPTY}
    Should Be True    ${total result} \ > 100000
    [Teardown]    Close All Browsers

*** Keywords ***
Open Chrome Browser
    ${opt}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Comment    Require no sandbox and disable setuid sandbox for support chrome on linux
    Call Method    ${opt}    add_argument    --no-sandbox
    Call Method    ${opt}    add_argument    --disable-setuid-sandbox
    Create Webdriver    Chrome    chrome_options=${opt}
