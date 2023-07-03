# SPDX-License-Identifier: GPL-2.0-or-later
# ZXCalculusForCAP: The category of ZX-diagrams
#
# Implementations
#

# 0: IO
# 1: green spider = Z, TODO: parametrize
# 2: red spider = X, TODO: parametrize
# 3: Hadamard = H

BindGlobal( "ZX_LabelToInteger", function ( label )
    
    if label = "input" or label = "output" or label = "input_output" or label = "neutral" then
        
        return 0;
        
    elif label = "Z" then
        
        return 1;
        
    elif label = "X" then
        
        return 2;
        
    elif label = "H" then
        
        return 3;
        
    else
        
        Error( "unkown label ", label );
        
    fi;
    
end );

CapJitAddTypeSignature( "ZX_LabelToInteger", [ IsStringRep ], IsInt );

BindGlobal( "ZX_IntegerToLabel", function ( pos, input_positions, output_positions, int )
    
    if int = 0 then
        
        if pos in input_positions then
        
            if pos in output_positions then
                
                return "input_output";
                
            else
                
                return "input";
                
            fi;
            
        elif pos in output_positions then
            
            return "output";
            
        else
            
            return "neutral";
            
        fi;
        
    elif int = 1 then
        
        return "Z";
        
    elif int = 2 then
        
        return "X";
        
    elif int = 3 then
        
        return "H";
        
    else
        
        Error( "unknown integer: ", int );
        
    fi;
    
end );

CapJitAddTypeSignature( "ZX_IntegerToLabel", [ IsInt, IsList, IsList, IsInt ], function ( input_types )
    
    Assert( 0, input_types[2].element_type.filter = IsInt );
    Assert( 0, input_types[3].element_type.filter = IsInt );
    
    return rec( filter := IsStringRep );
    
end );

BindGlobal( "S_ZX_EDGES", Immutable( [ [ 0, 0 ], [ 0, 1 ], [ 1, 0 ], [ 0, 2 ], [ 2, 0 ], [ 0, 3 ], [ 3, 0 ] ] ) );

InstallGlobalFunction( CategoryOfZXDiagrams_as_CategoryOfCospans_CategoryOfDecoratedQuivers, function ( )
  local S_ZX, decorated_quivers, FinalizeCategory, csp, object_constructor, modeling_tower_object_constructor, object_datum, modeling_tower_object_datum, morphism_constructor, modeling_tower_morphism_constructor, morphism_datum, modeling_tower_morphism_datum, ZX;
    
    S_ZX := CreateQuiver( 4, S_ZX_EDGES );
    
    decorated_quivers := CategoryOfDecoratedQuivers( S_ZX, [ "white", "green", "red", "yellow" ], [ "black", "black", "black", "black", "black", "black", "black" ] : FinalizeCategory := true );
    
    csp := CategoryOfCospans_for_ZXCalculus( decorated_quivers : FinalizeCategory := true );
    
    object_constructor := function ( cat, integer )
      local obj;
        
        if not (IsInt( integer ) and integer >= 0) then
            
            Error( "The object datum in the category of ZX-diagrams must be a non-negative integer." );
            
        fi;
        
        obj := CreateCapCategoryObjectWithAttributes( cat, Integer, integer );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsWellDefinedForObjects( cat, obj ) );
        
        return obj;
        
    end;
    
    modeling_tower_object_constructor := function ( cat, integer )
      local csp, decorated_quivers, decorated_quiver, obj;
        
        if not (IsInt( integer ) and integer >= 0) then
            
            Error( "The object datum in the category of ZX-diagrams must be a non-negative integer." );
            
        fi;
        
        csp := ModelingCategory( cat );
        
        decorated_quivers := UnderlyingCategory( csp );
        
        decorated_quiver := ObjectConstructor( decorated_quivers, Pair(
            Triple( integer, 0, [ ] ), # (nr_vertices, nr_edges, edges)
            Pair( ListWithIdenticalEntries( integer, 0 ), [ ] ) # (decorations_of_vertices, deocorations_of_edges)
        ) );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsWellDefinedForObjects( decorated_quivers, decorated_quiver ) );
        
        obj := ObjectConstructor( csp, decorated_quiver );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsWellDefinedForObjects( csp, obj ) );
        
        return obj;
        
    end;
    
    object_datum := function ( cat, object )
        
        return Integer( object );
        
    end;
    
    modeling_tower_object_datum := function ( cat, object )
      local csp, decorated_quivers, pair, integer;
        
        csp := ModelingCategory( cat );
        
        decorated_quivers := UnderlyingCategory( csp );
        
        pair := ObjectDatum( decorated_quivers, ObjectDatum( csp, object ) );
        
        integer := pair[1][1]; # nr_vertices
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert(
            0,
            pair = Pair(
                Triple( integer, 0, [ ] ), # (nr_vertices, nr_edges, edges)
                Pair( ListWithIdenticalEntries( integer, 0 ), [ ] ) # (decorations_of_vertices, deocorations_of_edges)
            )
        );
        
        return integer;
        
    end;
    
    morphism_constructor := function ( cat, source, pair, range )
      local mor;
        
        mor := CreateCapCategoryMorphismWithAttributes( cat, source, range, VertexLabeledGraph, pair );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsWellDefinedForMorphisms( cat, mor ) );
        
        return mor;
        
    end;
    
    modeling_tower_morphism_constructor := function ( cat, source, pair, range )
      local csp, decorated_quivers, labels, edges, input_positions, output_positions, source_decorated_quiver, source_pair, range_decorated_quiver, range_pair, nr_vertices, nr_edges, decorations_of_vertices, decorations_of_edges, central_decorated_quiver, input_morphism, output_morphism, morphism_pair, mor;
        
        csp := ModelingCategory( cat );
        
        decorated_quivers := UnderlyingCategory( csp );
        
        labels := pair[1];
        edges := pair[2];
        
        input_positions := List( PositionsProperty( labels, x -> x in [ "input", "input_output" ] ), p -> p - 1 );
        output_positions := List( PositionsProperty( labels, x -> x in [ "output", "input_output" ] ), p -> p - 1 );
        
        source_decorated_quiver := ObjectDatum( csp, source );
        source_pair := ObjectDatum( decorated_quivers, source_decorated_quiver );
        
        range_decorated_quiver := ObjectDatum( csp, range );
        range_pair := ObjectDatum( decorated_quivers, range_decorated_quiver );
        
        nr_vertices := Length( labels );
        nr_edges := Length( edges );
        
        decorations_of_vertices := List( labels, ZX_LabelToInteger );
        # find each edge in list of S_ZX_EDGES
        # TODO: introduce SafePositions
        decorations_of_edges := List( edges, edge -> SafePositionProperty( S_ZX_EDGES, e -> e = Pair( decorations_of_vertices[1 + edge[1]], decorations_of_vertices[1 + edge[2]] ) ) - 1 );
        
        central_decorated_quiver := ObjectConstructor( decorated_quivers, Pair(
            Triple(
                nr_vertices,
                nr_edges,
                edges
            ),
            Pair(
                decorations_of_vertices,
                decorations_of_edges
            )
        ) );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsWellDefinedForObjects( decorated_quivers, central_decorated_quiver ) );
        
        input_morphism := MorphismConstructor( decorated_quivers, source_decorated_quiver, Pair( input_positions, [ ] ), central_decorated_quiver );
        output_morphism := MorphismConstructor( decorated_quivers, range_decorated_quiver, Pair( output_positions, [ ] ), central_decorated_quiver );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsWellDefinedForMorphisms( decorated_quivers, input_morphism ) );
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsWellDefinedForMorphisms( decorated_quivers, output_morphism ) );
        
        morphism_pair := Pair( input_morphism, output_morphism );
        
        mor := MorphismConstructor( csp, source, morphism_pair, range );
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, IsWellDefinedForMorphisms( csp, mor ) );
        
        return mor;
        
    end;
    
    morphism_datum := function ( cat, morphism )
        
        return VertexLabeledGraph( morphism );
        
    end;
    
    modeling_tower_morphism_datum := function ( cat, morphism )
      local csp, decorated_quivers, morphism_pair, input_morphism, output_morphism, source_decorated_quiver, range_decorated_quiver, central_decorated_quiver, central_decorated_quiver_data, nr_vertices, decorations_of_vertices, input_positions, output_positions, labels, edges;
        
        csp := ModelingCategory( cat );
        
        decorated_quivers := UnderlyingCategory( csp );
        
        morphism_pair := MorphismDatum( csp, morphism );
        
        input_morphism := morphism_pair[1];
        output_morphism := morphism_pair[2];
        
        source_decorated_quiver := Source( input_morphism );
        range_decorated_quiver := Source( output_morphism );
        
        central_decorated_quiver := Range( input_morphism );
        
        central_decorated_quiver_data := ObjectDatum( decorated_quivers, central_decorated_quiver );
        
        nr_vertices := central_decorated_quiver_data[1][1];
        
        decorations_of_vertices := central_decorated_quiver_data[2][1];
        
        input_positions := MorphismDatum( decorated_quivers, input_morphism )[1];
        output_positions := MorphismDatum( decorated_quivers, output_morphism )[1];
        
        labels := List( [ 0 .. nr_vertices - 1 ], i -> ZX_IntegerToLabel( i, input_positions, output_positions, decorations_of_vertices[1 + i] ) );
        edges := central_decorated_quiver_data[1][3];
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, Number( labels, x -> x in [ "input", "input_output" ] ) = ObjectDatum( source_decorated_quiver )[1][1] );
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, Number( labels, x -> x in [ "output", "input_output" ] ) = ObjectDatum( range_decorated_quiver )[1][1] );
        
        return Pair( labels, edges );
        
    end;
    
    ZX := ReinterpretationOfCategory( csp, rec(
        name := "Category of ZX-diagrams",
        category_filter := IsCategoryOfZXDiagrams,
        category_object_filter := IsZXDiagramObject,
        category_morphism_filter := IsZXDiagramMorphism,
        object_datum_type := IsInt,
        morphism_datum_type := CapJitDataTypeOfNTupleOf( 2, CapJitDataTypeOfListOf( IsStringRep ), CapJitDataTypeOfListOf( CapJitDataTypeOfNTupleOf( 2, IsInt, IsInt ) ) ),
        object_constructor := object_constructor,
        object_datum := object_datum,
        morphism_constructor := morphism_constructor,
        morphism_datum := morphism_datum,
        modeling_tower_object_constructor := modeling_tower_object_constructor,
        modeling_tower_object_datum := modeling_tower_object_datum,
        modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
        modeling_tower_morphism_datum := modeling_tower_morphism_datum,
        only_primitive_operations := true,
    ) : FinalizeCategory := false );
    
    SetIsRigidSymmetricClosedMonoidalCategory( ZX, true );
    
    ##
    AddDualOnObjects( ZX, function ( cat, obj )
        
        return obj;
        
    end );
    
    ##
    AddEvaluationForDualWithGivenTensorProduct( ZX, function ( cat, source, obj, range )
      local pair;
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, Integer( source ) = 2 * Integer( obj ) );
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, Integer( range ) = 0 );
        
        pair := Pair( ListWithIdenticalEntries( Integer( source ), "input" ), List( [ 0 .. Integer( obj ) - 1 ], i -> [ i, Integer( source ) - 1 - i ] ) );
        
        return MorphismConstructor( cat, source, pair, range );
        
    end );
    
    ##
    AddCoevaluationForDualWithGivenTensorProduct( ZX, function ( cat, source, obj, range )
      local pair;
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, Integer( source ) = 0 );
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, Integer( range ) = 2 * Integer( obj ) );
        
        pair := Pair( ListWithIdenticalEntries( Integer( range ), "output" ), List( [ 0 .. Integer( obj ) - 1 ], i -> [ i, Integer( range ) - 1 - i ] ) );
        
        return MorphismConstructor( cat, source, pair, range );
        
    end );
    
    if ValueOption( "no_precompiled_code" ) <> true then
        
        ADD_FUNCTIONS_FOR_CategoryOfZXDiagrams_as_CategoryOfCospans_CategoryOfDecoratedQuivers_precompiled( ZX );
        
    fi;
    
    Finalize( ZX );
    
    return ZX;
    
end );

BindGlobal( "ZX", CategoryOfZXDiagrams_as_CategoryOfCospans_CategoryOfDecoratedQuivers( ) );

##
InstallMethod( ViewString,
        "for an object in a category of ZX-diagrams",
        [ IsZXDiagramObject ],
        
  function ( obj )
    
    return Concatenation( "<An object in ", Name( CapCategory( obj ) ), " representing ", String( Integer( obj ) ), " input/output vertices>" );
    
end );

##
InstallMethod( DisplayString,
        "for an object in a category of ZX-diagrams",
        [ IsZXDiagramObject ],
        
  function ( obj )
    
    return Concatenation( "An object in ", Name( CapCategory( obj ) ), " representing ", String( Integer( obj ) ), " input/output vertices.\n" );
    
end );

##
InstallMethod( DisplayString,
        "for a morphism in a category of ZX-diagrams",
        [ IsZXDiagramMorphism ],
        
  function ( phi )
    local pair, labels, edges, pos, edge_positions, new_edge, edge_1, edge_2, remaining_indices;
    
    pair := MorphismDatum( phi );
    
    labels := ShallowCopy( pair[1] );
    edges := ShallowCopy( pair[2] );
    
    # remove neutral nodes
    while "neutral" in labels do
        
        pos := SafePosition( labels, "neutral" );
        
        # find the edges connecting to the current node
        edge_positions := PositionsProperty( edges, e -> (pos - 1) in e );
        
        new_edge := fail;
        
        # degenerate case: loop
        if Length( edge_positions ) = 1 then
            
            # nothing to do
            
        # usual case: two edges
        elif Length( edge_positions ) = 2 then
            
            edge_1 := edges[edge_positions[1]];
            edge_2 := edges[edge_positions[2]];
            
            new_edge := [ ];
            
            if edge_1[1] = pos - 1 then
                
                Assert( 0, edge_1[2] <> pos - 1 );
                
                Add( new_edge, edge_1[2] );
                
            elif edge_1[2] = pos - 1 then
                
                Assert( 0, edge_1[1] <> pos - 1 );
                
                Add( new_edge, edge_1[1] );
                
            else
                
                Error( "this should never happen" );
                
            fi;
            
            if edge_2[1] = pos - 1 then
                
                Assert( 0, edge_2[2] <> pos - 1 );
                
                Add( new_edge, edge_2[2] );
                
            elif edge_2[2] = pos - 1 then
                
                Assert( 0, edge_2[1] <> pos - 1 );
                
                Add( new_edge, edge_2[1] );
                
            else
                
                Error( "this should never happen" );
                
            fi;
            
        else
            
            Error( "this should never happen" );
            
        fi;
            
        Remove( labels, pos );
        
        # we cannot use Remove for the two edges because the position of the second edge might change after the first is removed
        remaining_indices := Difference( [ 1 .. Length( edges ) ], edge_positions );
        edges := edges{remaining_indices};
        
        if new_edge <> fail then
            
            Add( edges, new_edge );
            
        fi;
        
        # adjust edges from/to nodes after the removed node
        edges := List( edges, function ( e )
            
            e := ShallowCopy( e );
            
            Assert( 0, e[1] <> pos - 1 );
            
            if e[1] > pos - 1 then
                
                e[1] := e[1] - 1;
                
            fi;
            
            Assert( 0, e[2] <> pos - 1 );
            
            if e[2] > pos - 1 then
                
                e[2] := e[2] - 1;
                
            fi;
            
            return e;
            
        end );
        
    od;
    
    return Concatenation(
        "A morphism in ", Name( CapCategory( phi ) ), " given by a ZX diagram with ", String( Length( labels ) ), " vertex labels\n",
        "  ", PrintString( labels ), "\n",
        "  and ", String( Length( edges ) ), " edges\n",
        "  ", PrintString( edges ), ".\n"
    );
    
end );
