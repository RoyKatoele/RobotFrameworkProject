*** Settings ***
Library    SeleniumLibrary

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
    
GoogleSearch
    Open Browser                http://www.google.nl        chrome    #1. Open een browser
    Set Browser Implicit Wait   5
    Input Text                  name=q                      "roy katoele"
    Sleep                       2 
    Press Keys                  name=q                      ENTER
    # Click Button              name=btnK
    Close Browser
    Log                         Test OK
    
SiteRoyKatoele
    Open Browser                ${URL}        chrome
    Set Browser Implicit Wait   5
    Set Window Size             800                             600    #2. Pas de browser groote aan (breedte en hoogte)
    Click Element               link=Heb je alles getest?
    Close Browser
    Log                         Test OK      
    
SiteRoyKatoeleInlog
    [Documentation]             Dit is een login test
    Open Browser                https://opensource-demo.orangehrmlive.com/      chrome
    Set Browser Implicit Wait   10
    LoginKW                     # hier gebruik ik mijn aangemaakte USER keyword
    Click Element               id=welcome
    Click Element               link=Logout                                                #7. Klik een element op basis van de link tekst 
    Close Browser
    Log                         Test OK
    Log                         This test was executed by %{username} on %{os}    #Dit zijn ENVIROMENT variabelen, hiermee kun jij bijvoorbeeld op welk OS de test is uit gevoerd door welke user       
    
*** Variables ***
${URL}            http://www.roykatoele.nl                         #Dit is een SCALAR variable  
@{CREDENTIALS}    Admin    admin123                                #Dit is een LIST variable
&{LOGINDATA}      username=Admin    password=admin123              #Dit is een DICTIONARY variable
# Er bestaand ook nog BUILD-IN variabelen deze zijn hier te vinden: https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#automatic-variables

*** Keywords ***
LoginKW
    Input Text                  id=txtUsername                   @{CREDENTIALS}[0]         #3. Voer tekst in door gebruik te maken van een ID
    Input Text                  xpath=//*[@id="txtPassword"]      &{LOGINDATA}[password]   #4. Voer tekst in door gebruik te maken van een Xpath
    Click Button                id=btnLogin                                                #5. Klik op een knop door gebruik te maken van een ID
    # Hierboven staat een voorbeeld van User made keyword (namelijk: LoginKW)
    

#no longer needed:
#    Mouse Over                  link=Howdy, Katoeler                                        #6. Hover over een tekst door gebruik te maken van de link tekst