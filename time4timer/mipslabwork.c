/* mipslabwork.c

   This file written 2015 by F Lundevall
   Updated 2017-04-21 by F Lundevall

   This file should be changed by YOU! So you must
   add comment(s) here with your name(s) and date(s):

   This file modified 2017-04-31 by Ture Teknolog 

   For copyright and licensing, see file COPYING */

#include <stdint.h>   /* Declarations of uint_32 and the like */
#include <pic32mx.h>  /* Declarations of system-specific addresses etc */
#include "mipslab.h"  /* Declatations for these labs */

void timer2delay(void);

int timeoutcount = 0; 
int mytime = 0x5957;
char textstring[] = "text, more text, anddisplay_imagedisplay_image even more text!";

/* Interrupt Service Routine */
void user_isr(void)
{
  return;
}

/* Initialization of i/o */
void labinit(void)
{
  volatile int* trisE = (volatile int*) 0xbf886100; 
  *trisE &= ~0xff;
  TRISD |= 0x7f0;
}

void timer2delay(void){
  T2CON = 0x0;            // Clear Timer 2 con register
  T2CON = 0x8070;         // Set timer on (0x8000), pre scale 256:1 (0x0070) 

  TMR2 = 0x0;             // Reset Timer
  PR2 = 31250;            // 80 Mhz/256/10 = PR2
  IFS(0) = 0x0;           // Clear flag
  
  
  while (IFS(0) == 0x0);  // Loop until flag is set. 
}

/* This function is called repetitively from the main program */
void labwork(void) {

  timeoutcount++;
  timer2delay();
  //delay(1000); // delay(1000) at start.
  if(timeoutcount == 10){
    timeoutcount = 0;
    time2string(textstring, mytime);
    //display_string(3, textstring);
    //display_update();
    tick(&mytime);
  }
  
  /* DISPLAY BALL */

  //display_image(0, icon);
  
  // Check if any btns pressed
  if(getbtns() != 0){
      int switches = getsw();
      int btns = getbtns();
      // Check if btn4 is pressed
      if(btns>>2 == 1){
        mytime = (mytime&(~0xf000))|(switches<<12);
      }
      // Check if btn3 is pressed
      if((btns&2) == 2){
        mytime = (mytime&(~0x0f00))|(switches<<8);
      }
      // Check if btn2 is pressed
      if((btns&1) == 1){
        mytime = (mytime&(~0x00f0))|(switches<<4);
      }
  }
}
