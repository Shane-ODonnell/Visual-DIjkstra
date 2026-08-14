
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

  Map(){
    w = width;
    h = height;
    Node temp = new Node(0,0);
    radius = temp.radius;
  }
  
  void addNode(int x, int y){
    int n = getNode();
    if( n != -1){
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
    int count = nodes.size();
    for(int i = 0; i < count; i++){
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
  
    delay(1000);
  }

  void clear(){
    //
    if(!started && !running){
      nodes = new ArrayList<Node>();
      lines = new ArrayList<Line>();
    }

  
  }

}

