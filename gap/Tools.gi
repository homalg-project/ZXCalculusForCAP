# SPDX-License-Identifier: GPL-2.0-or-later
# ZXCalculusForCAP: The category of ZX-diagrams
#
# Implementations
#

if IsPackageMarkedForLoading( "json", "2.1.1" ) then

  InstallGlobalFunction( ExportAsQGraph,
    
    function ( phi, filename )
        local phi_without_neutral_nodes, labels, edges, wire_vertices,
            node_vertices, pos, undir_edges, edge_counter, edge,
            edge_name, qgraph, file;
        
        phi_without_neutral_nodes := ZX_RemoveNeutralNodes( phi );
        
        labels := ShallowCopy( phi_without_neutral_nodes[1] );
        edges := ShallowCopy( phi_without_neutral_nodes[2] );
        
        # nodes which are simultaneously inputs and outputs are not supported by PyZX
        # split input_output nodes into an input and an output node connected by an edge
        for pos in [ 1 .. Length( labels ) ] do
            
            if labels[pos] = "input_output" then
                
                labels[pos] := "input";
                Add( labels, "output" );
                Add( edges, [ pos - 1, Length( labels ) - 1 ] );
                
            fi;
            
        od;
        
        wire_vertices := rec( );
        node_vertices := rec( );
        
        # See https://github.com/Quantomatic/quantomatic/blob/stable/docs/json_formats.txt
        # for a rough overview of the qgraph format.
        
        for pos in [ 1 .. Length( labels ) ] do
            
            if labels[pos] = "Z" then
                
                node_vertices.(pos - 1) := rec( annotation := rec( coord := [ 1, - pos ] ),
                                                data := rec( type := "Z" ) );
                
            elif labels[pos] = "X" then
                
                node_vertices.(pos - 1) := rec( annotation := rec( coord := [ 1, - pos ] ),
                                                data := rec( type := "X" ) );
                
            elif labels[pos] = "H" then
                
                node_vertices.(pos - 1) := rec( annotation := rec( coord := [ 1, - pos ] ),
                                                data := rec( type := "hadamard",
                                                             is_edge := false,
                                                             value := "\\pi" ) );
                
            elif labels[pos] = "input" then
                
                wire_vertices.(pos - 1) := rec( annotation := rec( boundary := true,
                                                                   coord := [ 0, - pos ],
                                                                   input := true,
                                                                   output := false ) );
                
            elif labels[pos] = "output" then
                
                wire_vertices.(pos - 1) := rec( annotation := rec( boundary := true,
                                                                   coord := [ 2, - pos ],
                                                                   input := false,
                                                                   output := true ) );
                
            else
                
                Error( "Unknown label." );
                
            fi;
            
        od;
        
        undir_edges := rec( );
        
        for edge_counter in [ 1 .. Length( edges ) ] do
            
            edge := edges[edge_counter];
            
            edge_name := Concatenation( "e", String( edge_counter - 1 ) );
            
            undir_edges.(edge_name) := rec( src := String( edge[1] ), tgt := String( edge[2] ) );
            
        od;
        
        qgraph := rec( wire_vertices := wire_vertices,
                       node_vertices := node_vertices,
                       undir_edges := undir_edges );
        
        qgraph := GapToJsonString( qgraph );
        
        FileString( Concatenation( filename, ".qgraph" ), qgraph );
        
    end );
    
fi;
