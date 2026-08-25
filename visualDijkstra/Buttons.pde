
class Button {
  int x, y, w;

  //default color
  color colour = color(150, 100, 255);
  color togglecolor = color(0,50,200);
  color txtColor = color(255);

  String name = new String(" ");
  int txtSize;

  boolean toggle = false;
  boolean prevToggle = false;

  //-------------------------------------------------------------------------------

  Button(int X, int Y, int W) {
    x = X;
    y = Y - W;
    w = W;
    txtSize = floor(w/2);
  }

  Button(int X, int Y, int W, String title) {
    x = X;
    y = Y - W;
    w = W;
    setText(title);
    txtSize = floor(w/4);
  }

  //-------------------------------------------------------------------------------

  void show() {
    strokeWeight(1);  // Default
    fill(colour);
    if(mouseOver() && !started){
      fill(color(170,100,255));   
    }
    stroke(0);
    
    if(toggle){
      fill(togglecolor);
    }

    rect(x, y, w, w);
    fill(txtColor);
    textSize(txtSize);
    textAlign(CENTER, CENTER);
    text(name, x + floor(w/2), y + floor(w/2));
    textSize(defaultTextSize);
  }

  boolean mouseOver() {
    if (x <= mouseX && mouseX <= x + w) {
      if (y <= mouseY && mouseY <= y + w) {
        return true;
      }
    }
    return false;
  }

  void toggle(){
    toggle = !toggle;
  }//needs to be a seperate function from click() to be used publicly

  void click(){
    if(mouseOver())
      toggle();
  }
  
  boolean toggled(){
    //for buttons which stay on until turned off
    // and we need to detect when the on/off state changes
    if(toggle != prevToggle){
      prevToggle = toggle;
      return true;
    }
    
    return false;
  }

  boolean ready(){
    if(toggle){
      toggle();
      return !toggle;
    }
    return false;
  }

  //-------------------------------------------------------------------------------
  
  void setTextSize(int temp) {
    txtSize = temp;
  }

  void setText(String title) {
    name = title;
  }

}

//toggle buttons
Button addLineButton;
Button setStartButton;
Button setEndButton;
Button startButton;

//instant buttons
Button resetButton, clearButton, presetButton, randomButton;

void setupUI(){
  
  int buttonW = floor(width / 10);
  int bufferSpace = floor(buttonW/3);
  upperLimit = height - (2*bufferSpace + buttonW);
  int buttonY = height - bufferSpace;

  addLineButton = new Button( bufferSpace, buttonY , buttonW, "Lines" );
  setStartButton = new Button( 2*bufferSpace + buttonW, buttonY , buttonW, "Set Start" );
  setEndButton = new Button( 3*bufferSpace + 2 *buttonW, buttonY , buttonW, "Set End" );
  startButton = new Button( 4*bufferSpace + 3 *buttonW, buttonY , buttonW, "Start" );

  resetButton = new Button( 5 * bufferSpace + 4 * buttonW, buttonY , buttonW, "Reset" );
  clearButton = new Button( 6 * bufferSpace + 5 * buttonW, buttonY , buttonW, "Clear" );
  presetButton = new Button( 7 * bufferSpace + 6 * buttonW, buttonY , buttonW, ": :" );
  presetButton.setTextSize(defaultTextSize + 20);
  //randomButton = new Button( 8 * bufferSpace + 7 * buttonW, buttonY , buttonW, "Reset" );
}

void showUI(){

  addLineButton.show();
  setStartButton.show();
  setEndButton.show();
  startButton.show();

  resetButton.show();
  clearButton.show();
  presetButton.show();
  //randomButton.show();

}

void UIfunctions(){

  startButtonFunction();
  addLineButtonFunction();
  setStartButtonFunction();
  setEndButtonFunction();

}

void clickUI(){

  startButton.click();
  addLineButton.click();
  setStartButton.click();
  setEndButton.click();

  if(resetButton.mouseOver()){
    map.reset();
  }

  if(clearButton.mouseOver()){
    map.clear();
  }

  if(presetButton.mouseOver()){
    map.presetNodes();
  }  

}

void typeUI(){
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
    map.startDijkstra();
    if(map.running)
      started = true;
    else 
      oneButton('n');
  }
}

void oneButton(char choice){

  if(map.currL != -1){
    map.nodes.get(map.currL).considering = false;
    map.currL = -1;
  }

  //----------------------------------------------

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

  //could store the currently active button globally so that I can turn that one off specifically 
  //instead of turning off each button i am not using
}