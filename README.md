# MatchThis-for-KIM-1
 >by Gino F. Silvestri <br>
 >Engeneering Division <br>
 >Loral Electronic Systems <br>
 >999 Central Park Avenue <br>
 >Yonkers, NY 10704 <br>

A Simon says game for the KIM-1

![ss][1]

Try to memorize KIM's random tone/light Pattern - Bonus Points (Lifes) are given for reaching Milestones.
An interactive game for a 'naked' KIM-1

This game supports a speaker / amp connection to the KIMs application connector as shown on page 57 in the KIm-1 User's Manual.

The game initializes the Zeropage locations by itself. 
Start at $0200
occupies memory to $036D

When GO is pressed a random chosen number [0..3] will appear on the display. A tone related to this number is being played. 
When the number disappears the KIM awaits your response. If you hit the same key, the number / tone will be generated.
The right digit will increment.

and so on.... read the manual ;)

 [1]: https://github.com/netzherpes/MatchThis-for-KIM-1/blob/main/MatchThis_sm.JPG?raw=true
