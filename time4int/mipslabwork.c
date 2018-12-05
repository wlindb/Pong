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
int lbar[] = {0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0};
int rbar[] = {0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0};
int rightBar[] = {0, 0xF, 0xF0, 0};
int currentIndex = 320;
int ballArray[] = {0, 0, 1, 0};
int direction = 1;


//char textstring[] = "text, more text, and even more text!";

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
  TRISF |= 0x2; // Set PORTF for BTN1 as Input

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

void reset_bars(void){
  int i = 0; 
  while(i<31){
    if (i >= 12 && i <= 19) {
      lbar[i] = 1;
      rbar[i] = 1;
    } else {
      lbar[i] = 0;
      rbar[i] = 0;
    }
    return;
  }
}

/* This function is called repetitively from the main program */
void labwork(void){
    ball();
    delay(15);
    display_image(0, gameBoard);

    if(getbtns() != 0){
      int btns = getbtns();

      // BTN4 Pressed and left bar has not hit the floor
      if((btns>>2) == 1){
          if(lbar[30] != 1){
            int i = 30;
            while(i > 0){
              lbar[i] = lbar[i-1];
              xyBitMap[4][i] = lbar[i];
              i--;
            }
            xyBitMap[4][0] = 1;
            xyBitMap[4][31] = 1;
            bitmapConverter();
        }        
      }

      //BTN3 pressed and left bar has not hit the roof
      if((btns>>1) == 1){
          if(lbar[1] != 1){
            int i = 1;
            while(i < 31){
              lbar[i] = lbar[i+1];
              xyBitMap[4][i] = lbar[i];
              i++;
            }
            xyBitMap[4][0] = 1;
            xyBitMap[4][31] = 1;
            bitmapConverter();
        }
      }

      // BTN2 pressed and right bar has not hit the floor
      if(((btns&1) == 1)){
          if(rbar[30] != 1){
            int i = 30;
            while(i > 0){
              rbar[i] = rbar[i-1];
              xyBitMap[123][i] = rbar[i];
              i--;
            }
            xyBitMap[123][0] = 1;
            xyBitMap[123][31] = 1;
            bitmapConverter();
        } 
      } 
      display_image(0, gameBoard);
      delay(15);
    }

    if(getLastBTN()){
      int BTN1 = getLastBTN();
      if ((BTN1 == 1) ) {
          if(rbar[1] != 1){
            int i = 1;
            while(i < 31){
              rbar[i] = rbar[i+1];
              xyBitMap[123][i] = rbar[i];
              i++;
            }
            xyBitMap[123][0] = 1;
            xyBitMap[123][31] = 1;
            bitmapConverter();
            delay(15);
        }
        display_image(0, gameBoard);
      }
    }
  }
