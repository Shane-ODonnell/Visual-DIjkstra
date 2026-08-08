
class Map{
  int w,h;
  ArrayList<Node> nodes = new ArrayList<Node>();
  
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
  
  void show(){
    int count = nodes.size();
    for(int i = 0; i < count; i++){
      nodes.get(i).show();
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
    if(mouseOver()){
      int count = nodes.size();
      for(int i = 0; i < count; i++){
        if(nodes.get(i).mouseOver())
          return i;
      }
    }
    return -1;
  }

}
