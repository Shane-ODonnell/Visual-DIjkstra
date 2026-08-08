
//visual Dijkstra

Map map;
boolean lineMode = false;

void setup(){
  size(500,500);
  background(200);
  map = new Map();
  textSize(30);
}

void draw(){
  background(200);
  map.show();
}

void mouseClicked() {
  if(lineMode){
    map.addLine();
  }
  else
    map.addNode(mouseX,mouseY);
}

void keyPressed(){
  if( key == 'l' || key == 'L' ){
    lineMode = ! lineMode;
    map.currL = -1;
    println("line mode: " + lineMode);
  }
}
