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
        
        return BigInt( 0 );
        
    elif label = "Z" then
        
        return BigInt( 1 );
        
    elif label = "X" then
        
        return BigInt( 2 );
        
    elif label = "H" then
        
        return BigInt( 3 );
        
    else
        
        Error( "unkown label ", label );
        
    fi;
    
end );

CapJitAddTypeSignature( "ZX_LabelToInteger", [ IsStringRep ], IsBigInt );

BindGlobal( "ZX_IntegerToLabel", function ( pos, input_positions, output_positions, int )
    
    if int = BigInt( 0 ) then
        
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
        
    elif int = BigInt( 1 ) then
        
        return "Z";
        
    elif int = BigInt( 2 ) then
        
        return "X";
        
    elif int = BigInt( 3 ) then
        
        return "H";
        
    else
        
        Error( "unknown integer: ", int );
        
    fi;
    
end );

CapJitAddTypeSignature( "ZX_IntegerToLabel", [ IsBigInt, IsList, IsList, IsBigInt ], function ( input_types )
    
    Assert( 0, input_types[2].element_type.filter = IsBigInt );
    Assert( 0, input_types[3].element_type.filter = IsBigInt );
    
    return rec( filter := IsStringRep );
    
end );

BindGlobal( "ZX_RemoveNeutralNodes", function ( phi )
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
    
    return [ labels, edges ];
    
end );

BindGlobal( "S_ZX_EDGES", Immutable( [ [ 0, 0 ], [ 0, 1 ], [ 1, 0 ], [ 0, 2 ], [ 2, 0 ], [ 0, 3 ], [ 3, 0 ] ] ) );

InstallGlobalFunction( CategoryOfZXDiagrams, function ( )
  local ZX;
    
    if ValueOption( "no_precompiled_code" ) = true then
        
        if IsPackageMarkedForLoading( "FunctorCategories", ">= 2023.07-01" ) then
            
            ZX := CategoryOfZXDiagrams_as_CategoryOfCospans_CategoryOfDecoratedQuivers( : FinalizeCategory := false );
            
        else
            
            Error( "To get a version of `CategoryOfZXDiagrams` without precompiled code, the package `FunctorCategories` is required." );
            
        fi;
        
    else
        
        ZX := CreateCapCategoryWithDataTypes(
            "Category of ZX-diagrams", IsCategoryOfZXDiagrams,
            IsZXDiagramObject, IsZXDiagramMorphism, IsCapCategoryTwoCell,
            IsBigInt, CapJitDataTypeOfNTupleOf( 2, CapJitDataTypeOfListOf( IsStringRep ), CapJitDataTypeOfListOf( CapJitDataTypeOfNTupleOf( 2, IsBigInt, IsBigInt ) ) ), fail
            : is_computable := false
        );
        
    fi;
    
    SetIsRigidSymmetricClosedMonoidalCategory( ZX, true );
    
    ##
    AddDualOnObjects( ZX, function ( cat, obj )
        
        return obj;
        
    end );
    
    ##
    AddEvaluationForDualWithGivenTensorProduct( ZX, function ( cat, source, obj, range )
      local pair;
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, AsInteger( source ) = 2 * AsInteger( obj ) );
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, AsInteger( range ) = 0 );
        
        pair := Pair( ListWithIdenticalEntries( AsInteger( source ), "input" ), List( [ 0 .. AsInteger( obj ) - 1 ], i -> [ i, AsInteger( source ) - 1 - i ] ) );
        
        return MorphismConstructor( cat, source, pair, range );
        
    end );
    
    ##
    AddCoevaluationForDualWithGivenTensorProduct( ZX, function ( cat, source, obj, range )
      local pair;
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, AsInteger( source ) = 0 );
        #% CAP_JIT_DROP_NEXT_STATEMENT
        Assert( 0, AsInteger( range ) = 2 * AsInteger( obj ) );
        
        pair := Pair( ListWithIdenticalEntries( AsInteger( range ), "output" ), List( [ 0 .. AsInteger( obj ) - 1 ], i -> [ i, AsInteger( range ) - 1 - i ] ) );
        
        return MorphismConstructor( cat, source, pair, range );
        
    end );
    
    if ValueOption( "no_precompiled_code" ) <> true then
        
        ADD_FUNCTIONS_FOR_CategoryOfZXDiagrams_precompiled( ZX );
        
    fi;
    
    Finalize( ZX );
    
    return ZX;
    
end );

##
InstallMethod( ViewString,
        "for an object in a category of ZX-diagrams",
        [ IsZXDiagramObject ],
        
  function ( obj )
    
    return Concatenation( "<An object in ", Name( CapCategory( obj ) ), " representing ", String( AsInteger( obj ) ), " input/output vertices>" );
    
end );

##
InstallMethod( DisplayString,
        "for an object in a category of ZX-diagrams",
        [ IsZXDiagramObject ],
        
  function ( obj )
    
    return Concatenation( "An object in ", Name( CapCategory( obj ) ), " representing ", String( AsInteger( obj ) ), " input/output vertices.\n" );
    
end );

##
InstallMethod( DisplayString,
        "for a morphism in a category of ZX-diagrams",
        [ IsZXDiagramMorphism ],
        
  function ( phi )
    local phi_without_neutral_nodes, labels, edges;
    
    phi_without_neutral_nodes := ZX_RemoveNeutralNodes( phi );
    labels := phi_without_neutral_nodes[1];
    edges := phi_without_neutral_nodes[2];
    
    return Concatenation(
        "A morphism in ", Name( CapCategory( phi ) ), " given by a ZX diagram with ", String( Length( labels ) ), " vertex labels\n",
        "  ", PrintString( labels ), "\n",
        "  and ", String( Length( edges ) ), " edges\n",
        "  ", PrintString( edges ), ".\n"
    );
    
end );

InstallGlobalFunction( SKELETAL_FIN_SETS_ExplicitCoequalizer_primitive_input,
  function ( s, D )
    
    s := FinSet( SkeletalFinSets, BigInt( s ) );
    D := List( D, x -> MapOfFinSets( SkeletalFinSets, FinSet( SkeletalFinSets, BigInt( x[1] ) ), List( x[2], y -> BigInt( y ) ), FinSet( SkeletalFinSets, BigInt( x[3] ) ) ) );
    
    return SKELETAL_FIN_SETS_ExplicitCoequalizer( s, D );
    
end );
