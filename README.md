CS-101
======

CS-101 is all about animating computer science algorithms. The initial goal for the project is to animate algorithms alongside with their code like following:
![Alt text](/media/blog/demo1.gif "First demo")

What is done and working?
---------------------------------------------------------
The main animation for bubble sort, insertion sort, and selection sort is presentable.

What is the next step to do?
---------------------------------------------------------
- Cleaning up the code (Adding comments, proper naming, and removing extra code)
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

In this example prison1 and animList are defined earlier in the code as such 
```java
Prison prison1;
AnimList animList = new AnimList();
```

A prison, is a collection of Cells. In the case of an array, a Prison is almost equivelant to an array, except that it's a class with animation functions. A prison is defined as following : 
```java
class Prison {
  public Cell[] cells;
  int cell_width ;
  int cell_height;
 
  // Constructor (value of each cell is equal to its index)
  Prison(int cell_nums){}
  
  // Constructor
  Prison(int [] cell_values){
    int cell_nums = cell_values.length;
    cells = new Cell[cell_values.length];
    cell_width=30;
    cell_height=27;
    for(int i=0;i<cell_nums;i++){
      cells[i] = new Cell(cell_values[i],100+i*cell_width,200,cell_width,cell_height);
    }
  }
  
  void setGoal(int i,float x, float y ,int t,int max){
    //println("Setting goal cell:" + i + " x: " + x + " y: " + y);
    cells[i].setGoal(x,y,t,max);
  }

  boolean  thereYet(int i){
    //print("\nChecknig thereYet");
    //print(i);
    
    return cells[i].thereYet();
  }

  void display(){
    for(int i=0;i<cells.length;i++){
      cells[i].display();
    }    
  }
  boolean move_all(){
    //print("\nMove All");
    boolean non_moving = true;
    boolean all_reached = true;
    for(int i=0;i<cells.length;i++){
      if(cells[i].state=="MOVING"){
        non_moving = false;
        //println("Moving cell:");
        //println(i);
        Boolean gotoGoalBoolean = cells[i].gotoGoal();
        all_reached = all_reached & gotoGoalBoolean;
      }
    }
    return non_moving | all_reached;    
  }
}
```
