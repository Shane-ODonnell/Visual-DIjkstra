
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
}
