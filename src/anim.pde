
/*
A class containing list of animations to run

*/
class AnimList {
    ArrayList anims;
    ArrayList prisons;
    int anim_group_index;
    String state;

    // Constructor
    AnimList() {
        anim_group_index = 0;
        anims = new ArrayList();
        prisons = new ArrayList();
        state = "START";
    }

    // Set state to ready
    void animReady() {
        state = "READY";
    }

    /* Add a nextFrame to animList. This is used to separate animations that are supposed to run simultanously as opposed to one after each other

    Example:

    animList.addAnim(CMD_RaiseTwo, j, j + 1, prison1);
    animList.nextFrame();
    animList.addAnim(CMD_SwapTwo, j, j + 1, prison1);
    animList.nextFrame();

    vs 

    animList.addAnim(CMD_RaiseTwo, j, j + 1, prison1);
    animList.addAnim(CMD_SwapTwo, j, j + 1, prison1);
    animList.nextFrame();
    */
    void nextFrame() {
        addAnim("nextFrame", 0, 0, prison1);
    }

    /* Input cmd = a command, 
      x = index of first item
      y = index for second item for which the command would be executed
      obj = TODO 

    adds the animation to the AnimList
    */
    void addAnim(String cmd, int x, int y, Object obj) {
        Anim newAnim = new Anim(cmd, x, y, obj);
        anims.add(newAnim);
    }

    // Adds prison to AnimList 
    // TODO : fix structure for this. What is it doing? Why do we need a prison to be added to the AnimList rather than to each element of AnimList
    void addPrison(Prison newPrison) {
        prisons.add(newPrison);
    }

    /* Run the appropriate function based on the "State"
      "READY" -> 
        doTopAnim()
        "Moving"

      "MOVING" ->
        move_all()
          "READY" (if one anim is done)
        "DONE" (if all anims are done)
      
      TODO : Switch strings with constants
    */
    void run_anims() {
        if (state == "READY") {
            doTopAnim();
            state = "MOVING";
        }
        if (state == "MOVING") {
            //println("MOVING:");
            //println(anims.size());
            // If there are any anims in AnimList
            if (anims.size() > 0 ) {

                //Anim topAnim = (Anim)anims.get(0);
                Prison topPrison = (Prison)prisons.get(0);

                Boolean moveAllBoolean = topPrison.move_all();
                if (moveAllBoolean) {
                    //println("done one anim");
                    state = "READY";
                }
            } else {
                state = "DONE";
            }
        } else if (state == "DONE") {
            println("DONE");
        } else {
            println("ERROR");
        }
    }

    // Returns true if the top prison has reached its goal
    boolean thereYet() {
        Anim topAnim = (Anim)anims.get(0);
        Prison topPrison = (Prison)prisons.get(0);
        return topPrison.thereYet(topAnim.a);
    }

    /* This is where the animation for each action such as "raise", "Swap", etc is defined. 
    doTopAnim() reads the top anim in AnimList and sets a goal using Prison.setGoal() to set the goal for each individual cell
    */
    void doTopAnim() {
        //println("doing top anim");
        if (anim_group_index < anims.size()) {
            Anim topAnim;
            Prison topPrison = (Prison)prisons.get(0);

            while (anim_group_index < anims.size()) {
                println("anim_group_index");
                println(anim_group_index);

                println("anims.size()");
                println(anims.size());

                topAnim = (Anim)anims.get(anim_group_index);

                // setGoal according to top anim

                if (topAnim.command == "raise") {
                    //println("found raise");
                    topPrison.setGoal(topAnim.a, 100, 200, 20, 40);
                    state = "Setting raise";
                } else if (topAnim.command == CMD_RaiseTwo) {
                    //println("----raiseTwo----");

                    int cellA = topAnim.a;
                    int cellB = topAnim.b;

                    topPrison.setGoal(cellA,
                                      topPrison.cells[cellA].xpos,
                                      topPrison.cells[cellA].ypos - 100
                                      , 20, 40);

                    topPrison.setGoal(cellB,
                                      topPrison.cells[cellB].xpos,
                                      topPrison.cells[cellB].ypos - 100
                                      , 20, 40);

                } else if (topAnim.command == CMD_SwapTwo) {
                    //println("----swap----");
                    int cellAIndex = topAnim.a;
                    int cellBIndex = topAnim.b;
                    Cell cellA = topPrison.cells[cellAIndex];
                    Cell cellB = topPrison.cells[cellBIndex];

                    topPrison.setGoal(cellAIndex,
                                      cellB.xpos,
                                      cellB.ypos
                                      , 20, 40);

                    topPrison.setGoal(cellBIndex,
                                      cellA.xpos,
                                      cellA.ypos
                                      , 20, 40);

                    // swap A  & B:
                    topPrison.cells[cellAIndex] = cellB;
                    topPrison.cells[cellBIndex] = cellA;
                } else if (topAnim.command == CMD_LowerTwo) {
                    //println("----lowerTwo----");
                    int cellA = topAnim.a;
                    int cellB = topAnim.b;

                    topPrison.setGoal(cellA,
                                      topPrison.cells[cellA].xpos,
                                      topPrison.cells[cellA].ypos + 100
                                      , 20, 40);

                    topPrison.setGoal(cellB,
                                      topPrison.cells[cellB].xpos,
                                      topPrison.cells[cellB].ypos + 100
                                      , 20, 40);
                } else if (topAnim.command == "nextFrame") {
                    anim_group_index++;
                    break;
                }
                anim_group_index++;
            }// end of
        }

    }
}

/* Class containing one Anim
Each anim consists of a command, and a first and second element on which the action takes place
TODO : Remove obj from class
*/
class Anim {
    public String command;
    public int a, b;
    public Object obj;
    Anim(String cmd, int firstElement, int secondElement, Object obj ) {
        command = cmd;
        a = firstElement;
        b = secondElement;
    }
}

