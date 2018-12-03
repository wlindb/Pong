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

int mytime = 0x5957;
int leftBar[] = {0, 0xF, 0xF0, 0};
int rightBar[] = {0, 0xF, 0xF0, 0};

char textstring[] = "text, more text, and even more text!";

/* Set ports in TRISE for PORTE to be either open
 or closed */

volatile int* trisE = (volatile int*) 0xbf886100;
volatile int* portE = (volatile int*) 0xbf886110;
int timeoutcount = 0;
int prime = 1234567;

/* Interrupt Service Routine */
void user_isr(void){


    if(IFS(0) & 0x0100){
      timeoutcount++;
    if(timeoutcount == 10){
      //time2string(textstring, mytime);
      //display_string(3, textstring);
      //display_update();
      //tick(&mytime);
      timeoutcount = 0;
    }
    IFS(0) &= ~0x0100;
  }

if(IFS(0) & 0x080)
    if(*portE == 255){
        *portE = 0;
    }else{
        *portE = *portE + 1;
    }

    IFS(0) &= 0xf7f ;
}

/* Lab-specific initialization goes here */
void labinit(void){
  *trisE &= ~0xff;
  TRISD |= 0x7f0;

  //Timer 2 interrupt
  IEC(0) = 0x180;
  IPC(2) = 0x1f;
  IPC(1) |= 0x05000000;
  enable_interrupt();

  // SW1 interrupts


  TMR2 = 0;
  PR2 = 31250;
  T2CON = 0x8070;

}

/* This function is called repetitively from the main program */
void labwork(void){
    //prime = nextprime(prime);
    //display_image(0,gameBoard);
    //display_update();
    if(getbtns() != 0){
      int switches = getsw();
      int btns = getbtns();

      // BTN4 Pressed and left bar has not hit the floor
      if(((btns>>2) == 1) && !(leftBar[0]&64)){
        
        leftBar[0] = ((leftBar[0]<<1)|(leftBar[1]>>7)); //row4
        leftBar[1] = (leftBar[1]<<1)|(leftBar[2]>>7); //row3
        leftBar[2] = (leftBar[2]<<1)|(leftBar[3]>>7); //row2
        leftBar[3] = (leftBar[3]<<1); // row1

        gameBoard[4] = leftBar[3]|0x1;
        gameBoard[128+4] = leftBar[2];
        gameBoard[256+4] = leftBar[1];
        gameBoard[384+4] = leftBar[0]|0x80;
        display_image(0,gameBoard);
        quicksleep(100000);
      }
      //BTN3 pressed and left bar has not hit the roof
      if(((btns>>1) == 1) && !(leftBar[3]&2)){

        leftBar[3] = ((leftBar[3]>>1)|(leftBar[2]<<7)); //row4
        leftBar[2] = (leftBar[2]>>1)|(leftBar[1]<<7); //row3
        leftBar[1] = (leftBar[1]>>1)|(leftBar[0]<<7); //row2
        leftBar[0] = (leftBar[0]>>1); // row1

        gameBoard[4] = leftBar[3]|0x1;
        gameBoard[128+4] = leftBar[2];
        gameBoard[256+4] = leftBar[1];
        gameBoard[384+4] = leftBar[0]|0x80;
        display_image(0,gameBoard);
        quicksleep(100000);
      }

      // BTN2 pressed and right bar has not hit the floor
      if(((btns&1) == 1) && !(rightBar[0]&64)){
        rightBar[0] = ((rightBar[0]<<1)|(rightBar[1]>>7)); //row4
        rightBar[1] = (rightBar[1]<<1)|(rightBar[2]>>7); //row3
        rightBar[2] = (rightBar[2]<<1)|(rightBar[3]>>7); //row2
        rightBar[3] = (rightBar[3]<<1); // row1

        gameBoard[123] = rightBar[3]|0x1;
        gameBoard[251] = rightBar[2];
        gameBoard[379] = rightBar[1];
        gameBoard[507] = rightBar[0]|0x80;
        display_image(0,gameBoard);
        quicksleep(100000);
      }
    }
  }
