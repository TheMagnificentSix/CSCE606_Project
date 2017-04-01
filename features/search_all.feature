Feature: Search All From Every Page
Background: users logged in to homepage
   Given the following users exist:
    | username   | password 	   	   | email		    | first_name	| last_name	| function			|
    | Jojo       | testpassword123     | 222@gmail.com	| B0				| Eboy0			| donor management	|
    | Jojo       | testpassword123     | 333@gmail.com	| B1				| Eboy0			| donor management	|
    | Jojo       | testpassword123     | 444@gmail.com	| B2				| Eboy0			| donor management	|

  Given I have logged in as "Jojo" with "testpassword123"

Scenario: Search empty set
  Given I am on donor edit page 1
  When I press "Submit"
  Then I should see "No matching records found"
	
Scenario: Search with name
  Given I am on donor edit page 1
  When I fill in "search" with "B0"
  When I press "Submit"
  Then I should see "Eboy0"