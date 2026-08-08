
class Node{
  int x,y;
  int radius = 20;
  
  String name = "";
  boolean named = false;
  color fill = color(60,110,200); //default color
  

  Node(int X, int Y){
    x = X;
    y = Y;
  }
  
  void addName(String n){
    name = n;
    named = true;
  }
  
  void setColor(color c){
    fill = c;
  }
  
  void show(){
    fill(fill);
    circle(x, y, radius);
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
