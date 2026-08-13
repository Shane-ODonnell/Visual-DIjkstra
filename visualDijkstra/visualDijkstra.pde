
//visual Dijkstra
//TODO 

Map map;
boolean lineMode = false;
boolean addingWeight = false;
boolean settingStartNode = false;
boolean settingEndNode = false;
boolean started = false;
int currLine = -1;

int upperLimit;
int step = 1;

void setup(){
  size(500,500);
  background(200);
  map = new Map();
  textSize(30);

  setupUI();

}

void draw(){
  background(200);
  map.show();
  showUI();
  strokeWeight(8);
  line(0, upperLimit, width, upperLimit);
  strokeWeight(2);

  UIfunctions();

  if(started){
    // 
    if(step == 1){
      //
      map.step1();




    }
  
  
  
    //delay(2 * 1000);
  }

}

void mouseClicked() {

  clickUI();

  if(lineMode){
    map.addLine();
  }
  else if(settingStartNode){
    settingStartNode = !map.setStartNode();
    setStartButton.toggle = settingStartNode;
  }
  else if(settingEndNode){
    settingEndNode = !map.setEndNode();
    setEndButton.toggle = settingEndNode;
  }
  else if(started){
    //function to start pathfinding 
    println( "start button clicked" );
    started = false;
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
  
  typeUI();

  //if key is between 1 and 9 add it to the cell being edited
  if( 49 <= key && key <= 57 && addingWeight){
    map.lines.get(currLine).setWeight(key - 48); //convert char to int
    addingWeight = false;
    currLine = -1;
  }

}
