
class Node{
  int x,y;
  int radius = 35;
  
  color fill = color(60,110,200); //default color
  
  Node(int X, int Y){
    x = X;
    y = Y;
  }
  
  void show(int val){
    fill(fill);
    circle(x, y, radius);
    fill(255);
    textAlign(CENTER, CENTER);
    val++;
    text(val, x, y);
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

}

class Line{
  int node1, node2;
  PVector n1, n2;
  Line(int n1, int n2){
    node1 = n1;
    node2 = n2;
  }

  void show(){
    fill(0);
    stroke(50);
    line(n1.x, n1.y, n2.x, n2.y);
  }

  void getDist(){
    //TODO
  }
  
  void setNodes(PVector NODE1, PVector NODE2){
    n1 = NODE1;
    n2 = NODE2;
  }

  void updateIndex(int newNode1, int newNode2){
    node1 = newNode1;
    node2 = newNode2;
  }

}