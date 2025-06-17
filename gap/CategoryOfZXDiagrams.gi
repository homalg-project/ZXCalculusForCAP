# SPDX-License-Identifier: GPL-2.0-or-later
# ZXCalculusForCAP: The category of ZX-diagrams
#
# Implementations
#

# 0: IO + inner neutral nodes
# 1: green spider = Z
# 2: red spider = X
# 3: Hadamard = H

#BindGlobal( "S_ZX_NODES", [ "neutral", "Z", "X", "H" ] );
#BindGlobal( "S_ZX_EDGES", [ [ 0, 1 ], [ 0, 2 ], [ 0, 3 ] ] );

BindGlobal( "S_ZX_NODES", [ "neutral", "Z", "Zπ", "X", "Xπ", "H" ] );
BindGlobal( "S_ZX_EDGES", List( [ 1 .. Length( S_ZX_NODES ) - 1 ], i -> [ 0, i ] ) );

BindGlobal( "ZX_LabelToInteger", function ( label )
  local pos;
    
    pos := Position( S_ZX_NODES, label );
    
    if pos = fail then
        
        Add( S_ZX_NODES, label );
        
        Add( S_ZX_EDGES, [ 0, Length( S_ZX_NODES ) - 1 ] );
        
        return Length( S_ZX_NODES ) - 1;
        
    else
        
        return pos - 1;
        
    fi;
    
end );

CapJitAddTypeSignature( "ZX_LabelToInteger", [ IsStringRep ], IsBigInt );

BindGlobal( "ZX_IntegerToLabel", function ( int )
    
    return S_ZX_NODES[int + 1];
    
end );

CapJitAddTypeSignature( "ZX_IntegerToLabel", [ IsBigInt ], IsStringRep );

BindGlobal( "ZX_RemovedInnerNeutralNodes", function ( tuple )
  local labels, input_positions, output_positions, edges, pos, edge_positions, new_edge, edge_1, edge_2, remaining_indices;
    
    labels := ShallowCopy( tuple[1] );
    input_positions := ShallowCopy( tuple[2] );
    output_positions := ShallowCopy( tuple[3] );
    edges := ShallowCopy( tuple[4] );
    
    while true do
        
        pos := PositionProperty( [ 1 .. Length( labels ) ], i -> labels[i] = "neutral" and (not i - 1 in input_positions) and (not i - 1 in output_positions) );
        
        if pos = fail then
            
            break;
            
        fi;
        
        # find the edges connecting to the current node
        edge_positions := PositionsProperty( edges, e -> (pos - 1) in e );
        
        new_edge := fail;
        
        if Length( edge_positions ) = 0 then
            
            # isolated neutral node
            # this can happen when composing EvaluationForDual with CoevaluationForDual
            # simply remove below
            
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
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "this should never happen" );
                
            fi;
            
            if edge_2[1] = pos - 1 then
                
                Assert( 0, edge_2[2] <> pos - 1 );
                
                Add( new_edge, edge_2[2] );
                
            elif edge_2[2] = pos - 1 then
                
                Assert( 0, edge_2[1] <> pos - 1 );
                
                Add( new_edge, edge_2[1] );
                
            else
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "this should never happen" );
                
            fi;
            
        else
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "this should never happen" );
            
        fi;
        
        Remove( labels, pos );
        
        # we cannot use Remove for the two edges because the position of the second edge might change after the first is removed
        remaining_indices := Difference( [ 1 .. Length( edges ) ], edge_positions );
        edges := edges{remaining_indices};
        
        if new_edge <> fail then
            
            Add( edges, new_edge );
            
        fi;
        
        # adjust input positions after the removed node
        input_positions := List( input_positions, function ( i )
            
            Assert( 0, i <> pos - 1 );
            
            if i > pos - 1 then
                
                return i - 1;
                
            else
                
                return i;
                
            fi;
            
        end );
        
        # adjust output positions after the removed node
        output_positions := List( output_positions, function ( i )
            
            Assert( 0, i <> pos - 1 );
            
            if i > pos - 1 then
                
                return i - 1;
                
            else
                
                return i;
                
            fi;
            
        end );
        
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
    
    return NTuple( 4, labels, input_positions, output_positions, edges );
    
end );

InstallGlobalFunction( CategoryOfZXDiagrams, FunctionWithNamedArguments(
  [
    [ "no_precompiled_code", false ],
  ],
  function ( CAP_NAMED_ARGUMENTS )
    local ZX;
    
    if CAP_NAMED_ARGUMENTS.no_precompiled_code then
        
        if IsPackageMarkedForLoading( "FunctorCategories", ">= 2023.07-01" ) then
            
            ZX := CategoryOfZXDiagrams_as_CategoryOfCospans_CategoryOfDecoratedQuivers( : FinalizeCategory := false );
            
        else
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "To get a version of `CategoryOfZXDiagrams` without precompiled code, the package `FunctorCategories` is required." );
            
        fi;
        
    else
        
        ZX := CreateCapCategoryWithDataTypes(
                      "CategoryOfZXDiagrams( )",
                      IsCategoryOfZXDiagrams,
                      IsObjectInCategoryOfZXDiagrams,
                      IsMorphismInCategoryOfZXDiagrams,
                      IsCapCategoryTwoCell,
                      IsBigInt,
                      CapJitDataTypeOfNTupleOf( 4,
                              CapJitDataTypeOfListOf( IsStringRep ),
                              CapJitDataTypeOfListOf( IsBigInt ),
                              CapJitDataTypeOfListOf( IsBigInt ),
                              CapJitDataTypeOfListOf( CapJitDataTypeOfNTupleOf( 2, IsBigInt, IsBigInt ) ) ),
                      fail
            : is_computable := false
        );
        
        SetIsRigidSymmetricClosedMonoidalCategory( ZX, true );
        
    fi;
    
    if not CAP_NAMED_ARGUMENTS.no_precompiled_code then
        
        ADD_FUNCTIONS_FOR_CategoryOfZXDiagrams_precompiled( ZX );
        
    fi;
    
    Finalize( ZX );
    
    return ZX;
    
end ) );

##
InstallMethod( Qubits,
        "for a category of ZX-diagram and an integer",
        [ IsCategoryOfZXDiagrams, IsInt ],
        
  function ( ZX, m )
    
    return ObjectConstructor( ZX, BigInt( m ) );
    
end );


##
InstallOtherMethod( Qubits,
        "for an integer",
        [ IsInt ],
        
  function ( m )
    
    return Qubits( ZX, m );
    
end );


##
BindGlobal( "CreateZXMorphism",
  function ( ZX, Z_or_X_or_H, phi, nr_inputs, nr_outputs )
    
    return MorphismConstructor( ZX,
                   Qubits( ZX, nr_inputs ),
                   NTuple( 4,
                           Concatenation(
                                   ListWithIdenticalEntries( nr_inputs, "neutral" ),
                                   [ Concatenation( Z_or_X_or_H, phi ) ],
                                   ListWithIdenticalEntries( nr_outputs, "neutral" ) ),
                           List( [ 0 .. nr_inputs - 1 ], i -> BigInt( i ) ),
                           List( [ nr_inputs + 1 .. nr_inputs + nr_outputs ], o -> BigInt( o ) ),
                           Concatenation(
                                   List( [ 0 .. nr_inputs - 1 ], i -> Pair( BigInt( i ), BigInt( nr_inputs ) ) ),
                                   List( [ nr_inputs + 1 .. nr_inputs + nr_outputs ], o -> Pair( BigInt( o ), BigInt( nr_inputs ) ) ) ) ),
                   Qubits( ZX, nr_outputs ) );
    
end );
  

##
InstallMethod( Z_Spider,
        "for a category of ZX-diagram, a string, and two integers",
        [ IsCategoryOfZXDiagrams, IsStringRep, IsInt, IsInt ],
        
  function ( ZX, phi, nr_inputs, nr_outputs )
    
    return CreateZXMorphism( ZX, "Z", phi, nr_inputs, nr_outputs );
    
end );

##
InstallOtherMethod( Z_Spider,
        "for a category of ZX-diagram and two integers",
        [ IsCategoryOfZXDiagrams, IsInt, IsInt ],
        
  function ( ZX, nr_inputs, nr_outputs )
    
    return Z_Spider( ZX, "", nr_inputs, nr_outputs );
    
end );

##
InstallOtherMethod( Z_Spider,
        "for a string and two integers",
        [ IsStringRep, IsInt, IsInt ],
        
  function ( phi, nr_inputs, nr_outputs )
    
    return Z_Spider( ZX, phi, nr_inputs, nr_outputs );
    
end );

##
InstallOtherMethod( Z_Spider,
        "for two integers",
        [ IsInt, IsInt ],
        
  function ( nr_inputs, nr_outputs )
    
    return Z_Spider( ZX, nr_inputs, nr_outputs );
    
end );

##
InstallMethod( X_Spider,
        "for a category of ZX-diagram, a string, and two integers",
        [ IsCategoryOfZXDiagrams, IsStringRep, IsInt, IsInt ],
        
  function ( ZX, phi, nr_inputs, nr_outputs )
    
    return CreateZXMorphism( ZX, "X", phi, nr_inputs, nr_outputs );
    
end );

##
InstallOtherMethod( X_Spider,
        "for a category of ZX-diagram and two integers",
        [ IsCategoryOfZXDiagrams, IsInt, IsInt ],
        
  function ( ZX, nr_inputs, nr_outputs )
    
    return X_Spider( ZX, "", nr_inputs, nr_outputs );
    
end );

##
InstallOtherMethod( X_Spider,
        "for a string and two integers",
        [ IsStringRep, IsInt, IsInt ],
        
  function ( phi, nr_inputs, nr_outputs )
    
    return X_Spider( ZX, phi, nr_inputs, nr_outputs );
    
end );

##
InstallOtherMethod( X_Spider,
        "for two integers",
        [ IsInt, IsInt ],
        
  function ( nr_inputs, nr_outputs )
    
    return X_Spider( ZX, nr_inputs, nr_outputs );
    
end );

##
InstallMethod( H_Gate,
        "for a category of ZX-diagram",
        [ IsCategoryOfZXDiagrams ],
        
  function ( ZX )
    
    return CreateZXMorphism( ZX, "H", "", 1, 1 );
    
end );

##
InstallOtherMethod( H_Gate,
        "",
        [  ],
        
  function ( )
    
    return H_Gate( ZX );
    
end );

##
InstallOtherMethod( \*,
        "for a morphism and an object in a category of ZX-diagrams",
        [ IsMorphismInCategoryOfZXDiagrams, IsMorphismInCategoryOfZXDiagrams ],
        
  function ( qubits, zx_diagram )
    
    return PreCompose( qubits, zx_diagram );
    
end );

##
InstallOtherMethod( \+,
        "for two objects in a category of ZX-diagrams",
        [ IsObjectInCategoryOfZXDiagrams, IsObjectInCategoryOfZXDiagrams ],
        
  function ( qubits1, qubits2 )
    
    return TensorProduct( qubits1, qubits2 );
    
end );

##
InstallOtherMethod( \+,
        "for two morphisms in a category of ZX-diagrams",
        [ IsMorphismInCategoryOfZXDiagrams, IsMorphismInCategoryOfZXDiagrams ],
        
  function ( zx_diagram1, zx_diagram2 )
    
    return TensorProduct( zx_diagram1, zx_diagram2 );
    
end );

##
InstallOtherMethod( \+,
        "for an object and a morphism in a category of ZX-diagrams",
        [ IsObjectInCategoryOfZXDiagrams, IsMorphismInCategoryOfZXDiagrams ],
        
  function ( qubits, zx_diagram )
    
    return TensorProduct( qubits, zx_diagram );
    
end );

##
InstallOtherMethod( \+,
        "for a morphism and an object in a category of ZX-diagrams",
        [ IsMorphismInCategoryOfZXDiagrams, IsObjectInCategoryOfZXDiagrams ],
        
  function ( qubits, zx_diagram )
    
    return TensorProduct( qubits, zx_diagram );
    
end );

##
InstallMethod( ViewString,
        "for an object in a category of ZX-diagrams",
        [ IsObjectInCategoryOfZXDiagrams ],
        
  function ( obj )
    
    return Concatenation( "<An object in ", Name( CapCategory( obj ) ), " representing ", String( AsInteger( obj ) ), " input/output vertices>" );
    
end );

##
InstallMethod( DisplayString,
        "for an object in a category of ZX-diagrams",
        [ IsObjectInCategoryOfZXDiagrams ],
        
  function ( obj )
    
    return Concatenation( "An object in ", Name( CapCategory( obj ) ), " representing ", String( AsInteger( obj ) ), " input/output vertices.\n" );
    
end );

##
InstallMethod( DisplayString,
        "for a morphism in a category of ZX-diagrams",
        [ IsMorphismInCategoryOfZXDiagrams ],
        
  function ( phi )
    local tuple, labels, input_positions, output_positions, edges;
    
    tuple := ZX_RemovedInnerNeutralNodes( MorphismDatum( phi ) );
    
    labels := tuple[1];
    input_positions := tuple[2];
    output_positions := tuple[3];
    edges := tuple[4];
    
    return Concatenation(
        "A morphism in ", Name( CapCategory( phi ) ), " given by a ZX-diagram with ", String( Length( labels ) ), " vertex labels\n",
        "  ", PrintString( labels ), ",\n",
        "  inputs\n",
        "  ", PrintString( input_positions ), ",\n",
        "  outputs\n",
        "  ", PrintString( output_positions ), ",\n",
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
