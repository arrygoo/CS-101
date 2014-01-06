
// Input : animList, input_array
// Postcondition : animList gets populated (appended) by animations regarding a certain (bubbleSort) algorithm
void bubbleSort(AnimList animList, int[] input_array) {
    int j;
    boolean flag = true;   // set flag to true to begin first pass
    int temp;   //holding variable
    int swap = 0;
    int compare = 0;
    
    while ( flag ) {
        flag = false;   //set flag to false awaiting a possible swap
        for ( j = 0;  j < input_array.length - 1;  j++ ) {
            compare++;
            if ( input_array[ j ] < input_array[j + 1] ) { // change to > for ascending sort
                animList.addAnim(CMD_RaiseTwo, j, j + 1, prison1);
                animList.nextFrame();
                animList.addAnim(CMD_SwapTwo, j, j + 1, prison1);
                animList.nextFrame();
                animList.addAnim(CMD_LowerTwo, j, j + 1, prison1);
                animList.nextFrame();

                swap++;
                temp = input_array[ j ];                //swap elements
                input_array[ j ] = input_array[ j + 1 ];
                input_array[ j + 1 ] = temp;
                flag = true;              //shows a swap occurred
            }
        }
    }
    println("swaps\n" + swap + "\ncompares\n" + compare);
}


// Input : animList, input_array
// Postcondition : animList gets populated (appended) by animations regarding a certain (insertionSort) algorithm
void insertionSort(AnimList animList, int[] input_array) {
    int j;                     // the number of items sorted so far
    int key;                // the item to be inserted
    int i;
    int swap = 0;
    int compare = 0;
    
    for (j = 1; j < input_array.length; j++) {  // Start with 1 (not 0)
        key = input_array[ j ];
        for (i = j - 1; (i >= 0) && (input_array[ i ] < key); i--) { // Smaller values are moving up
            compare++;
            
            input_array[ i + 1 ] = input_array[ i ];
            swap++;
            
            animList.addAnim(CMD_RaiseTwo, i, i + 1, prison1);
            animList.nextFrame();
            animList.addAnim(CMD_SwapTwo, i, i + 1, prison1);
            animList.nextFrame();
            animList.addAnim(CMD_LowerTwo, i, i + 1, prison1);
            animList.nextFrame();
        }
        input_array[ i + 1 ] = key;  // Put the key in its proper location
    }
    println("swaps\n" + swap + "\ncompares\n" + compare);
}


// Input : animList, input_array
// Postcondition : animList gets populated (appended) by animations regarding a certain (selectionSort) algorithm
void selectionSort(AnimList animList, int[] input_array) {
    int i, j, first, temp;
    int swap = 0;
    int compare = 0;
    
    for ( i = input_array.length - 1; i > 0; i-- ) {
        first = 0;   //initialize to subscript of first element
        for (j = 1; j <= i; j ++) { //locate smallest element between positions 1 and i.
            compare++;
            if ( input_array[ j ] < input_array[ first ] )
                first = j;
        }
        if (first == i) continue; // Extra line?
        animList.addAnim(CMD_RaiseTwo, first, i, prison1);
        animList.nextFrame();
        animList.addAnim(CMD_SwapTwo, first, i, prison1);
        animList.nextFrame();
        animList.addAnim(CMD_LowerTwo, first, i, prison1);
        animList.nextFrame();
        
        swap++;
        temp = input_array[ first ];   //swap smallest found with element in position i.
        input_array[ first ] = input_array[ i ];
        input_array[ i ] = temp;
    }
    
    println("swaps\n" + swap + "\ncompares\n" + compare);
}

void gnomeSort(AnimList animList, int[] input_array) {
    int swap = 0;
    int compare = 0;
    int i = 1;
    int j = 2;
    int temp; // holds the number that's being swapped
    
    while (i < input_array.length) {
        compare++;
        if (input_array[i - 1] >= input_array[i]) {
     
            i = j;
            j++;
    
        } else {
            //swap animation
            animList.addAnim(CMD_RaiseTwo, i - 1, i, prison1);
            animList.nextFrame();
            animList.addAnim(CMD_SwapTwo, i - 1, i, prison1);
            animList.nextFrame();
            animList.addAnim(CMD_LowerTwo, i - 1, i, prison1);
            animList.nextFrame();
            
            swap++;  //actual swap
            temp = input_array[i];
            input_array[i] = input_array[i - 1];
            input_array[i - 1] = temp;
            
            i--;
            
            if (i == 0) {
                i = j;
                j++;
            }
        }
    }
    println("swaps\n" + swap + "\ncompares\n" + compare);
}
