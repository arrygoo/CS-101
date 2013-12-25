CS-101
======

CS-101 (www.cs-101.com) is all about animating computer science algorithms. The initial goal for the project is to animate algorithms alongside with their code like following:
![Alt text](/media/blog/demo1.gif "First demo")

What is done and working?
---------------------------------------------------------
The main animation for bubble sort, insertion sort, and selection sort is presentable.

What is the next step to do?
---------------------------------------------------------
- Cleaning up the code (Doing TODOs)
- Breaking down the code into separate files
- Breaking down this readme file into wiki and issues page

How does the animation framework work?
----------------------------------------------------------
Here's an example that animates bubble sort

```java
void bubbleSort(AnimList animList,int[] input_array){  
   int j;
   boolean flag = true;   // set flag to true to begin first pass
   int temp;   //holding variable

   while ( flag )
   {
          flag= false;    //set flag to false awaiting a possible swap
          for( j=0;  j < input_array.length -1;  j++ )
          {
                 if ( input_array[ j ] < input_array[j+1] )   // change to > for ascending sort
                 {
                       animList.addAnim(CMD_RaiseTwo,j,j+1,prison1);
                       animList.nextFrame();
                       animList.addAnim(CMD_SwapTwo,j,j+1,prison1);
                       animList.nextFrame();
                       animList.addAnim(CMD_LowerTwo,j,j+1,prison1);
                       animList.nextFrame();
                         
                        temp = input_array[ j ];                //swap elements
                        input_array[ j ] = input_array[ j+1 ];
                        input_array[ j+1 ] = temp;
                        flag = true;              //shows a swap occurred  
                } 
          } 
    } 
}
```
As it can be seen above, the lines that add the animations for bubblesort to the list of animations are the following :
```java
    animList.addAnim(CMD_RaiseTwo,j,j+1,prison1);
    animList.nextFrame();
    animList.addAnim(CMD_SwapTwo,j,j+1,prison1);
    animList.nextFrame();
    animList.addAnim(CMD_LowerTwo,j,j+1,prison1);
    animList.nextFrame();
```

More information about the structure of the code in the wiki.
