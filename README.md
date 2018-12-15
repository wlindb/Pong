# Pong

Title: Ping Pong Ultimate

Objective: The objective for this project is to create a game of Ping Pong. The game main characteristic
will be that the visual screen on ChipKit equipment will be used to display a game view.

The game view will contain two vertical "bars" which will be located at each side on the screen.

There will also be a moving object in the game view.

The objective of the game is to move the bars in a position where the object will bounce on the bar and
change direction in the opposite way.

The player who moves the bar in a position where the object will bounce back in a way that the other
player won't be able to return it, wins!

Requirements:

* The game will require support for multi-player mode. That is two players versus eachother.

* Different difficulty where the objective will move in a higher speed. Difficulty could be
  changed through the switches. If you switch sw1 on, the object will increase its speed.

* The movement of the bars will be done with the buttons. For example, player one will
  use button 4 and 3, and player two will use 2 and 1.

* Optionial requirements regarding players is to have a one-player mode.

* Optionial requirement to have random objects appearing on the screen, which the players
  will need to avoid in order to not lose.

Solution:

We will use the program language of C to create this game. We will use the Uno32 board and
its possibility to visualize the game. The main functions of the game will be to move
the vertical bars with the button upside and down and adjust the difficulty on the game
with the switches. the difficulty levels that will be available through the switches. we
haven't decided what kind of difficulties yet. To run the screen we will make use of the
time and interrupt functionality from previous lab.


Verification: To make sure the games is working as expected we will try to put the game in
extreme conditions. For example when the ball hits the roof, or the wall, or when we click
two buttons simultaneously


Developers:
Johan Besseling
William Lindblom

Type of project: advanced 
