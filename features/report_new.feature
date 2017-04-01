Feature: New Report Template
Background: users logged in to homepage
   Given the following users exist:
    | username   | password 	   	   | email		    | first_name	| last_name	| function			|
    | Jojo       | testpassword123     | 222@gmail.com	| B				| E			| donor management	|
    | Ste        | testpassword123     | 333@gmail.com	| C				| F			| report management	|
    | Bob        | testpassword123     | 444@gmail.com	| C				| F			| dashboard			|
   
  Given I have logged in as "Ste" with "testpassword123"
  And I follow "Report"
	
Scenario: navigate from home page to reports page
  Given I am on the home page
  When I follow "Report"
  Then I should be on the report page

Scenario: navigate from reports page to new report page
  Given I am on the report page
  When I follow "Add New Template"
  Then I should be on the new report page

