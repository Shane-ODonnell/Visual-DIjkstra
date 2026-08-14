
//visual Dijkstra
/*TODO 

  maybe remove the map.clear() Function
  stress test presetNodes function (there are bugged edgecases to find)
  add buttons to reset /clear canvas
  change the way estimates appear on nodes

  animate the shortest path reveal - done 

  disable mouseover color changes during animation
  create a way to reset the sim WITHOUT deleting the existing nodes and lines ( reset all estimates back to infinity)
  buttons for presets / more presets (maybe with lines connecting them)
  random nodes, lines and weights for random simulationss
  try making the canvas green like a classicn blackboard / chalk board and an overall chalk aesthetic
  change the way textsize and nodesize and line thickness are determined to scale with canvas
  function to delete lines when clicked (without braking how weights are currently added
  the default stroke doesnt match the usual storke (line thickness on buttons changes after first click) - fix
  add animation detail where the estimate under analyses is highlighted some way, such as changing font color
  add delays after certain steps to make more important steps stand out 
  shorten the delay that happens while the algo is choosing its next veretex

  STEP BUTTON  button that is control of moving through the algo. each step needs instruction not wait time

  ...add more algorythms?

//*/

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
    if( key == 'n'){
      map.presetNodes();
    }
  }
}
