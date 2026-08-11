
//visual Dijkstra
//TODO 

Map map;
boolean lineMode = false;
boolean addingWeight = false;
int currLine = -1;

Button addLineButton;
Button setStartButton;
Button setEndButton;

void setup(){
  size(500,500);
  background(200);
  map = new Map();
  textSize(30);

  int buttonW = floor(width / 10);

  addLineButton = new Button( 0, height - buttonW, buttonW );

}

void draw(){
  background(200);
  map.show();
}

void mouseClicked() {
  if(lineMode){
    map.addLine();
  }
  else if(map.getLine() != -1){
    addingWeight = true;
    currLine = map.getLine();
  }
  else{
    map.addNode(mouseX,mouseY);
    addingWeight = false;
    currLine = -1;
  }
}

void keyPressed(){
  if( key == 'l' || key == 'L' ){
    lineMode = ! lineMode;
    map.currL = -1;
    println("line mode: " + lineMode);
  }

  //if key is between 1 and 9 add it to the cell being edited
  if( 49 <= key && key <= 57 && addingWeight){
    map.lines.get(currLine).setWeight(key - 48); //convert char to int
    addingWeight = false;
    currLine = -1;
  }

}
