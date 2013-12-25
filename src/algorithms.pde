
// Input : animList, input_array
// Postcondition : animList gets populated (appended) by animations regarding a certain (bubbleSort) algorithm
void bubbleSort(AnimList animList, int[] input_array) {
    int j;
    boolean flag = true;   // set flag to true to begin first pass
    int temp;   //holding variable

    while ( flag ) {
        flag = false;   //set flag to false awaiting a possible swap
        for ( j = 0;  j < input_array.length - 1;  j++ ) {
            if ( input_array[ j ] < input_array[j + 1] ) { // change to > for ascending sort
                animList.addAnim(CMD_RaiseTwo, j, j + 1, prison1);
                animList.nextFrame();
                animList.addAnim(CMD_SwapTwo, j, j + 1, prison1);
                animList.nextFrame();
                animList.addAnim(CMD_LowerTwo, j, j + 1, prison1);
                animList.nextFrame();

                temp = input_array[ j ];                //swap elements
                input_array[ j ] = input_array[ j + 1 ];
                input_array[ j + 1 ] = temp;
                flag = true;              //shows a swap occurred
            }
        }
    }
}


// Input : animList, input_array
// Postcondition : animList gets populated (appended) by animations regarding a certain (insertionSort) algorithm
void insertionSort(AnimList animList, int[] input_array) {
    int j;                     // the number of items sorted so far
    int key;                // the item to be inserted
    int i;

    for (j = 1; j < input_array.length; j++) {  // Start with 1 (not 0)
        key = input_array[ j ];
        for (i = j - 1; (i >= 0) && (input_array[ i ] < key); i--) { // Smaller values are moving up
            input_array[ i + 1 ] = input_array[ i ];
            animList.addAnim(CMD_RaiseTwo, i, i + 1, prison1);
            animList.nextFrame();
            animList.addAnim(CMD_SwapTwo, i, i + 1, prison1);
            animList.nextFrame();
            animList.addAnim(CMD_LowerTwo, i, i + 1, prison1);
            animList.nextFrame();
        }
        input_array[ i + 1 ] = key;  // Put the key in its proper location
    }
}


// Input : animList, input_array
// Postcondition : animList gets populated (appended) by animations regarding a certain (selectionSort) algorithm
void selectionSort(AnimList animList, int[] input_array) {
    int i, j, first, temp;
    for ( i = input_array.length - 1; i > 0; i-- ) {
        first = 0;   //initialize to subscript of first element
        for (j = 1; j <= i; j ++) { //locate smallest element between positions 1 and i.
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
        temp = input_array[ first ];   //swap smallest found with element in position i.
        input_array[ first ] = input_array[ i ];
        input_array[ i ] = temp;
    }
}

