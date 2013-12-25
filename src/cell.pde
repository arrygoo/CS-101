/*
A goal contains the destination position of a Cell
It also contains maxFrames that a cell should take to reach that goal. 
TODO : Should maxFrames be defined in terms of number of frames?
TODO : what is delay?
*/
class Goal {
    float xpos, ypos;

    int delay, maxFrames, frames;
    Goal(float x, float y, int t, int max) {
        xpos = x;
        ypos = y;
        delay = t;
        maxFrames = max;
        frames = 0;
    }
}

/* 
A cell is a representation of an array Element. 
Each cell has a x,y position, width, height, a state (READY, MOVING, DONE), and a Goal (destination location)
*/

class Cell {
    int value;
    color c;
    float xpos;
    float ypos;
    int cell_width, cell_height;
    Goal goal;
    String state;

    /* Constructor 
    TODO : Add color to constants
     */
    Cell(int init_value, float init_x, float init_y, int cell_width_init, int cell_height_init) {
        c = color(255, 0, 0);
        value =  init_value;
        xpos = init_x;
        ypos = init_y;
        cell_width = cell_width_init;
        cell_height = cell_height_init;
        state = "DONE";

    }

    /*
      Displays a cell 
    */
    void display() {
        stroke(0);
        fill(c);
        rectMode(CENTER);
        rect(xpos, ypos, cell_width, cell_height);
        textAlign(CENTER);
        fill(50);
        text(value, xpos, ypos);
        fill(0, 102, 153);
    }

    // Sets a Goal (Destination) for the Cell
    void setGoal(float x, float y, int t, int max) {
        //println("Setting goal");
        goal = new Goal(x, y, t, max);
        state = "MOVING";
    }

    // Goes one step closer to the goal
    // TODO: seems like only Goal.delay is used here. Maybe get rid of Goal.maxFrames ?
    boolean gotoGoal() {
        if (thereYet()) {
            //        println("reached goal");
            xpos = goal.xpos;
            ypos = goal.ypos;
            state = "DONE";
            return true;
        } else {
            //        println("(going): " + (goal.frames));
            goal.frames += 1;
            xpos += (goal.xpos - xpos) / goal.delay;
            ypos += (goal.ypos - ypos) / goal.delay;
            return false;

        }
    }

    // Checks if the cell has reached the Goal that it has.
    boolean thereYet() {
        //    print("\nChecknig if thereYet?");
        //    println(state);
        if (goal != null && goal.frames >= goal.maxFrames
                && (
                    ( (xpos > goal.xpos - 5) && (xpos < goal.xpos + 5) )
                    &&
                    ( (ypos > goal.ypos - 5) && (ypos < goal.ypos + 5) )
                )
           ) {
            //      println("Yes, I'm there!");
            state = "DONE";
            return true;
        } else {
            return false;
        }
    }

}