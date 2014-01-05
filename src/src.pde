/* @pjs pauseOnBlur=true;
 */

// Aryan Goharzad



Prison prison1;
AnimList animList = new AnimList();

Boolean firstRun = false;

void setup() {
    if (!firstRun) {
        print("SETTTUP\n");
        firstRun = true;
    }
    
    print("SETTTUP\n");
    size(500, 500);
    int[] input_array = {0, 5, 1, 2, 3, 4};

    prison1 = new Prison(input_array);
    
    //bubbleSort(animList, input_array);
    
    // Which algorithm to run?
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
    
    animList.addPrison(prison1);
    animList.animReady();


}

void draw() {
    background(255);
    prison1.display();
    animList.run_anims();

}




