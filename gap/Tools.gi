# SPDX-License-Identifier: GPL-2.0-or-later
# ZXCalculusForCAP: The category of ZX-diagrams
#
# Implementations
#

if IsPackageMarkedForLoading( "json", "2.1.1" ) then

  InstallGlobalFunction( ExportAsQGraph,
    
    function ( phi, filename )
      local phi_without_neutral_nodes, labels, edges, wire_vertices, node_vertices, vertex_names, padding_length, get_vertex_name, vertex_name, undir_edges, edge, edge_name, src_vertex_name, tgt_vertex_name, qgraph, pos, edge_counter;
        
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
        
        vertex_names := [ ];
        
        # we want to pad all numbers with zeros on the left so the order does not change when ordering them as strings
        # this helps to work around https://github.com/Quantomatic/pyzx/issues/168
        padding_length := Int( Log10( Float( Length( labels ) ) ) ) + 1;
        
        get_vertex_name := function ( prefix, record )
          local id, id_string, vertex_name;
            
            id := Length( RecNames( record ) );
            
            id_string := String( id, padding_length );
            
            vertex_name := Concatenation( prefix, ReplacedString( id_string, " ", "0" ) );
            
            Assert( 0, not IsBound( record.(vertex_name) ) );
            
            return vertex_name;
            
        end;
        
        # See https://github.com/Quantomatic/quantomatic/blob/stable/docs/json_formats.txt
        # for a rough overview of the qgraph format.
        
        for pos in [ 1 .. Length( labels ) ] do
            
            if labels[pos] = "Z" then
                
                vertex_name := get_vertex_name( "v", node_vertices );
                
                node_vertices.(vertex_name) := rec(
                    annotation := rec(
                        coord := [ 1, - pos ],
                    ),
                    data := rec(
                        type := "Z",
                    )
                );
                
            elif labels[pos] = "X" then
                
                vertex_name := get_vertex_name( "v", node_vertices );
                
                node_vertices.(vertex_name) := rec(
                    annotation := rec(
                        coord := [ 1, - pos ],
                    ),
                    data := rec(
                        type := "X",
                    )
                );
                
                
            elif labels[pos] = "H" then
                
                vertex_name := get_vertex_name( "v", node_vertices );
                
                node_vertices.(vertex_name) := rec(
                    annotation := rec(
                        coord := [ 1, - pos ],
                    ),
                    data := rec(
                        type := "hadamard",
                        # always use Hadamard edges to work around https://github.com/Quantomatic/pyzx/issues/161
                        is_edge := "true",
                        value := "\\pi",
                    ),
                );
                
            elif labels[pos] = "input" then
                
                vertex_name := get_vertex_name( "b", wire_vertices );
                
                wire_vertices.(vertex_name) := rec(
                    annotation := rec(
                        boundary := true,
                        coord := [ 0, - pos ],
                        input := true,
                        output := false,
                    ),
                );
                
            elif labels[pos] = "output" then
                
                vertex_name := get_vertex_name( "b", wire_vertices );
                
                wire_vertices.(vertex_name) := rec(
                    annotation := rec(
                        boundary := true,
                        coord := [ 2, - pos ],
                        input := false,
                        output := true,
                    ),
                );
                
            else
                
                Error( "Unknown label." );
                
            fi;
            
            Assert( 0, Length( vertex_names ) = pos - 1 );
            Add( vertex_names, vertex_name );
            
        od;
        
        Assert( 0, Length( vertex_names ) = Length( labels ) );
        
        undir_edges := rec( );
        
        for edge_counter in [ 1 .. Length( edges ) ] do
            
            edge := edges[edge_counter];
            
            edge_name := Concatenation( "e", String( edge_counter - 1 ) );
            
            src_vertex_name := vertex_names[edge[1] + 1];
            tgt_vertex_name := vertex_names[edge[2] + 1];
            
            undir_edges.(edge_name) := rec( src := src_vertex_name, tgt := tgt_vertex_name );
            
        od;
        
        qgraph := rec( wire_vertices := wire_vertices,
                       node_vertices := node_vertices,
                       undir_edges := undir_edges );
        
        qgraph := GapToJsonString( qgraph );
        
        FileString( Concatenation( filename, ".qgraph" ), qgraph );
        
    end );
    
fi;
