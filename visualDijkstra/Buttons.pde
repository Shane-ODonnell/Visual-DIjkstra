
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

    fill(colour);
    if(mouseOver()){
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