
//visual Dijkstra
//TODO maybe remove the map.clear() Function

Map map;
boolean lineMode = false;
boolean addingWeight = false;
boolean settingStartNode = false;
boolean settingEndNode = false;
boolean started = false;
int currLine = -1;

int upperLimit;

void setup(){
  size(500,500);
  background(25);
  
  map = new Map();
  textSize(30);

  lineMode = false;
  addingWeight = false;
  settingStartNode = false;
  settingEndNode = false;
  started = false;
  currLine = -1;

  setupUI();

}

void draw(){
  background(25);
  fill(200);
  rect(0, upperLimit, width , height - upperLimit);

  map.show();
  showUI();

  UIfunctions();

  if(started){
   map.run();
  }

}

void mouseClicked() {
  if( !started){
    clickUI();
    // dont get to use buttons while the sim is running
    if(lineMode){
      map.addLine();
    }
    else if(settingStartNode && !setStartButton.mouseOver()){
      settingStartNode = !map.setStartNode();
      setStartButton.toggle = settingStartNode;
      //turn off the button if we successfully set a start node
    }
    else if(settingEndNode  && !setEndButton.mouseOver()){
      settingEndNode = !map.setEndNode();
      setEndButton.toggle = settingEndNode;
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
}

void keyPressed(){
  if( !started){
    typeUI();

    //if key is between 1 and 9 add it to the cell being edited
    if( 49 <= key && key <= 57 && addingWeight){
      map.lines.get(currLine).setWeight(key - 48); //convert char to int
      addingWeight = false;
      currLine = -1;
    }


    if( key == 'c'){
      map.clear();
      setup();
    }
  }
}
