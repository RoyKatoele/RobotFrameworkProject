*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String 

Suite Setup        Log    I am inside Test Suite Setup
Suite Teardown     Log    I am insite Test Suite Teardown
Test Setup         Log    I am inside Test Setup 
Test Teardown      Log    I am inside Test Teardown
# Hierboven wordt een voorbeeld getoond van een test (suite) setup en test (suite) Teardown. Wat in test setup wordt plaatst wordt uitgevoerd voor elke test of test suite. Wat in test teardown wordt geplaatst wordt uitgevoerd na elke test of test suite.               

Default Tags    Alles zonder tag op testniveau 
# Default Tags zoals hierboven gebruikt zorgt ervoor dat alle testen in deze Suite de tag krijgen zoals benoemd. Met uitzondering van testen die op de volgende manier een tag toegewezen krijgen: [tags]. Tags kan op gefilterd worden in Report.html   

*** Test Cases ***
MyFirstTeSt
    [tags]     Smoke       #Manier van tag toevoegen die er voor zorgt dat deze test NIET terug komt in de default test suite tag.     
    Log        Hello World... 
    
MySecondTeSt    
    Log        Hello World...
    Set Tags   Regressietest 1    #Manier van tag toevoegen die er voor zorgt dat deze test WEL terug komt in de default test suite tag.      
    
MyThirdTeSt    
    Log        Hello World...

Test_Swaglabs -> login and order a product
    # Open the Sauce Demo website in the specified browser and set up the environment
    Open Browser                    ${URL}       ${BROWSERHEADLESS}
    Set Browser Implicit Wait       5
    Set Window Size                 800          600

    # Log in with the provided username and password
    LoginSauceDemo    ${CREDENTIALS}[0]    ${CREDENTIALS}[1]

    # Navigate to the product details page for "Sauce Labs Backpack" and add it to the cart
    Click Link                      Sauce Labs Backpack
    Click Element                   id=add-to-cart
    Element Should Be Visible       id=remove  # Verify that the "Remove" button appears after adding to the cart

    # Proceed to checkout by viewing the cart and clicking the checkout button
    Click Element                   id=shopping_cart_container
    Click Button                    id=checkout

    # Attempt to continue without entering personal details to trigger validation error
    Click Element                   id=continue
    Element Text Should Be          xpath=//h3[@data-test="error"]    Error: First Name is required

    # Fill in the personal details and continue to the overview/summary page
    Input Text                      id=first-name     Roy
    Input Text                      id=last-name      Katoele
    Input Text                      id=postal-code    12345
    Click Element                   id=continue

    # Verify the details on the summary page
    Element Text Should Be          xpath=//div[@data-test="payment-info-label"]    Payment Information:
    Element Text Should Be          xpath=//div[@data-test="payment-info-value"]    SauceCard #31337
    Element Text Should Be          xpath=//div[@data-test="shipping-info-label"]   Shipping Information:
    Element Text Should Be          xpath=//div[@data-test="shipping-info-value"]   Free Pony Express Delivery!
    Element Text Should Be          xpath=//div[@data-test="total-info-label"]      Price Total
    Element Text Should Be          xpath=//div[@data-test="subtotal-label"]        Item total: $29.99
    Element Text Should Be          xpath=//div[@data-test="tax-label"]             Tax: $2.40
    Element Text Should Be          xpath=//div[@data-test="total-label"]           Total: $32.39

    # Close the browser and log the success of the test
    Close Browser
    Log                             Test OK


Test_the-internet_herokuapp
    Open Browser                    https://letcode.in/forms      ${BROWSER}
    Set Browser Implicit Wait       5
    Set Window Size                 800                             600     
    Input Text                      id=firstname    Roy   
    Input Text                      id=lasttname    Katoele
    Clear Element Text              id=email
    Input Text                      id=email    Test@roykatoele.nl
    Click Element                   xpath=/html/body/app-root/app-forms/section[1]/div/div/div[1]/div/div/form/div[8]/div/input
    Close Browser   
    

CreateTXTfile
    ${ran int}=    Generate Random String    length=6    chars=[NUMBERS]
    ${ran int}=    Convert To Integer    ${ran int}
    Log     This is a random number between 1000 and 999999: ${ran int}
    ${ran string}=    Generate Random String    length=6    chars=[LOWER]
    Create File        ${EXECDIR}/file_with_variable.txt          ${ran int} ${\n}                                                #13 maak een txt file aan en vul de eerst regel met een random nummer
    Append To File     ${EXECDIR}/file_with_variable.txt          ${ran string}                                                   #14 voeg aan een txt file een 2de regel toe met een random string  
    Log                Test OK 

    
*** Variables ***
${URL}     https://www.saucedemo.com
@{CREDENTIALS}    standard_user    secret_sauce                               #Dit is een LIST variable
#&{LOGINDATA}      username=standard_user    password=secret_sauce              #Dit is een DICTIONARY variable
${BROWSER}    Chrome
${BROWSERHEADLESS}    headlesschrome
# Er bestaand ook nog BUILD-IN variabelen deze zijn hier te vinden: https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#automatic-variables

*** Keywords ***
LoginSauceDemo
    [Arguments]    ${username}    ${password}
    Input Text                  id=user-name          ${username}
    Input Text                  id=password           ${password}                                         #4. Voer tekst in door gebruik te maken van een Xpath
    Click Button                id=login-button                                                                                        #5. Klik op een knop door gebruik te maken van een ID
    # Hierboven staat een voorbeeld van User made keyword (namelijk: LoginSauceDemo)

    

