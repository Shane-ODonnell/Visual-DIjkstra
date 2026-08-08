
class Map{
  int w,h;
  ArrayList<Node> nodes = new ArrayList<Node>();
  ArrayList<PVector> lines = new ArrayList<PVector>();
  int currL = -1;

  Map(){
    w = width;
    h = height;
  }
  
  void addNode(int x, int y){
    int n = getNode();

    if( n != -1){
      nodes.remove(n);
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
      if(currL != n){
        int node1 = currL;
        int node2 = n;
        currL = -1;
        //now I need to add an intruction somehow that there is a line here

        lines.add(new PVector(node1,node2));
        println("line added between nodes: " + node1 + " & " + node2);    
      }
    }
  
  }

  void show(){
    int count = nodes.size();
    for(int i = 0; i < count; i++){
      nodes.get(i).show();
    }
    int countL = lines.size();
    for(int i = 0; i < countL; i++){
      //draw a line between nodes
      PVector curr = lines.get(i);

      Node n1 = nodes.get(floor(curr.x));
      Node n2 = nodes.get(floor(curr.y));
      fill(0);
      stroke(50);
      line(n1.x, n1.y, n2.x, n2.y);
      
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

}
