
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

    float slope = getSlope();
    int xMid = floor((n2.x + n1.x) / 2 );
    int yMid = floor((n2.y + n1.y) / 2 );
    int space = 30;
    float margin = 0.5;

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


    //textSize(128);
    text(getDist(), xMid, yMid); 

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

}