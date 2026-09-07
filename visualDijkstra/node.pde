
class Node{
  int x,y;
  int radius = 65;
  int txtSize = defaultTextSize + 5;

  boolean startingNode = false;
  boolean endNode = false;
  boolean considering = false;
  boolean explored = false;

  int shortestPathValue = 10000; //infinity till made shorter
  int shortest_path;
  
  color fill = color(60,110,200); //default color
  
  Node(int X, int Y){
    x = X;
    y = Y;
  } // constructor

  int getRadius(){
    return radius;
  }
  
  void show(int val){
    //first pick the right fill color for this node
    //default
    fill(fill);

    if(startingNode)
      fill(color(150,30,30));//start node highlighted red
    else if (endNode)
      fill(color(30,150,30));//end node highlighted green

    //(node) outline color and width
    stroke(0);
    strokeWeight(2);  // Default width 2, color is black (0)

    if(mouseOver() && !started)   //if the mouse is above this node, and the algo isnt currently running
      stroke(255);                //make the outline white(255) as visual feedback. 
    if(considering)             
      stroke(color(250, 190, 0)); //if the algorythm is currently considering this node, make outline gold
    
    circle(x, y, radius); //draw the node with chosen details
    
    // display the text on the node in white 
    fill(255);
    textAlign(CENTER, CENTER);
    val++;

    textSize(txtSize);
    int yMargin = 15;
    text(val, x, y - yMargin);

    if( shortestPathValue >= 1000)
      text('∞', x, y + yMargin);
    else
      text(shortestPathValue, x, y + yMargin);
    
    textSize(defaultTextSize);
  }
  
  boolean mouseOver(){

    //distance measure between node and mouse coords
    
    int distX = (mouseX - x);
    int distY = (mouseY - y);

    //if the value is below 0, flip sign

    if(distX < 0)
      distX = distX * -1;
    if(distY < 0)
      distY = distY * -1;
    
    // if the distance from node centre to mouse is less than the radius 

    if ( distX <= radius && distY <= radius){
      return true;  //then the mouse must be above this node
    }
    
    return false;
  }

  PVector position(){
    PVector temp = new PVector(x,y);
    return temp;
  }

  void setAsStartNode(){
    startingNode = true;
    explored = true;
    shortestPathValue = 0;
  }

  void setAsEndNode(){
    endNode = true;
  }

}

class Line{
  int node1, node2; //index of the connected nodes in the map's "nodes" arraylist
  PVector n1, n2;   //the x and y postion of the connected nodes
  int weight = 0;   //the value / weight / time assigned to this node
  int txtSize = floor(width / 25 );
  
  boolean highlight;//is this line supposed to be highlighed

  Line(int n1, int n2){
    node1 = n1;
    node2 = n2;//could just call updateIndex()
  } // constructor

  void show(){
    //default color of the text and the line ( white and dark grey)
    fill(255);
    stroke(100);
    strokeWeight(16);  // Thick line

    if(highlight){     //if the line is being highlighted by the algorythm
      stroke(color(255,190,0)); //gold line
      fill(0);                  //black text
    }
    else if(mouseOver()  && !started){  //if the mouse is above this line, and the algo isnt currently running
      stroke(255); //white line
      fill(0);     //black text 
    }

    line(n1.x, n1.y, n2.x, n2.y); //draw line connecting the centre of the two nodes

    float slope = getSlope();     // using the slope of this line
    int xMid = floor((n2.x + n1.x) / 2 );
    int yMid = floor((n2.y + n1.y) / 2 ); //get the x and y midpoint of the line
    
    if(weight != 0){            //if the line has been assigned a weight
      textSize(txtSize);
      text(weight, xMid, yMid); //display it at the centre of the line 
    }
    //close show
  }

  int getDist(){
    float displacement = sqrt( sq(n2.x - n1.x) + sq(n2.y - n1.y)  );

    int dist = floor( displacement );

    return dist;  //never used. seemingly calculates the length of the line
  }

  float getSlope(){
    float m = ( n2.y - n1.y ) / ( n2.x - n1.x );
    
    return m;
  }//calculates and returns the slope of the line
  
  void setNodes(PVector NODE1, PVector NODE2){
    n1 = NODE1;
    n2 = NODE2;
  }//assign the x and y positions of the nodes

  void updateIndex(int newNode1, int newNode2){
    //if nodes are deleted from map, the indexes of the existing nodes may change
    node1 = newNode1;
    node2 = newNode2;
  }

  boolean mouseOver() {
    int margin = 10;
    float x1 = n1.x;
    float y1 = n1.y;
    float x2 = n2.x;
    float y2 = n2.y;

    float dx = x2 - x1;
    float dy = y2 - y1;

    float lengthSquared = sq(dx) + sq(dy);

    // How far along the line is the closest point?
    float t = ((mouseX - x1) * dx + (mouseY - y1) * dy)/ lengthSquared;

    // Clamp it so we're only checking between n1 and n2
    t = constrain(t, 0, 1);

    // Closest point on the line
    float closestX = x1 + t * dx;
    float closestY = y1 + t * dy;

    // Is mouse within margin pixels of line?
    return dist(mouseX, mouseY, closestX, closestY) < margin;
  }

  void setWeight(int w){
    //function called in map when weight is being assigned
    weight = w;
    if(9 < weight)  //cap the weights at 9
      weight = 0;
    println("Line weight set to: " + weight);
  }

  void highlight(){
    highlight = !highlight;
  }
}