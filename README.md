# Music-Charts-Visualisation
A Java Processing4 project which visualises music chart data in the form of sine waves 
## Concept
The main logic of this project is based around taking advantage of the following equation.
<p align="justify">$y=A\times sin(2\pi\times f\times t + \phi)$, where $A$ is amplitde, $f$ is frequency and $t$ is time</p>
<p>Taking advantage of this equation entails putting it into terms which can be used in Java Processing4, the output of which is the following...</p>
<p align="justify">$y=H/2+A\times sin((x/W)\times 2\pi\times C+\phi$, where $H$ equals display height, $x$ is the x-axis, $W$ is wave length and $C$ is cycles</p>
Lets break this down:
<ls>
  <li>$time$ becomes $x$ as time is static and rather portrayed as how far along the screen the wave has travelled.</li>
  <li>The inverse of $frequency$ is $1/wave length$ ($W$), thus we divide $x$ by $W$.</li>
  <li>$Cycles$ is added to the equation in order to control the number of wave cycles displayed within the screen width.</li>
</ls>
<p>To apple this to a data set we only need to assign data points to 4 variables: $amplitude$, $wave length$, $cycles$ and $phase speed$ ($\phi$).</p>
