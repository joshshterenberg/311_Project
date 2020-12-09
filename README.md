<h1>&spades; &hearts; &diams; &hearts; Blackjack: Play the Numbers! &spades; &hearts; &diams; &hearts; </h1>
<hr>
<h3>By <a href="http://www.github.com/joshshterenberg">Joshua Shterenberg</a>, 
  <a href="http://www.github.com/jsad2023">Justin Sadler</a>, <a href="http://www.github.com/prithi15">Prithika Ganesh</a>, 
  <a href="http://www.github.com/MJumbrella">Tao Zhang</a></h3>

<h4><em><a href="https://drive.google.com/file/d/1p0nIO-1mr5KoCaxjfPyjTwt6cmd2B4R3/view?usp=sharing">Demo Video</a></em></h4>
<h4><a href="https://www.google.com"><em>Presentation Video</em></a></h4>
<hr>
<p>Welcome to our BU ENG EC311 project repository! This project is a simultaneous gameplay
device and statistical analysis tool for the common casino game: Blackjack. This project
lets the user play the Blackjack game (with a slight modification) and dive into the theory
behind play at the same time, using an Artix-7 FPGA, a 7-segment display and a VGA-connected
display. </p>

<p>To run the project, please download all the files in the Sources and Constraints folders,
and then Synthesize and Implement the code using the Vivado software, generate the associated
Bitstream, and upload it to your FPGA. Be sure to create a new Vivado project and then 
implement the corresponding code as files into the project, not create a project amongst
the files, as file locations will not be straightforward, as Vivado assumes it to be.</p>

<p>The architecture of the code is relatively straightforward: the master file is the foundation
for the two modes of the system, labeled as "ten_second_timer" and "vga_top" in our code.
These two host the main components of their respective modes; ten_second_timer runs the 
central program for the Blackjack game, and vga_top runs the central program for the VGA
display of the statistics of the game. vga_top inherits a horizontal and verical counter
to serve as clocks to update the pizels of the display, and inherits a "fibonacci_lfsr"
module. ten_second_timer also contains a version of fibonacci_lfsr. The purpose of this 
file is to generate pseudo-random numbers, utilizing a Linear Feedback Shift Register,
where the next "random" number it generates is a function of the previous (typically done
using XOR, as actuated in our project). "fsm_for_stay" generates the finite state machine
so that, when a user flips the switch indicating that they want to "stay", the machine will
not revert back to its previous state after this action. Another LFSR module that we were
using, mostly for development purposes, is a little more involved, including a MUX and 
DFlipFlop as foundational modules. All other files included were used for debugging. </p>
