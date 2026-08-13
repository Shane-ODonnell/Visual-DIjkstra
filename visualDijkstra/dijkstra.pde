

class Dijkstra {
    
    ArrayList<Node> nodes;
    ArrayList<Line> lines;

    int startNode, endNode;
    int currentNode;

    Dijkstra(ArrayList<Node> N, ArrayList<Line> L ){
        nodes = N;
        lines = L;

        startNode = getStartNode();
        endNode = getEndNode();
        currentNode = startNode;

    } //constructor

    //------------------------------------------------

    ArrayList<Node> getNodes(){
        return nodes;
    }

    ArrayList<Line> getLines(){
        return lines;
    }

    //------------------------------------------------

    int getStartNode(){
        // retrun the node marked as starting point if one exists
        for(int i = 0; i < nodes.size() ; i++ ){
            if(nodes.get(i).startingNode)
                return i;   
        }
        return -1;
    }

    int getEndNode(){
        //
        for(int i = 0; i < nodes.size() ; i++ ){
            if(nodes.get(i).endNode)
                return i;   
        }
        return -1;
    }


    //------------------------------------------------

    void run(){
        //
        if( readyToStart() ) {
            //ready to start
            //currentNode = startNode;
            for(int i = 0; i < lines.size(); i++ ){
                Line curr = lines.get(i);
                if( curr.weight == 0 )
                    break; // unfinished line; // unfinished line
                if(curr.node1 == currentNode || curr.node2 == currentNode){
                    //
                    int destination;
                    if (curr.node1 == currentNode ){
                        destination = curr.node2;
                    }
                    else {
                        destination = curr.node1;
                    }
                
                    int estimate = nodes.get(destination).shortestPathValue;
                    
                    int newEstimate = nodes.get(currentNode).shortestPathValue + curr.weight;

                    if(newEstimate < estimate ) 
                        estimate = newEstimate;
                    nodes.get(destination).shortestPathValue = estimate;
                
                }
            
            
            
            }


        }
        else 
            println("not ready to start");
        //
    }
    
    
    //------------------------------------------------


    void step1(){
        //highlight the lines connected to the current Node

        if( readyToStart() ) {
            //currentNode = startNode;
            for(int i = 0; i < lines.size(); i++ ){
                Line curr = lines.get(i);
                if( curr.weight == 0 )
                    break; // unfinished line
                if(curr.node1 == currentNode || curr.node2 == currentNode){
                    //
                    lines.get(i).highlight();
                }
            }
        }   
    
    }

    
    //------------------------------------------------

    boolean readyToStart(){
        //  
        if( startNode != -1 && endNode != -1 ) 
            return true;
    
        return false;    
    }

}

//update estimates and choose next vertex