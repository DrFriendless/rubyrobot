RUBY ROBOT
==========
An implementation of the Robot programming assignment in Ruby.
The specification of the assignment is not included here in case it is a trade secret.

Installation
------------
No gems are required to install or run the application.
To run the tests, test-unit is needed (but it is in the standard distribution).
To run with code coverage in RubyMine, simplecov is needed.

To Run
------
The main program is main.rb.
It takes any number of parameters, which are the names of files containing programs to be run.
Each program will be run in a new environment (i.e. on a new table).
The output consists of one line for each instruction in the program, showing whether it was executed or ignored.
If the line was a REPORT instruction, the next line will contain the word OUTPUT followed by the output of the REPORT.
 
API
---
This code may be embedded in other applications.
The simplest method is as illustrated in example_tests.rb - create a Runner and give it a String representing the program.
In this case the lines of the program are separated by newlines (\n).

Testing
-------
Tests are in the test subdirectory.
 
example_tests.rb runs the examples from the assignment, and other longer programs from the programs directory.
all_tests.rb runs all of the included tests.

all_tests.rb provides about 99% coverage.
The other lines of code are covered by running main.rb on the example files - in particular, gibberish.txt must be run to test output that an instruction has been ignored. 

Test Programs
-------------
The particular examples from the specification are included in files in the programs subdirectory.
These examples can be run using main.rb as described above, or by running example_tests.rb.


Specification Ambiguities
-------------------------

The specification does not address the issue of invalid arguments to the PLACE instruction. I've chosen to treat them as syntax errors, based on the principle that it's better to fail as soon as possible.
The alternative would be to parse the instruction and ignore it when it is run.
However the specification does not specify valid values for those parameters.

The specification does not address the method in which programs are stored.
The main file here assumes that each program is stored as a separate text file.
The API (described above) may be used to run programs which are Strings from other sources.
Note that there is no way to put a blank line or a comment in a program.

None of the examples from the specification cover the case where the robot would fall off the table.