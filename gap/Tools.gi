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
        
        labels := phi_without_neutral_nodes[1];
        edges := phi_without_neutral_nodes[2];
        
        wire_vertices := rec( );
        node_vertices := rec( );
        
        # See https://github.com/Quantomatic/quantomatic/blob/stable/docs/json_formats.txt
        # for a rough overview of the qgraph format.
        
        for pos in [ 1 .. Length( labels ) ] do
            
            if labels[pos] = "X" then
                
                node_vertices.(pos - 1) := rec( annotation := rec( coord := [ 0, 0 ] ),
                                                data := rec( type := "X" ) );
                
            elif labels[pos] = "Z" then
                
                node_vertices.(pos - 1) := rec( annotation := rec( coord := [ 0, 0 ] ),
                                                data := rec( type := "Z" ) );
                
            elif labels[pos] = "H" then
                
                node_vertices.(pos - 1) := rec( annotation := rec( coord := [ 0, 0 ] ),
                                                data := rec( type := "hadamard" ) );
                
            elif labels[pos] = "input" then
                
                wire_vertices.(pos - 1) := rec( annotation := rec( coord := [ 0, 0 ],
                                                                   input := true,
                                                                   output := false ) );
                
            elif labels[pos] = "output" then
                
                wire_vertices.(pos - 1) := rec( annotation := rec( coord := [ 0, 0 ],
                                                                   input := false,
                                                                   output := true ) );
                
            elif labels[pos] = "input_output" then
                
                wire_vertices.(pos - 1) := rec( annotation := rec( coord := [ 0, 0 ],
                                                                   input := true,
                                                                   output := true ) );
                
            else
                
                Error( "Unknown label." );
                
            fi;
            
        od;
        
        undir_edges := rec( );
        
        edge_counter := 0;
        
        for edge in edges do
            
            edge_name := Concatenation( "e", String( edge_counter ) );
            
            undir_edges.(edge_name) := rec( src := String( edge[1] ), tgt := String( edge[2] ) );
            
            edge_counter := edge_counter + 1;
            
        od;
        
        qgraph := rec( wire_vertices := wire_vertices,
                       node_vertices := node_vertices,
                       undir_edges := undir_edges );
        
        qgraph := GapToJsonString( qgraph );
        
        FileString( Concatenation( filename, ".qgraph" ), qgraph );
        
    end );
    
fi;
