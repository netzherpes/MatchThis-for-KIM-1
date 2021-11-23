# MatchThis-for-KIM-1
 >by Gino F. Silvestri <br>
 >Engeneering Division <br>
 >Loral Electronic Systems <br>
 >999 Central Park Avenue <br>
 >Yonkers, NY 10704 <br>

A Simon says game for the KIM-1

Try to memorize KIM's random tone/light Pattern - Bonus Points (Lifes) are given for reaching Milestones.
An interactive Ggame for a 'naked' KIM-1

This Game requires a speaker / amp connectiion to the KIMs application connector as shown on page 57 in the KIm-1 User's Manual.

The game initializes the Zeropage locations by itself. 
Start at $0200
occupies Mem to $036D

When GO is pressed a random chosen number [0..3] will appear on the display. a tone ralated to this number is being played. 
When the number disappears the KIM awaits your response. If you hit the same key, the number / tone wil be generated.
The right digit wil increment.

and so on.... read the manual ;)
