
class Node{
  int x,y;
  int radius = 65;

  boolean startingNode = false;
  boolean endNode = false;
  boolean considering = false;
  boolean explored = false;

  int prevNodeInPath = -1;
  int shortestPathValue = 10000; //infinity till made shorter
  
  color fill = color(60,110,200); //default color
  
  Node(int X, int Y){
    x = X;
    y = Y;
  }

  int getRadius(){
    return radius;
  }
  
  void show(int val){
    fill(fill);
    if(startingNode)
      fill(color(150,30,30));
    else if (endNode)
      fill(color(30,150,30));
    stroke(0);
    strokeWeight(2);  // Default

    if(mouseOver())
      stroke(255);
    if(considering)
      stroke(color(250, 250, 0));
    
    circle(x, y, radius);
    fill(255);
    textAlign(CENTER, CENTER);
    val++;

    textSize(35);
    int yMargin = 15;
    text(val, x, y - yMargin);

    if( shortestPathValue >= 1000)
      text('∞', x, y + yMargin);
    else
      text(shortestPathValue, x, y + yMargin);
     textSize(30);
  }
  
  boolean mouseOver(){
    int distX = (mouseX - x);
    int distY = (mouseY - y);
    
    if(distX < 0)
      distX = distX * -1;
    if(distY < 0)
      distY = distY * -1;

    if ( distX <= radius && distY <= radius){
      return true;
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
  int node1, node2;
  PVector n1, n2;
  int weight = 0;
  
  boolean highlight;

  Line(int n1, int n2){
    node1 = n1;
    node2 = n2;
  }

  void show(){
    fill(255);
    stroke(100);
    strokeWeight(16);  // Thicker

    if(highlight){
      stroke(color(255,190,0));
      fill(0);
    }
    else if(mouseOver()){
      //
      stroke(200);
      fill(0);
    }
    //

    line(n1.x, n1.y, n2.x, n2.y);

    float slope = getSlope();
    int xMid = floor((n2.x + n1.x) / 2 );
    int yMid = floor((n2.y + n1.y) / 2 );
    int space = 50;
    float margin = 0.5;

    /*
      if(-margin < slope && slope < margin){
        //directly above @ m = 0 
        space = floor(space/2);
        yMid = yMid - space;
      }else if(slope < 0){
        //diplay Length to the right
        space = space + 5;
        xMid = xMid + space;
      } else if (slope > 0){
        //display L to the left
        xMid = xMid - space;
      } 
    //*/

    if(weight != 0)
      text(weight, xMid, yMid); 

  }

  int getDist(){
    float displacement = sqrt( sq(n2.x - n1.x) + sq(n2.y - n1.y)  );

    int dist = floor( displacement );

    return dist;
  }

  float getSlope(){
    float m = ( n2.y - n1.y ) / ( n2.x - n1.x );
    
    return m;
  }
  
  void setNodes(PVector NODE1, PVector NODE2){
    n1 = NODE1;
    n2 = NODE2;
  }

  void updateIndex(int newNode1, int newNode2){
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

    weight = w;
    if(9 < weight)
      weight = 0;
    println("Line weight set to: " + weight);
  }

  void highlight(){
    highlight = !highlight;
  }
}