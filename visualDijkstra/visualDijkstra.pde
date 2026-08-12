
//visual Dijkstra
//TODO 

Map map;
boolean lineMode = false;
boolean addingWeight = false;
boolean settingStartNode = false;
boolean settingEndNode = false;
boolean started = false;
int currLine = -1;

Button addLineButton;
Button setStartButton;
Button setEndButton;
Button startButton;

int upperLimit;

void setup(){
  size(500,500);
  background(200);
  map = new Map();
  textSize(30);

  int buttonW = floor(width / 7);
  int bufferSpace = floor(buttonW/3);
  upperLimit = height - (2*bufferSpace + buttonW);

  addLineButton = new Button( bufferSpace, height - bufferSpace , buttonW, "Lines" );
  setStartButton = new Button( 2*bufferSpace + buttonW, height - bufferSpace , buttonW, "Set Start" );
  setEndButton = new Button( 3*bufferSpace + 2*buttonW, height - bufferSpace , buttonW, "Set End" );
  startButton = new Button( 4*bufferSpace + 3*buttonW, height - bufferSpace , buttonW, "Start" );

}

void draw(){
  background(200);
  map.show();
  addLineButton.show();
  setStartButton.show();
  setEndButton.show();
  startButton.show();

  strokeWeight(8);
  line(0, upperLimit, width, upperLimit);
  strokeWeight(2);

  startButtonFunction();
  addLineButtonFunction();
  setStartButtonFunction();
  setEndButtonFunction();
}

void mouseClicked() {
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
    delay(200);
    startButton.toggle = false;
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

  addLineButton.click();
  setStartButton.click();
  setEndButton.click();
  startButton.click();
}

void keyPressed(){
  if( key == 'l' || key == 'L' ){
    addLineButton.toggle();
    println("line mode: " + lineMode);
  }
  if( key == 's' || key == 'S' ){
    setStartButton.toggle();

  }
  if( key == 'e' || key == 'E' ){
    setEndButton.toggle();
   
  }

  //if key is between 1 and 9 add it to the cell being edited
  if( 49 <= key && key <= 57 && addingWeight){
    map.lines.get(currLine).setWeight(key - 48); //convert char to int
    addingWeight = false;
    currLine = -1;
  }

}

void addLineButtonFunction(){
  if(addLineButton.toggled()){
    lineMode = addLineButton.toggle;
    oneButton('l');
  }
}// function to run when addLine Button is clicked

void setStartButtonFunction(){
  if(setStartButton.toggled()){
    settingStartNode = setStartButton.toggle;
    oneButton('s');
  }
}// function to run when setStartButton is clicked

void setEndButtonFunction(){
  if(setEndButton.toggled()){
    settingEndNode = setEndButton.toggle;
    oneButton('e');
  }
}// function to run when addLine Button is clicked

void startButtonFunction(){
  if(startButton.toggled()){
    started = startButton.toggle;
    oneButton('g');
  }
}

void oneButton(char choice){
  if(map.currL != -1){
    map.nodes.get(map.currL).considering = false;
    map.currL = -1;
  }


  if(choice != 'l'){
    addLineButton.toggle = false;
    addLineButton.prevToggle = false;
    lineMode = false;
  }
  if(choice != 's'){
    setStartButton.toggle = false;
    setStartButton.prevToggle = false;
    settingStartNode = false;
  }
  if(choice != 'e'){
    setEndButton.toggle = false;
    setEndButton.prevToggle = false;
    settingEndNode = false;
  }

  if(choice != 'g'){
    startButton.toggle = false;
    startButton.prevToggle = false;
    started = false;
  }

  println("one button: " + choice);
}