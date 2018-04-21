*** Settings ***
Library           Selenium2Library
Library           Dialogs

*** Test Cases ***
Open google chrome
    ${opt}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Comment    Require no sandbox and disable setuid sandbox for support chrome on linux
    Call Method    ${opt}    add_argument    --no-sandbox
    Call Method    ${opt}    add_argument    --disable-setuid-sandbox
    Comment    Call Method    ${opt}    add_argument    --proxy-server\=http://localhost:3128
    Call Method    ${opt}    add_argument    --proxy-server\=http://172.16.0.60:3128
    Create Webdriver    Chrome    chrome_options=${opt}
    Go To    http://whatismyipaddress.com/
    Capture Page Screenshot
    [Teardown]    Close Browser
