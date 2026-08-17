

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

    int run(int subStep){
        //highlight the lines connected to the current Node
        nodes.get(map.startingNode).explored = true;
        int nextStep = 2;
        if(subStep == 1){
            println("current node = " + currentNode); 

            if( readyToStart() ) {
                //currentNode = startNode;
                number_of_lines_coming_from_current_node = highlightConnectedLines(true);
                inspectedRoutes = 0;
            }            
        }

        else if( subStep == 2 ){
            //remove highlights from all but one and check out the end of that line
            highlightConnectedLines(false);
            
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
        
            Line curr = lines.get(current_line);

            //
            int destination  = getDestination(current_line);

            //now we have our destination and our currentNode
            
            int estimate = nodes.get(destination).shortestPathValue;
            
            int newEstimate = nodes.get(currentNode).shortestPathValue + curr.weight;

            if(newEstimate < estimate ){ 
                estimate = newEstimate;
                nodes.get(destination).shortest_path = current_line;
            }

            nodes.get(destination).shortestPathValue = estimate;
        
            nodes.get(destination).considering = false;

            inspectedRoutes++;
            if(number_of_lines_coming_from_current_node >= inspectedRoutes)
                nextStep = 2;
            else 
                nextStep = 4;
            //

        }

        else if (subStep == 4){
            //Ok so I can update estimates for the nodes connected to current node

            //now I need to choose the next vertex 
            nodes.get(currentNode).considering = false;
            nodes.get(currentNode).explored = true;

            int min = 1000;
            int nextNode = startNode;

            boolean goToStep5 = true;

            for(int i = 0; i < nodes.size(); i++){
                if(nodes.get(i).shortestPathValue < min && i != startNode){
                    //
                    if(nodes.get(i).explored == false){
                        min = nodes.get(i).shortestPathValue;
                        nextNode = i; 
                        nextStep = 1;    
                        goToStep5 = false;   
                    }
                    
                
                }
            
            }

            if(goToStep5)
                nextStep = 5;
            //

            currentNode = nextNode;

            nodes.get(currentNode).considering = true;                      
        
        }

        else if (subStep == 5){
            //end checks
            nodes.get(map.startingNode).explored = true;
            boolean done = true;
            for(int i = 0; i < nodes.size(); i++){
                //
                if(nodes.get(i).explored == false){
                    done = false;
                    currentNode = i;
                    println("Step 5 is sending search to node: " + currentNode);
                }

            }
        
            //started = !done;
            if(done){
                currentNode = map.endNode;
                nodes.get(currentNode).considering = true;
                int path = nodes.get(currentNode).shortest_path; //shortest path to this node
                lines.get(path).highlight = true;
                nextStep = 6;         
                currentNode = map.endNode;
                delay(500);
            
            }
        }

        else if ( subStep == 6){
            //animate the shortest path reveal;
            int path  = nodes.get(currentNode).shortest_path; //shortest path to this node

            currentNode = getDestination(path);
            if(currentNode != map.startingNode){
                path = nodes.get(currentNode).shortest_path; //shortest path to this node
                lines.get(path).highlight = true;
                nodes.get(currentNode).considering = true;
                nextStep = 6;
            }
            else{
                started = false;
                oneButton('n');
                map.running = false;
            }
            delay(10);
            

        }

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