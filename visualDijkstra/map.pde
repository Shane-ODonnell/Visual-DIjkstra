
class Map{
  int w,h;
  int radius;
  ArrayList<Node> nodes = new ArrayList<Node>();
  ArrayList<Line> lines = new ArrayList<Line>();
  int currL = -1;

  Dijkstra algo;
  boolean running = false;
  int subStep = 1;

  int startingNode = -1;
  int endNode = -1;

  boolean adding_preset = false;

  Map(){
    w = width;
    h = height;
    Node temp = new Node(0,0);
    radius = temp.radius;
  }
  
  void addNode(int x, int y){
    int n = getNode();       // return -1 or the node currently under the mouse curser
    if( n != -1 && !adding_preset){
      nodes.remove(n);
      //remove any lines connected to this node
      for(int i = 0; i < lines.size(); i++){
        Line curr = lines.get(i);
        int node1 = curr.node1;
        int node2 = curr.node2;

        if(node1 == n || node2 == n){
          lines.remove(i);
          println("removed pair: " + node1 + ", " + node2);
          i--;
        }
      }

      for(int i = 0; i < lines.size(); i++){
        Line curr = lines.get(i);
        int node1 = curr.node1;
        int node2 = curr.node2;
        
        if( node1 > n)
          node1--;
        if(node2 > n){
          node2--;
        }

        lines.get(i).updateIndex(node1, node2);

      }
    }
    else{
      if( y + floor(radius/2) < upperLimit)
        nodes.add(new Node(x,y));
    }
  }
  
  void addLine(){
    int n = getNode();
    if( currL == -1 ){
      currL = n;          //store this node
      if(n != -1)
        nodes.get(n).considering = true;
      currL++;
      println("node1: " + currL);
      currL--;
    }
    else{
      //now currL should connect to node n 
      if(currL != n && n != -1){
        int node1 = currL;
        int node2 = n;
        currL = -1;
        //now I need to add an intruction somehow that there is a line here

        nodes.get(node1).considering = false;
        //check if this line already exists before adding it
        for(int i = 0; i < lines.size(); i++){
          Line curr = lines.get(i);

          int n1 = curr.node1;
          int n2 = curr.node2;

          if(node1 == n1 || node1 == n2){
            if(node2 == n1 || node2 == n2){
              node1++;node2++; // increase each by one only to make the following print statement more intuitive
              println("line already exists between nodes: " + node1 + " & " + node2);  
              return;
            }
          }


        }

        lines.add(new Line(node1,node2));
        lines.get(lines.size()-1)
        .setNodes(nodes.get(node1).position(), nodes.get(node2).position());
         // give the new line the Pvectors of it's nodes
         node1++;node2++; // increase each by one only to make the following print statement more intuitive
        println("line added between nodes: " + node1 + " & " + node2);    
      }
    }
  }

  void show(){

    int countL = lines.size();
    for(int i = 0; i < countL; i++){
      lines.get(i).show();
    }

    int count = nodes.size();
    for(int i = 0; i < count; i++){
      nodes.get(i).show(i);
    }
  }

  boolean mouseOver(){
    for(int i = 0; i < nodes.size(); i++){
      if(nodes.get(i).mouseOver())
        return true;
    }

    return false;
  }

  int getNode(){
    int count = nodes.size();
    for(int i = 0; i < count; i++){
      if(nodes.get(i).mouseOver())
        return i;
    }

    return -1;
  }

  int getLine(){
    int count = lines.size();
    for(int i = 0; i < count; i++){
      if(lines.get(i).mouseOver())
        return i;
    }

    return -1;
  }

  boolean setStartNode(){
    int curr = getNode();
    if(curr != -1){
      for(int i = 0; i < nodes.size(); i++){
        if(nodes.get(i).startingNode){
          nodes.get(i).startingNode = false;
          nodes.get(i).shortestPathValue = 10000; 
          //since the map stored the starting Node maybe I just target that one instead of searching
        }
      }
      if(nodes.get(curr).endNode)
        return false;
      nodes.get(curr).setAsStartNode();
      startingNode = curr;
      return true;
    }
    return false;
  }

  boolean setEndNode(){
    int curr = getNode();
    if(curr != -1){
      for(int i = 0; i < nodes.size(); i++){
        if(nodes.get(i).endNode)
          nodes.get(i).endNode = false;
      }
      if(nodes.get(curr).startingNode)
        return false;
      nodes.get(curr).setAsEndNode();
      endNode = curr;
      return true;
    }
    return false;
  }

  //---------------------------------------------------------------------------------

  void startDijkstra(){
    //
    algo = new Dijkstra(nodes, lines);
    if(algo.readyToStart())
      running = true;  
  }

  void run(){
    int temp = algo.run(subStep);
    subStep = temp;

    lines = algo.getLines();
    nodes = algo.getNodes();

    if( subStep != 1)
      delay(1000);
  }

  void clear(){
    //
    if(!started && !running){
      nodes = new ArrayList<Node>();
      lines = new ArrayList<Line>();
    }

  
  }

  void presetNodes(){
    //
    clear(); //delete all lines and nodes currently on the board
    int halfX = floor(width / 2);  
    int x = halfX / 2;
    int h = upperLimit;
    int halfY = floor(h/2);
    int y = halfY/2;

    adding_preset = true; // this tells the addNode function to skip the mouseposition check since we dont want to be removing nodes rn
    addNode( x, y);
    addNode( x + halfX, y);
    addNode( x, y + halfY);
    addNode( x + halfX, y + halfY);
    adding_preset = false;
  
  }

  void reset(){
    subStep = 1;
    int max = nodes.size();
    if( lines.size() > max){
      max = lines.size();
    } // if there are more lines than nodes, use that as max

    for(int i = 0; i < max; i++){ //using this 'max' operator and the if statements saves me using two seperate for loops
      //
      if( i < nodes.size() ) {         //dont work on the nodes array if we are out of its bounds
        
        nodes.get(i).shortestPathValue = 10000;
        nodes.get(i).shortest_path = -1;
        if(nodes.get(i).startingNode){
          nodes.get(i).setAsStartNode();
        }
        nodes.get(i).explored = false;
      }
      if( i < lines.size() )          //dont work on the lines array if we are out of its bounds
        lines.get(i).highlight = false;
    }
  }

  void testCase(){
    presetNodes(); // clear board and add 4 nodes in square pattern
    int node1 = 0; 
    int node2 = 1;

    int shortVal = 2; //this preset has a pretty straightforward normal path 
    int longVal = 8;  //and a path that is fewer lines but greater weight

    while(node2 < nodes.size()){
      
      lines.add(new Line(node1,node2));
      lines.get(lines.size()-1)
        .setNodes(nodes.get(node1).position(), nodes.get(node2).position());

      lines.get(lines.size()-1).setWeight(shortVal);
      node1++;
      node2++;
    } // this loop connects all the nodes in a zig zag pattern with weight 2

    node1 = 1; 
    node2 = 3;
    nodes.get(0).setAsStartNode();
    startingNode = 0;
    endNode = node2;
    nodes.get(node2).setAsEndNode();

    //set the starting and end nodes before adding decoy paths
    
    for(int i = 0; i != 2; i++){
      //
      lines.add(new Line(node1,node2));
      lines.get(lines.size()-1)
        .setNodes(nodes.get(node1).position(), nodes.get(node2).position());
      lines.get(lines.size()-1).setWeight(longVal);
      if(longVal != 9)
        longVal++;
      node1--;
      node2--;
    }

  }
}
