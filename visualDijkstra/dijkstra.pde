

class Dijkstra {
    
    ArrayList<Node> nodes;
    ArrayList<Line> lines;

    int startNode, endNode;
    int currentNode;

    int number_of_lines_coming_from_current_node;
    int inspectedRoutes;
    int current_line;

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


    int step1(int subStep){
        //highlight the lines connected to the current Node
        int nextStep = 2;
        if(subStep == 1){
            println("started substep: " + subStep);
            if( readyToStart() ) {
                //currentNode = startNode;
                number_of_lines_coming_from_current_node = highlightConnectedLines(true);
                inspectedRoutes = 0;
            }            
        }

        else if( subStep == 2){
            //remove highlights from all but one and check out the end of that line
            highlightConnectedLines(false);
            println("started substep: " + subStep);
            int found = 0;
            for(int i = 0; i < lines.size(); i++ ){
                Line curr = lines.get(i);
                if( curr.weight == 0 )
                    break; // unfinished line
                if(curr.node1 == currentNode || curr.node2 == currentNode){
                    //
                    found++;
                    if(found > inspectedRoutes){
                        lines.get(i).highlight();
                        current_line = i;
                        nodes.get(getDestination(current_line)).considering = true;
                        i = lines.size();
                    }
                }
            }
            nextStep++;
        }

        else if( subStep == 3) {
            //follow the currentLine and update the estimate
            
            println("started substep: " + subStep);
            
            Line curr = lines.get(current_line);

            //
            int destination  = getDestination(current_line);

            //now we have our destination and our currentNode
            
            int estimate = nodes.get(destination).shortestPathValue;
            
            int newEstimate = nodes.get(currentNode).shortestPathValue + curr.weight;

            if(newEstimate < estimate ) 
                estimate = newEstimate;
            nodes.get(destination).shortestPathValue = estimate;
        
            nodes.get(destination).considering = false;

            inspectedRoutes++;
            if(number_of_lines_coming_from_current_node > inspectedRoutes)
                nextStep = 2;
            else 
                nextStep++;
            //

        }


        println("finished substep: " + subStep);
        return nextStep;
    }
    
    //------------------------------------------------

    boolean readyToStart(){
        //  
        if( startNode != -1 && endNode != -1 ) 
            return true;
    
        return false;    
    }

    int highlightConnectedLines(boolean on){
        int count  = 0;
        for(int i = 0; i < lines.size(); i++ ){
            Line curr = lines.get(i);
            if( curr.weight == 0 )
                break; // unfinished line
            if(curr.node1 == currentNode || curr.node2 == currentNode){
                //
                lines.get(i).highlight = on;
                count++;
            }
        }

        return count;
    
    }
    
    int getDestination(int line){

        Line curr = lines.get(line);

        if (curr.node1 == currentNode ){
            return curr.node2;
        }
        else {
            return curr.node1;
        }
    
    }
}

//update estimates and choose next vertex