
class Map{
  int w,h;
  ArrayList<Node> nodes = new ArrayList<Node>();
  ArrayList<Line> lines = new ArrayList<Line>();
  int currL = -1;

  Map(){
    w = width;
    h = height;
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
      nodes.add(new Node(x,y));
    }
  }
  
  void addLine(){
    int n = getNode();
    if( currL == -1 ){
      currL = n;          //store this node
      println("node1: " + currL);   
    }
    else{
      //now currL should connect to node n 
      if(currL != n && n != -1){
        int node1 = currL;
        int node2 = n;
        currL = -1;
        //now I need to add an intruction somehow that there is a line here

        lines.add(new Line(node1,node2));
        lines.get(lines.size()-1)
        .setNodes(nodes.get(node1).position(), nodes.get(node2).position());
        println("line added between nodes: " + node1 + " & " + node2);    
      }
    }
  }

  void weightLine(){
    int n = getLine();
    if( n != -1){
      println("Line clicked");
    }
    //TODO 
    //WHEN a line is clicked, monitor keystrokes for numbers
    //whatever value is typed in becomes the lines weighting 



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

}
