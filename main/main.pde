/* @pjs pauseOnBlur=true; 
 */

// Aryan Goharzad

//TODO : THESE ARE OUTSIDE EVERYTHING, HAVE TO MOVE SOMEWHERE ELSE

// Constants : 
  final String CMD_RaiseTwo = "raiseTwo";
  final String CMD_LowerTwo = "lowerTwo";
  final String CMD_SwapTwo = "swapTwo";

  final String ALGOR_BUBBLE = "Bubble_Sort";
  final String ALGOR_INSERTION = "Insertion_Sort";
  final String ALGOR_SELECTION = "Selection_Sort";
  
  String input_algor;// = "";//ALGOR_BUBBLE;
  
// End of constants

Prison prison1;
AnimList animList = new AnimList();




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

void insertionSort(AnimList animList,int[] input_array)
{
     int j;                     // the number of items sorted so far
     int key;                // the item to be inserted
     int i;  

     for (j = 1; j < input_array.length; j++)    // Start with 1 (not 0)
    {
           key =input_array[ j ];
           for(i = j - 1; (i >= 0) && (input_array[ i ] < key); i--)   // Smaller values are moving up
          {
                 input_array[ i+1 ] = input_array[ i ];
                 animList.addAnim(CMD_RaiseTwo,i,i+1,prison1);
                 animList.nextFrame();
                 animList.addAnim(CMD_SwapTwo,i,i+1,prison1);
                 animList.nextFrame();
                 animList.addAnim(CMD_LowerTwo,i,i+1,prison1);
                 animList.nextFrame();                 
          }
         input_array[ i+1 ] = key;    // Put the key in its proper location
     }
}

void selectionSort(AnimList animList,int[] input_array)
{
     int i, j, first, temp;  
     for ( i = input_array.length - 1; i > 0; i-- )  
     {
          first = 0;   //initialize to subscript of first element
          for(j = 1; j <= i; j ++)   //locate smallest element between positions 1 and i.
          {
               if( input_array[ j ] <input_array[ first ] )         
                 first = j;
          }
          if (first == i) continue; // Extra line?
          animList.addAnim(CMD_RaiseTwo,first,i,prison1);
          animList.nextFrame();
          animList.addAnim(CMD_SwapTwo,first,i,prison1);
          animList.nextFrame();
          animList.addAnim(CMD_LowerTwo,first,i,prison1);
          animList.nextFrame();
          temp = input_array[ first ];   //swap smallest found with element in position i.
          input_array[ first ] = input_array[ i ];
          input_array[ i ] = temp; 
      }           
}

void setAlgor (String algor){
  println("algor set");
  input_algor = algor;
  println(input_algor);
}

Boolean firstRun = false;

void setup() {  
  if(!firstRun){
    print("SETTTUP");
   firstRun = true; 
  }
  print("SETTTUP");
  size(500,500);
  int[] input_array = {0,5,1,2,3,4};
  
  prison1 = new Prison(input_array);
  
   bubbleSort(animList, input_array);
  /*
  if (input_algor == ALGOR_BUBBLE) {
    bubbleSort(animList, input_array);
    print("bubbleSort");  
  } else if (input_algor == ALGOR_INSERTION ) { 
    insertionSort(animList, input_array);
    print("insertionSort");    
  } else if (input_algor == ALGOR_SELECTION) {
    selectionSort(animList, input_array);
    print("selectionSort");
  } else {
    print("non");
  }
  //selectionSort(animList, input_array);
  
  //insertionSort(animList, input_array);
  */
  animList.addPrison(prison1);
  animList.animReady();
  

}

void draw() {
  background(255);
  prison1.display();
  animList.run_anims();
  
}

class AnimList{
  ArrayList anims;  
  ArrayList prisons;
  int anim_group_index;
  String state;
    AnimList(){       
      anim_group_index = 0;
      anims = new ArrayList();       
      prisons = new ArrayList();
      state = "START";
    }

    void animReady(){
      state="READY";
    }
    
    void nextFrame(){
      addAnim("nextFrame",0,0,prison1);
    }

    void addAnim(String cmd,int x, int y,Object obj){
      Anim newAnim = new Anim(cmd,x,y,obj);            
      anims.add(newAnim);           
    }    
    
    void addPrison(Prison newPrison){
      prisons.add(newPrison);
    }

    void run_anims(){      
      if(state=="READY"){
        doTopAnim();
        state ="MOVING";
      }
      if(state=="MOVING"){        
        //println("MOVING:");
        //println(anims.size());
        if(anims.size() > 0 ){

          //Anim topAnim = (Anim)anims.get(0);
          Prison topPrison = (Prison)prisons.get(0);

          Boolean moveAllBoolean = topPrison.move_all();          
          if(moveAllBoolean){
            //println("done one anim");
            state="READY";
          }
        }else{
          state="DONE";
        }
      }else if(state=="DONE"){
        //println("====================");
        //doTopAnim();        
      } else {
       //println("ERROR"); 
      }
    }

    boolean thereYet(){
      Anim topAnim = (Anim)anims.get(0);
      Prison topPrison = (Prison)prisons.get(0);
      return topPrison.thereYet(topAnim.a);
    }

    void doTopAnim(){
      //println("doing top anim");
      if(anim_group_index < anims.size()){
        Anim topAnim;
        Prison topPrison = (Prison)prisons.get(0);
        
        while(anim_group_index<anims.size()){
          
          topAnim = (Anim)anims.get(anim_group_index);
          
          // setGoal according to top anim
          
          if(topAnim.command=="raise"){
            //println("found raise");
            topPrison.setGoal(topAnim.a,100,200,20,40);
            state="Setting raise";
          }else if(topAnim.command==CMD_RaiseTwo){
            //println("----raiseTwo----");
          
            int cellA = topAnim.a;
            int cellB = topAnim.b;                       
            
            topPrison.setGoal(cellA,
                            topPrison.cells[cellA].xpos,
                            topPrison.cells[cellA].ypos-100
                            ,20,40);
            
            topPrison.setGoal(cellB,
                              topPrison.cells[cellB].xpos,
                              topPrison.cells[cellB].ypos-100
                              ,20,40);                             
                 
          }else if(topAnim.command==CMD_SwapTwo){
            //println("----swap----");
            int cellAIndex = topAnim.a;
            int cellBIndex = topAnim.b;
            Cell cellA = topPrison.cells[cellAIndex];
            Cell cellB = topPrison.cells[cellBIndex];
            
            topPrison.setGoal(cellAIndex,
                            cellB.xpos,
                            cellB.ypos
                            ,20,40);
            
            topPrison.setGoal(cellBIndex,
                              cellA.xpos,
                              cellA.ypos
                              ,20,40);
                                
            // swap A  & B:
            topPrison.cells[cellAIndex] = cellB;
            topPrison.cells[cellBIndex] = cellA;
          }else if(topAnim.command==CMD_LowerTwo){
            //println("----lowerTwo----");
            int cellA = topAnim.a;
            int cellB = topAnim.b;                       
            
            topPrison.setGoal(cellA,
                            topPrison.cells[cellA].xpos,
                            topPrison.cells[cellA].ypos+100
                            ,20,40);
            
            topPrison.setGoal(cellB,
                              topPrison.cells[cellB].xpos,
                              topPrison.cells[cellB].ypos+100
                              ,20,40);          
          } else if (topAnim.command=="nextFrame"){
            anim_group_index++;
            break;
          }
       anim_group_index++;      
      }// end of 
    }
        
    }
}

class Anim{
  public String command;
  public int a, b;
  public Object obj;
  Anim(String cmd,int firstElement, int secondElement,Object obj ){
    command = cmd;
    a = firstElement;
    b =secondElement;
  }
}

class Prison {
  public Cell[] cells;
  int cell_width ;
  int cell_height;
 
  Prison(int cell_nums){
    cells = new Cell[cell_nums];
    cell_width=30;
    cell_height=27;
    for(int i=0;i<cell_nums;i++){
      cells[i] = new Cell(i,100+i*cell_width,200,cell_width,cell_height);
    }
  }
  
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

class Goal{
  float xpos,ypos;
  
  int delay,maxFrames,frames;
  Goal(float x,float y,int t,int max){
    xpos = x;
    ypos = y;
    delay = t;
    maxFrames= max;
    frames=0;
  }
}

class Cell{
  int value;   
  color c;  
  float xpos;
  float ypos;
  int cell_width,cell_height;
  Goal goal;
  String state;
  
  Cell(int init_value,float init_x,float init_y,int cell_width_init,int cell_height_init){
    c = color(255,0,0);
    value =  init_value;
    xpos = init_x;
    ypos = init_y;
    cell_width = cell_width_init;
    cell_height = cell_height_init;
    state = "DONE";
    
  }
  void display() {
    stroke(0);
    fill(c);
    rectMode(CENTER);
    rect(xpos,ypos,cell_width,cell_height);
    textAlign(CENTER);
    fill(50);
    text(value, xpos, ypos);
    fill(0, 102, 153);
  }
  void setGoal(float x, float y,int t,int max){
    //println("Setting goal");
    goal = new Goal(x,y,t,max);
    state = "MOVING";
  }
  boolean gotoGoal(){  
      if(thereYet()){
//        println("reached goal");
        xpos = goal.xpos;
        ypos = goal.ypos;
        state = "DONE"; 
        return true;
      } else {
//        println("(going): " + (goal.frames));
        goal.frames += 1;
        xpos += (goal.xpos-xpos)/goal.delay;
        ypos += (goal.ypos-ypos)/goal.delay;
        return false;
        
      }
  }

  boolean thereYet(){
//    print("\nChecknig if thereYet?");
//    println(state);
    if(goal != null && goal.frames >= goal.maxFrames        
          && (
              ( (xpos > goal.xpos -5) && (xpos < goal.xpos+5) )
              &&
              ( (ypos > goal.ypos -5) && (ypos < goal.ypos+5) )
              )
        ){
//      println("Yes, I'm there!");
      state="DONE";
      return true;
    } 
    else{
      return false;}
  }

}
