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
      time2string(textstring, mytime);
      display_string(3, textstring);
      display_update();
      tick(&mytime);
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
    prime = nextprime(prime);
    display_image(0,gameBoard);
    display_update();
  }
