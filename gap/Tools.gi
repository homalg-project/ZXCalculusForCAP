# SPDX-License-Identifier: GPL-2.0-or-later
# ZXCalculusForCAP: The category of ZX-diagrams
#
# Implementations
#

if IsPackageMarkedForLoading( "json", "2.1.1" ) then

  InstallGlobalFunction( ExportAsQGraph,
    
    function ( phi, filename )
      local tuple, labels, input_positions, output_positions, edges, input_positions_indices, output_positions_indices, wire_vertices, node_vertices, vertex_names, padding_length, get_vertex_name, vertex_name, is_input, is_output, input_position, output_position, undir_edges, edge, edge_name, src_vertex_name, tgt_vertex_name, qgraph, pos, edge_counter;
        
        tuple := ZX_RemovedInnerNeutralNodes( MorphismDatum( phi ) );
        
        labels := ShallowCopy( tuple[1] );
        input_positions := ShallowCopy( tuple[2] );
        output_positions := ShallowCopy( tuple[3] );
        edges := ShallowCopy( tuple[4] );
        
        # nodes which are simultaneously inputs and outputs or multiple inputs or outputs are not supported by PyZX
        # split such nodes into multiple input or outputs nodes connected by an edge
        for pos in [ 1 .. Length( labels ) ] do
            
            # find input and output indices corresponding to this node
            input_positions_indices := Positions( input_positions, pos - 1 );
            output_positions_indices := Positions( output_positions, pos - 1 );
            
            if Length( input_positions_indices ) = 0 and Length( output_positions_indices ) = 0 then
                
                # not an input or output node
                
                # inner neutral nodes have been removed above
                Assert( 0, labels[pos] <> "neutral" );
                
                continue;
                
            fi;
            
            Assert( 0, labels[pos] = "neutral" );
            
            if Length( input_positions_indices ) = 1 and Length( output_positions_indices ) = 0 then
                
                # normal input node
                continue;
                
            elif Length( input_positions_indices ) = 0 and Length( output_positions_indices ) = 1 then
                
                # normal output node
                continue;
                
            elif Length( input_positions_indices ) = 1 and Length( output_positions_indices ) = 1 then
                
                # simultaneously an input and an output:
                # add a new neutral node for the output and an edge between input and output
                Add( labels, "neutral" );
                output_positions[output_positions_indices[1]] := Length( labels ) - 1;
                Add( edges, [ pos - 1, Length( labels ) - 1 ] );
                
            elif Length( input_positions_indices ) = 2 and Length( output_positions_indices ) = 0 then
                
                # simultaneously two inputs:
                # add a new neutral node for a separate input and a dummy Z node to connect the two inputs
                Add( labels, "neutral" );
                input_positions[input_positions_indices[2]] := Length( labels ) - 1;
                Add( labels, "Z" );
                Add( edges, [ input_positions[input_positions_indices[1]], Length( labels ) - 1 ] );
                Add( edges, [ input_positions[input_positions_indices[2]], Length( labels ) - 1 ] );
                
            elif Length( input_positions_indices ) = 0 and Length( output_positions_indices ) = 2 then
                
                # simultaneously two outputs:
                # add a new neutral node for a separate output and a dummy Z node to connect the two outputs
                Add( labels, "neutral" );
                output_positions[output_positions_indices[2]] := Length( labels ) - 1;
                Add( labels, "Z" );
                Add( edges, [ output_positions[output_positions_indices[1]], Length( labels ) - 1 ] );
                Add( edges, [ output_positions[output_positions_indices[2]], Length( labels ) - 1 ] );
                
            else
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "this case should not appear in a well-defined ZX-diagram" );
                
            fi;
            
        od;
        
        edges := Set( edges );
        
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
            
            if labels[pos][1] = 'Z' then
                
                vertex_name := get_vertex_name( "v", node_vertices );
                
                node_vertices.(vertex_name) := rec(
                    annotation := rec(
                        coord := [ 1, - pos ],
                    ),
                    data := rec(
                        type := "Z",
                    )
                );
                
                if Length( labels[pos] ) > 1 then
                    
                    node_vertices.(vertex_name).data.value := labels[pos]{[ 2 .. Length( labels[pos] ) ]};
                    
                fi;
                
            elif labels[pos][1] = 'X' then
                
                vertex_name := get_vertex_name( "v", node_vertices );
                
                node_vertices.(vertex_name) := rec(
                    annotation := rec(
                        coord := [ 1, - pos ],
                    ),
                    data := rec(
                        type := "X",
                    )
                );
                
                if Length( labels[pos] ) > 1 then
                    
                    node_vertices.(vertex_name).data.value := labels[pos]{[ 2 .. Length( labels[pos] ) ]};
                    
                fi;
                
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
                
            elif labels[pos] = "neutral" then
                
                vertex_name := get_vertex_name( "b", wire_vertices );
                
                is_input := (pos - 1) in input_positions;
                is_output := (pos - 1) in output_positions;
                
                if is_input and is_output then
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "found neutral node which is simultaneously an input and an output, this is not supported by PyZX" );
                    
                elif is_input then
                    
                    input_position := SafeUniquePosition( input_positions, pos - 1 ) - 1;
                    
                    wire_vertices.(vertex_name) := rec(
                        annotation := rec(
                            boundary := true,
                            coord := [ 0, - input_position ],
                            input := input_position,
                        ),
                    );
                    
                elif is_output then
                    
                    output_position := SafeUniquePosition( output_positions, pos - 1 ) - 1;
                    
                    wire_vertices.(vertex_name) := rec(
                        annotation := rec(
                            boundary := true,
                            coord := [ 2, - output_position ],
                            output := output_position,
                        ),
                    );
                    
                else
                    
                    # COVERAGE_IGNORE_NEXT_LINE
                    Error( "found inner neutral node, this is not supported by PyZX" );
                    
                fi;
                
            else
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "unknown label ", labels[pos] );
                
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
    
    InstallGlobalFunction( ImportFromQGraph,
      
      function ( cat, filename )
        local labels, edges, qgraph, wire_vertices, node_vertices, undir_edges, vertex_names, input_positions, output_positions, edge, src_vertex, tgt_vertex, annotation, data, full_type, io_positions, src_index, tgt_index, via_index, source, range, mor, name;
        
        labels := [ ];
        edges := [ ];
        
        qgraph := StringFile( Concatenation( filename, ".qgraph" ) );
        
        Assert( 0, qgraph <> fail );
        
        qgraph := JsonStringToGap( qgraph );
        
        wire_vertices := qgraph.wire_vertices;
        node_vertices := qgraph.node_vertices;
        undir_edges := qgraph.undir_edges;
        
        vertex_names := [ ];
        input_positions := [ ];
        output_positions := [ ];
        
        # identify inputs or outputs connected to other inputs or outputs
        for name in SortedList( RecNames( undir_edges ) ) do
            
            edge := undir_edges.(name);
            
            if edge.src = edge.tgt then
                
                Error( "loops are currently not supported" );
                
            fi;
            
            if IsBound( wire_vertices.(edge.src) ) and IsBound( wire_vertices.(edge.tgt) ) then
                
                src_vertex := wire_vertices.(edge.src);
                tgt_vertex := wire_vertices.(edge.tgt);
                
                if IsBound( src_vertex.annotation.input ) and IsBound( tgt_vertex.annotation.input ) then
                    
                    Assert( 0, not IsBound( src_vertex.annotation.output ) );
                    Assert( 0, not IsBound( tgt_vertex.annotation.output ) );
                    
                    src_vertex.annotation.input2 := tgt_vertex.annotation.input;
                    
                elif IsBound( src_vertex.annotation.input ) and IsBound( tgt_vertex.annotation.output ) then
                    
                    Assert( 0, not IsBound( src_vertex.annotation.output ) );
                    Assert( 0, not IsBound( tgt_vertex.annotation.input ) );
                    
                    src_vertex.annotation.output := tgt_vertex.annotation.output;
                    
                elif IsBound( src_vertex.annotation.output ) and IsBound( tgt_vertex.annotation.input ) then
                    
                    Assert( 0, not IsBound( src_vertex.annotation.input ) );
                    Assert( 0, not IsBound( tgt_vertex.annotation.output ) );
                    
                    src_vertex.annotation.input := tgt_vertex.annotation.input;
                    
                elif IsBound( src_vertex.annotation.output ) and IsBound( tgt_vertex.annotation.output ) then
                    
                    Assert( 0, not IsBound( src_vertex.annotation.input ) );
                    Assert( 0, not IsBound( tgt_vertex.annotation.input ) );
                    
                    src_vertex.annotation.output2 := tgt_vertex.annotation.output;
                    
                else
                    
                    Error( "this should never happen" );
                    
                fi;
                
                Unbind( wire_vertices.(edge.tgt) );
                
                Unbind( undir_edges.(name) );
                
            fi;
            
        od;
        
        for name in SortedList( RecNames( wire_vertices ) ) do
            
            Add( vertex_names, name );
            
            annotation := wire_vertices.(name).annotation;
            
            Add( labels, "neutral" );
            
            Assert( 0, Number( [ "input", "input2", "output", "output2" ], name -> IsBound( annotation.(name) ) ) <= 2 );
            
            if IsBound( annotation.input ) then
                
                input_positions[annotation.input + 1] := Length( labels ) - 1;
                
            fi;
            
            if IsBound( annotation.input2 ) then
                
                Assert( 0, IsBound( annotation.input ) );
                
                input_positions[annotation.input2 + 1] := Length( labels ) - 1;
                
            fi;
            
            if IsBound( annotation.output ) then
                
                output_positions[annotation.output + 1] := Length( labels ) - 1;
                
            fi;
            
            if IsBound( annotation.output2 ) then
                
                Assert( 0, IsBound( annotation.output ) );
                
                output_positions[annotation.output2 + 1] := Length( labels ) - 1;
                
            fi;
            
        od;
        
        Assert( 0, IsDenseList( input_positions ) );
        Assert( 0, IsDenseList( output_positions ) );
        
        for name in SortedList( RecNames( node_vertices ) ) do
            
            Add( vertex_names, name );
            
            data := node_vertices.(name).data;
            
            if data.type = "Z" then
                
                if IsBound( data.value ) then
                    
                    full_type := Concatenation( "Z", data.value );
                    
                else
                    
                    full_type := "Z";
                    
                fi;
                
                Add( labels, full_type );
                
            elif data.type = "X" then
                
                if IsBound( data.value ) then
                    
                    full_type := Concatenation( "X", data.value );
                    
                else
                    
                    full_type := "X";
                    
                fi;
                
                Add( labels, full_type );
                
            elif data.type = "hadamard" then
                
                Add( labels, "H" );
                
            else
                
                Error( "node vertex has unkown type ", data.type );
                
            fi;
            
        od;
        
        Assert( 0, Length( labels ) = Length( vertex_names ) );
        
        io_positions := Concatenation( input_positions, output_positions );
        
        for name in SortedList( RecNames( undir_edges ) ) do
            
            edge := undir_edges.(name);
            
            src_index := SafeUniquePosition( vertex_names, edge.src ) - 1;
            tgt_index := SafeUniquePosition( vertex_names, edge.tgt ) - 1;
            
            if src_index in io_positions and tgt_index in io_positions then
                
                Error( "this case should have been handled above" );
                
            elif src_index in io_positions then
                
                Add( edges, [ src_index, tgt_index ] );
                
            elif tgt_index in io_positions then
                
                Add( edges, [ tgt_index, src_index ] );
                
            else
                
                Add( labels, "neutral" );
                
                via_index := Length( labels ) - 1;
                
                Add( edges, [ via_index, src_index ] );
                Add( edges, [ via_index, tgt_index ] );
                
            fi;
            
        od;
        
        source := ObjectConstructor( cat, Length( input_positions ) );
        range := ObjectConstructor( cat, Length( output_positions ) );
        
        mor := MorphismConstructor( cat, source, NTuple( 4, labels, input_positions, output_positions, edges ), range );
        
        Assert( 0, IsWellDefinedForMorphisms( cat, mor ) );
        
        return mor;
        
    end );
    
fi;
