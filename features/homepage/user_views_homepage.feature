Feature: User views homepage
  In order to see the latest activity in Kassi
  As a user
  I want see latest offers, requests and transactions on the home page
  
  @javascript
  Scenario: Latest offers on the homepage
    Given there are following users:
      | person | 
      | kassi_testperson1 |
    And there is item offer with title "car spare parts" from "kassi_testperson1" and with share type "sell"
    And there is item offer with title "bike" from "kassi_testperson1" and with share type "sell"
    And that listing is closed
    And there is item request with title "saw" from "kassi_testperson2" and with share type "buy"
    And visibility of that listing is "kassi_users"
    When I am on the homepage
    And I should see "car spare parts"
    And I should see "Request item"
    And I should not see "bike"
    And I should not see "saw"
    And I log in as "kassi_testperson1"
    Then I should see "saw"
    And I should see "car spare parts"
    And I should not see "bike"
    And I should not see "Request item"
    And I should see "Offer your item"
  
  Scenario: Latest requests on the homepage
    Given there are following users:
      | person | 
      | kassi_testperson1 |
      | kassi_testperson2 |
    And there is favor request with title "massage" from "kassi_testperson2"
    And I am logged in as "kassi_testperson1"
    When I am on the homepage
    Then I should see "massage"
    And I should not see "offer item"
  
  @javascript
   Scenario: User browses requests with visibility settings
     Given there are following users:
       | person | 
       | kassi_testperson1 |
     And there is item request with title "car spare parts" from "kassi_testperson2" and with share type "buy"
     And visibility of that listing is "kassi_users"
     And there is favor request with title "massage" from "kassi_testperson1"
     And I am on the requests page
     And I should not see "car spare parts"
     And I should see "massage"
     When I log in as "kassi_testperson1"
     And I follow "Requests"
     Then I should see "car spare parts"
     And I should see "massage"
  
  
  @pending
  Scenario: Latest transcations on the homepage
    Given the latest transaction is "Johnny offered an item drill to Bill" #This Given needs better structure
    When I am on the homepage
    Then I should see "Johnny offered an item drill to Bill"
    
  @pending
  Scenario: Endless scrolling
    Given there are 13 open offers
    And the oldest offer has title "course books"
    And I am on the home page
    And I do not see "course books"
    When I scroll to the bottom of the page
    And wait for 2 seconds
    Then I should see "course books"
  
  
  
  
  
  
  
  
  
  