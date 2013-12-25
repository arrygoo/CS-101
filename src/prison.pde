
/* 
A prison consists of Cells. Prison is not technically parent of Cells, because it's a collection of a Cells. 
However, it has many common functions such as setGoal() and thereYet() that call Cell functions
*/
class Prison {
    public Cell[] cells;
    int cell_width ;
    int cell_height;

    /* Constructor
      input : number of cells 
      Value of each cell is assigned equal to the index of cell
      TODO : constants such as  cell_width, cell_height to be moved to a constants file
    */
    Prison(int cell_nums) {
        cells = new Cell[cell_nums];
        cell_width = 30;
        cell_height = 27;
        for (int i = 0; i < cell_nums; i++) {
            cells[i] = new Cell(i, 100 + i * cell_width, 200, cell_width, cell_height);
        }
    }

    /* Constructor
      Input : Array of integers that contains values for each cell
      TODO : constants such as  cell_width, cell_height to be moved to a constants file
    */
    Prison(int [] cell_values) {
        int cell_nums = cell_values.length;
        cells = new Cell[cell_values.length];
        cell_width = 30;
        cell_height = 27;
        for (int i = 0; i < cell_nums; i++) {
            cells[i] = new Cell(cell_values[i], 100 + i * cell_width, 200, cell_width, cell_height);
        }
    }

    // Sets the goal for a Cell inside of this prison
    void setGoal(int i, float x, float y , int t, int max) {
        cells[i].setGoal(x, y, t, max);
    }

    // Input : Cell index
    // checks if the particular cell has reached its goal
    boolean  thereYet(int i) {
        //print("\nChecknig thereYet");
        //print(i);

        return cells[i].thereYet();
    }

    // Displays (updates) all cells
    void display() {
        for (int i = 0; i < cells.length; i++) {
            cells[i].display();
        }
    }

    // Returns if all cells have reached their goals
    // Also Goes thrugh all cells. If the state is moving, it moves it one step forward
    boolean move_all() {
        //print("\nMove All");
        boolean atleast_one_moving = false;
        boolean all_reached = true;
        for (int i = 0; i < cells.length; i++) {
            if (cells[i].state == "MOVING") {
                atleast_one_moving = true;
                //println("Moving cell:");
                //println(i);
                Boolean gotoGoalBoolean = cells[i].gotoGoal();
                all_reached = all_reached & gotoGoalBoolean;
            }
        }
        return atleast_one_moving & all_reached;
    }
}
