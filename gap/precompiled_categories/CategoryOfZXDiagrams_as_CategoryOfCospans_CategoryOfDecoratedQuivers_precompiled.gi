# SPDX-License-Identifier: GPL-2.0-or-later
# ZXCalculusForCAP: The category of ZX-diagrams
#
# Implementations
#
BindGlobal( "ADD_FUNCTIONS_FOR_CategoryOfZXDiagrams_as_CategoryOfCospans_CategoryOfDecoratedQuivers_precompiled", function ( cat )
    
    ##
    AddAssociatorLeftToRightWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local deduped_1_1, hoisted_2_1, hoisted_3_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1;
    deduped_9_1 := Integer( c_1 );
    deduped_8_1 := Integer( b_1 );
    deduped_7_1 := Integer( a_1 );
    deduped_6_1 := deduped_8_1 + deduped_9_1;
    deduped_5_1 := [ 0 .. Integer( r_1 ) - 1 ];
    hoisted_2_1 := [ deduped_8_1 .. deduped_6_1 - 1 ];
    deduped_1_1 := [ deduped_7_1 .. deduped_7_1 + deduped_6_1 - 1 ];
    hoisted_3_1 := Concatenation( Concatenation( [ 0 .. deduped_7_1 - 1 ], List( [ 0 .. deduped_8_1 - 1 ], function ( i_2 )
                return deduped_1_1[1 + i_2];
            end ) ), List( [ 0 .. deduped_9_1 - 1 ], function ( i_2 )
              return deduped_1_1[1 + hoisted_2_1[(1 + i_2)]];
          end ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, VertexLabeledGraph, NTuple( 2, List( deduped_5_1, function ( i_2 )
                return ZX_IntegerToLabel( i_2, hoisted_3_1, deduped_5_1, 0 );
            end ), [  ] ) );
end
########
        
    , 100 );
    
    ##
    AddAssociatorRightToLeftWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, c_1, r_1 )
    local hoisted_1_1, hoisted_2_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1;
    deduped_7_1 := Integer( b_1 );
    deduped_6_1 := Integer( a_1 );
    deduped_5_1 := deduped_6_1 + deduped_7_1;
    deduped_4_1 := [ 0 .. Integer( r_1 ) - 1 ];
    hoisted_1_1 := [ deduped_6_1 .. deduped_5_1 - 1 ];
    hoisted_2_1 := Concatenation( [ 0 .. deduped_6_1 - 1 ], Concatenation( List( [ 0 .. deduped_7_1 - 1 ], function ( i_2 )
                return hoisted_1_1[1 + i_2];
            end ), [ deduped_5_1 .. deduped_5_1 + Integer( c_1 ) - 1 ] ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, VertexLabeledGraph, NTuple( 2, List( deduped_4_1, function ( i_2 )
                return ZX_IntegerToLabel( i_2, hoisted_2_1, deduped_4_1, 0 );
            end ), [  ] ) );
end
########
        
    , 100 );
    
    ##
    AddBraidingInverseWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local hoisted_1_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := Integer( a_1 );
    deduped_3_1 := [ 0 .. Integer( r_1 ) - 1 ];
    hoisted_1_1 := Concatenation( [ deduped_4_1 .. deduped_4_1 + Integer( b_1 ) - 1 ], [ 0 .. deduped_4_1 - 1 ] );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, VertexLabeledGraph, NTuple( 2, List( deduped_3_1, function ( i_2 )
                return ZX_IntegerToLabel( i_2, hoisted_1_1, deduped_3_1, 0 );
            end ), [  ] ) );
end
########
        
    , 100 );
    
    ##
    AddBraidingWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, a_1, b_1, r_1 )
    local hoisted_1_1, deduped_3_1, deduped_4_1;
    deduped_4_1 := Integer( b_1 );
    deduped_3_1 := [ 0 .. Integer( r_1 ) - 1 ];
    hoisted_1_1 := Concatenation( [ deduped_4_1 .. deduped_4_1 + Integer( a_1 ) - 1 ], [ 0 .. deduped_4_1 - 1 ] );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, VertexLabeledGraph, NTuple( 2, List( deduped_3_1, function ( i_2 )
                return ZX_IntegerToLabel( i_2, hoisted_1_1, deduped_3_1, 0 );
            end ), [  ] ) );
end
########
        
    , 100 );
    
    ##
    AddCoevaluationForDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    local hoisted_1_1, deduped_2_1;
    deduped_2_1 := Integer( r_1 );
    hoisted_1_1 := deduped_2_1 - 1;
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, VertexLabeledGraph, NTuple( 2, ListWithIdenticalEntries( deduped_2_1, "output" ), List( [ 0 .. Integer( a_1 ) - 1 ], function ( i_2 )
                return [ i_2, hoisted_1_1 - i_2 ];
            end ) ) );
end
########
        
    , 100 );
    
    ##
    AddDualOnObjects( cat,
        
########
function ( cat_1, a_1 )
    return a_1;
end
########
        
    , 100 );
    
    ##
    AddEvaluationForDualWithGivenTensorProduct( cat,
        
########
function ( cat_1, s_1, a_1, r_1 )
    local hoisted_1_1, deduped_2_1;
    deduped_2_1 := Integer( s_1 );
    hoisted_1_1 := deduped_2_1 - 1;
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, VertexLabeledGraph, NTuple( 2, ListWithIdenticalEntries( deduped_2_1, "input" ), List( [ 0 .. Integer( a_1 ) - 1 ], function ( i_2 )
                return [ i_2, hoisted_1_1 - i_2 ];
            end ) ) );
end
########
        
    , 100 );
    
    ##
    AddIdentityMorphism( cat,
        
########
function ( cat_1, a_1 )
    local deduped_2_1;
    deduped_2_1 := [ 0 .. Integer( a_1 ) - 1 ];
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, a_1, VertexLabeledGraph, NTuple( 2, List( deduped_2_1, function ( i_2 )
                return ZX_IntegerToLabel( i_2, deduped_2_1, deduped_2_1, 0 );
            end ), [  ] ) );
end
########
        
    , 100 );
    
    ##
    AddIsEqualForMorphisms( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local deduped_3_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1;
    deduped_12_1 := VertexLabeledGraph( arg3_1 );
    deduped_11_1 := VertexLabeledGraph( arg2_1 );
    deduped_10_1 := deduped_12_1[2];
    deduped_9_1 := deduped_11_1[2];
    deduped_8_1 := deduped_12_1[1];
    deduped_7_1 := deduped_11_1[1];
    deduped_6_1 := List( deduped_8_1, ZX_LabelToInteger );
    deduped_5_1 := List( deduped_7_1, ZX_LabelToInteger );
    deduped_4_1 := [ "output", "input_output" ];
    deduped_3_1 := [ "input", "input_output" ];
    return Length( deduped_7_1 ) = Length( deduped_8_1 ) and Length( deduped_9_1 ) = Length( deduped_10_1 ) and (List( deduped_9_1, function ( a_2 )
                        return a_2[1];
                    end ) = List( deduped_10_1, function ( a_2 )
                        return a_2[1];
                    end ) and List( deduped_9_1, function ( a_2 )
                        return a_2[2];
                    end ) = List( deduped_10_1, function ( a_2 )
                        return a_2[2];
                    end )) and (deduped_5_1 = deduped_6_1 and List( deduped_9_1, function ( edge_2 )
                      local hoisted_1_2;
                      hoisted_1_2 := NTuple( 2, deduped_5_1[1 + edge_2[1]], deduped_5_1[1 + edge_2[2]] );
                      return SafePositionProperty( S_ZX_EDGES, function ( e_3 )
                                return (e_3 = hoisted_1_2);
                            end ) - 1;
                  end ) = List( deduped_10_1, function ( edge_2 )
                      local hoisted_1_2;
                      hoisted_1_2 := NTuple( 2, deduped_6_1[1 + edge_2[1]], deduped_6_1[1 + edge_2[2]] );
                      return SafePositionProperty( S_ZX_EDGES, function ( e_3 )
                                return (e_3 = hoisted_1_2);
                            end ) - 1;
                  end )) and (List( PositionsProperty( deduped_8_1, function ( x_2 )
                      return (x_2 in deduped_3_1);
                  end ), function ( p_2 )
                    return p_2 - 1;
                end ) = List( PositionsProperty( deduped_7_1, function ( x_2 )
                      return (x_2 in deduped_3_1);
                  end ), function ( p_2 )
                    return p_2 - 1;
                end ) and true) and (List( PositionsProperty( deduped_8_1, function ( x_2 )
                    return (x_2 in deduped_4_1);
                end ), function ( p_2 )
                  return p_2 - 1;
              end ) = List( PositionsProperty( deduped_7_1, function ( x_2 )
                    return (x_2 in deduped_4_1);
                end ), function ( p_2 )
                  return p_2 - 1;
              end ) and true);
end
########
        
    , 100 );
    
    ##
    AddIsEqualForObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    local deduped_1_1, deduped_2_1;
    deduped_2_1 := Integer( arg3_1 );
    deduped_1_1 := Integer( arg2_1 );
    return deduped_1_1 = deduped_2_1 and true and (true and true) and (ListWithIdenticalEntries( deduped_1_1, 0 ) = ListWithIdenticalEntries( deduped_2_1, 0 ) and true);
end
########
        
    , 100 );
    
    ##
    AddIsWellDefinedForMorphisms( cat,
        
########
function ( cat_1, arg2_1 )
    local hoisted_1_1, deduped_2_1, deduped_6_1, hoisted_7_1, deduped_8_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1, deduped_29_1, deduped_30_1, deduped_31_1, deduped_32_1, deduped_33_1, deduped_34_1, deduped_35_1, deduped_36_1, deduped_37_1, deduped_38_1, deduped_39_1;
    deduped_39_1 := [  ];
    deduped_38_1 := true and true;
    deduped_37_1 := VertexLabeledGraph( arg2_1 );
    deduped_36_1 := deduped_38_1 and deduped_38_1;
    deduped_35_1 := deduped_36_1 and deduped_36_1;
    deduped_34_1 := deduped_36_1 and deduped_38_1;
    deduped_33_1 := deduped_37_1[2];
    deduped_32_1 := deduped_37_1[1];
    deduped_31_1 := Integer( Range( arg2_1 ) );
    deduped_30_1 := Integer( Source( arg2_1 ) );
    deduped_29_1 := ModelingCategory( UnderlyingCategory( ModelingCategory( cat_1 ) ) );
    hoisted_7_1 := [ "output", "input_output" ];
    deduped_28_1 := List( PositionsProperty( deduped_32_1, function ( x_2 )
              return x_2 in hoisted_7_1;
          end ), function ( p_2 )
            return p_2 - 1;
        end );
    hoisted_1_1 := [ "input", "input_output" ];
    deduped_27_1 := List( PositionsProperty( deduped_32_1, function ( x_2 )
              return x_2 in hoisted_1_1;
          end ), function ( p_2 )
            return p_2 - 1;
        end );
    deduped_26_1 := RangeCategoryOfHomomorphismStructure( deduped_29_1 );
    deduped_25_1 := CreateCapCategoryObjectWithAttributes( deduped_26_1, Length, deduped_31_1 );
    deduped_24_1 := CreateCapCategoryObjectWithAttributes( deduped_26_1, Length, Length( deduped_33_1 ) );
    deduped_23_1 := CreateCapCategoryObjectWithAttributes( deduped_26_1, Length, Length( deduped_32_1 ) );
    deduped_22_1 := CreateCapCategoryObjectWithAttributes( deduped_26_1, Length, 0 );
    deduped_21_1 := CreateCapCategoryObjectWithAttributes( deduped_26_1, Length, deduped_30_1 );
    deduped_20_1 := CreateCapCategoryMorphismWithAttributes( deduped_26_1, deduped_22_1, deduped_25_1, AsList, deduped_39_1 );
    deduped_19_1 := CreateCapCategoryMorphismWithAttributes( deduped_26_1, deduped_22_1, deduped_24_1, AsList, deduped_39_1 );
    deduped_18_1 := CreateCapCategoryMorphismWithAttributes( deduped_26_1, deduped_22_1, deduped_21_1, AsList, deduped_39_1 );
    deduped_17_1 := ModelingCategory( ModelingCategory( AmbientCategory( deduped_29_1 ) ) );
    deduped_16_1 := Source( deduped_17_1 );
    deduped_15_1 := SetOfGeneratingMorphisms( deduped_17_1 );
    deduped_14_1 := SetOfObjects( deduped_17_1 );
    deduped_13_1 := CreateCapCategoryObjectWithAttributes( deduped_17_1, Source, deduped_16_1, Range, deduped_26_1, ValuesOfPreSheaf, NTuple( 2, [ deduped_25_1, deduped_22_1 ], [ deduped_20_1, deduped_20_1 ] ) );
    deduped_12_1 := CreateCapCategoryObjectWithAttributes( deduped_17_1, Source, deduped_16_1, Range, deduped_26_1, ValuesOfPreSheaf, NTuple( 2, [ deduped_23_1, deduped_24_1 ], [ CreateCapCategoryMorphismWithAttributes( deduped_26_1, deduped_24_1, deduped_23_1, AsList, List( deduped_33_1, function ( a_2 )
                      return a_2[1];
                  end ) ), CreateCapCategoryMorphismWithAttributes( deduped_26_1, deduped_24_1, deduped_23_1, AsList, List( deduped_33_1, function ( a_2 )
                      return a_2[2];
                  end ) ) ] ) );
    deduped_11_1 := CreateCapCategoryObjectWithAttributes( deduped_17_1, Source, deduped_16_1, Range, deduped_26_1, ValuesOfPreSheaf, NTuple( 2, [ deduped_21_1, deduped_22_1 ], [ deduped_18_1, deduped_18_1 ] ) );
    deduped_8_1 := CreateCapCategoryMorphismWithAttributes( deduped_17_1, deduped_13_1, deduped_12_1, ValuesOnAllObjects, [ CreateCapCategoryMorphismWithAttributes( deduped_26_1, deduped_25_1, deduped_23_1, AsList, deduped_28_1 ), deduped_19_1 ] );
    deduped_6_1 := List( deduped_32_1, ZX_LabelToInteger );
    deduped_2_1 := CreateCapCategoryMorphismWithAttributes( deduped_17_1, deduped_11_1, deduped_12_1, ValuesOnAllObjects, [ CreateCapCategoryMorphismWithAttributes( deduped_26_1, deduped_21_1, deduped_23_1, AsList, deduped_27_1 ), deduped_19_1 ] );
    return deduped_34_1 and deduped_34_1 and deduped_34_1 and (deduped_35_1 and (ForAll( deduped_14_1, function ( o_2 )
                      local hoisted_1_2, deduped_2_2, deduped_3_2;
                      deduped_3_2 := deduped_2_1( o_2 );
                      deduped_2_2 := AsList( deduped_3_2 );
                      hoisted_1_2 := Length( Range( deduped_3_2 ) );
                      if not ForAll( deduped_2_2, function ( a_3 )
                                   return (IsBigInt( a_3 ) and a_3 >= 0);
                               end ) then
                          return false;
                      elif Length( Source( deduped_3_2 ) ) <> Length( deduped_2_2 ) then
                          return false;
                      elif not ForAll( deduped_2_2, function ( a_3 )
                                   return a_3 < hoisted_1_2;
                               end ) then
                          return false;
                      else
                          return true;
                      fi;
                      return;
                  end ) and ForAll( deduped_15_1, function ( m_2 )
                      local hoisted_1_2, hoisted_2_2, hoisted_3_2, hoisted_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2;
                      deduped_8_2 := deduped_12_1( m_2 );
                      deduped_7_2 := deduped_11_1( m_2 );
                      deduped_6_2 := deduped_2_1( Range( m_2 ) );
                      deduped_5_2 := deduped_2_1( Source( m_2 ) );
                      hoisted_4_2 := AsList( deduped_8_2 );
                      hoisted_3_2 := AsList( deduped_6_2 );
                      hoisted_2_2 := AsList( deduped_5_2 );
                      hoisted_1_2 := AsList( deduped_7_2 );
                      return (Length( Range( deduped_7_2 ) ) = Length( Source( deduped_5_2 ) ) and Length( Range( deduped_6_2 ) ) = Length( Source( deduped_8_2 ) ) and List( [ 0 .. Length( Source( deduped_7_2 ) ) - 1 ], function ( i_3 )
                                  return hoisted_2_2[1 + hoisted_1_2[(1 + i_3)]];
                              end ) = List( [ 0 .. Length( Source( deduped_6_2 ) ) - 1 ], function ( i_3 )
                                  return hoisted_4_2[1 + hoisted_3_2[(1 + i_3)]];
                              end ));
                  end )) and (ListWithIdenticalEntries( deduped_30_1, 0 ) = List( [ 0 .. deduped_30_1 - 1 ], function ( i_2 )
                      return deduped_6_1[1 + deduped_27_1[(1 + i_2)]];
                  end ) and true)) and (deduped_35_1 and (ForAll( deduped_14_1, function ( o_2 )
                    local hoisted_1_2, deduped_2_2, deduped_3_2;
                    deduped_3_2 := deduped_8_1( o_2 );
                    deduped_2_2 := AsList( deduped_3_2 );
                    hoisted_1_2 := Length( Range( deduped_3_2 ) );
                    if not ForAll( deduped_2_2, function ( a_3 )
                                 return (IsBigInt( a_3 ) and a_3 >= 0);
                             end ) then
                        return false;
                    elif Length( Source( deduped_3_2 ) ) <> Length( deduped_2_2 ) then
                        return false;
                    elif not ForAll( deduped_2_2, function ( a_3 )
                                 return a_3 < hoisted_1_2;
                             end ) then
                        return false;
                    else
                        return true;
                    fi;
                    return;
                end ) and ForAll( deduped_15_1, function ( m_2 )
                    local hoisted_1_2, hoisted_2_2, hoisted_3_2, hoisted_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2;
                    deduped_8_2 := deduped_12_1( m_2 );
                    deduped_7_2 := deduped_13_1( m_2 );
                    deduped_6_2 := deduped_8_1( Range( m_2 ) );
                    deduped_5_2 := deduped_8_1( Source( m_2 ) );
                    hoisted_4_2 := AsList( deduped_8_2 );
                    hoisted_3_2 := AsList( deduped_6_2 );
                    hoisted_2_2 := AsList( deduped_5_2 );
                    hoisted_1_2 := AsList( deduped_7_2 );
                    return (Length( Range( deduped_7_2 ) ) = Length( Source( deduped_5_2 ) ) and Length( Range( deduped_6_2 ) ) = Length( Source( deduped_8_2 ) ) and List( [ 0 .. Length( Source( deduped_7_2 ) ) - 1 ], function ( i_3 )
                                return hoisted_2_2[1 + hoisted_1_2[(1 + i_3)]];
                            end ) = List( [ 0 .. Length( Source( deduped_6_2 ) ) - 1 ], function ( i_3 )
                                return hoisted_4_2[1 + hoisted_3_2[(1 + i_3)]];
                            end ));
                end )) and (ListWithIdenticalEntries( deduped_31_1, 0 ) = List( [ 0 .. deduped_31_1 - 1 ], function ( i_2 )
                    return deduped_6_1[1 + deduped_28_1[(1 + i_2)]];
                end ) and true));
end
########
        
    , 100 );
    
    ##
    AddIsWellDefinedForObjects( cat,
        
########
function ( cat_1, arg2_1 )
    local deduped_1_1, deduped_4_1, deduped_5_1, deduped_6_1, deduped_7_1, deduped_8_1, deduped_9_1, deduped_10_1, deduped_11_1, deduped_12_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1;
    deduped_19_1 := [  ];
    deduped_18_1 := true and true;
    deduped_17_1 := Integer( arg2_1 );
    deduped_16_1 := ModelingCategory( UnderlyingCategory( ModelingCategory( cat_1 ) ) );
    deduped_15_1 := RangeCategoryOfHomomorphismStructure( deduped_16_1 );
    deduped_14_1 := DefiningTripleOfQuiverEnrichedOverSkeletalFinSets( BaseObject( deduped_16_1 ) );
    deduped_13_1 := CreateCapCategoryObjectWithAttributes( deduped_15_1, Length, 0 );
    deduped_12_1 := CreateCapCategoryObjectWithAttributes( deduped_15_1, Length, deduped_17_1 );
    deduped_11_1 := deduped_14_1[3];
    deduped_10_1 := CreateCapCategoryMorphismWithAttributes( deduped_15_1, deduped_13_1, deduped_12_1, AsList, deduped_19_1 );
    deduped_9_1 := ModelingCategory( ModelingCategory( AmbientCategory( deduped_16_1 ) ) );
    deduped_8_1 := CreateCapCategoryObjectWithAttributes( deduped_15_1, Length, deduped_14_1[2] );
    deduped_7_1 := CreateCapCategoryObjectWithAttributes( deduped_15_1, Length, deduped_14_1[1] );
    deduped_6_1 := Source( deduped_9_1 );
    deduped_5_1 := CreateCapCategoryObjectWithAttributes( deduped_9_1, Source, deduped_6_1, Range, deduped_15_1, ValuesOfPreSheaf, NTuple( 2, [ deduped_12_1, deduped_13_1 ], [ deduped_10_1, deduped_10_1 ] ) );
    deduped_4_1 := CreateCapCategoryObjectWithAttributes( deduped_9_1, Source, deduped_6_1, Range, deduped_15_1, ValuesOfPreSheaf, NTuple( 2, [ deduped_7_1, deduped_8_1 ], [ CreateCapCategoryMorphismWithAttributes( deduped_15_1, deduped_8_1, deduped_7_1, AsList, List( deduped_11_1, function ( a_2 )
                      return a_2[1];
                  end ) ), CreateCapCategoryMorphismWithAttributes( deduped_15_1, deduped_8_1, deduped_7_1, AsList, List( deduped_11_1, function ( a_2 )
                      return a_2[2];
                  end ) ) ] ) );
    deduped_1_1 := CreateCapCategoryMorphismWithAttributes( deduped_9_1, deduped_5_1, deduped_4_1, ValuesOnAllObjects, [ CreateCapCategoryMorphismWithAttributes( deduped_15_1, deduped_12_1, deduped_7_1, AsList, ListWithIdenticalEntries( deduped_17_1, 0 ) ), CreateCapCategoryMorphismWithAttributes( deduped_15_1, deduped_13_1, deduped_8_1, AsList, deduped_19_1 ) ] );
    return deduped_18_1 and deduped_18_1 and (ForAll( SetOfObjects( deduped_9_1 ), function ( o_2 )
                local hoisted_1_2, deduped_2_2, deduped_3_2;
                deduped_3_2 := deduped_1_1( o_2 );
                deduped_2_2 := AsList( deduped_3_2 );
                hoisted_1_2 := Length( Range( deduped_3_2 ) );
                if not ForAll( deduped_2_2, function ( a_3 )
                             return (IsBigInt( a_3 ) and a_3 >= 0);
                         end ) then
                    return false;
                elif Length( Source( deduped_3_2 ) ) <> Length( deduped_2_2 ) then
                    return false;
                elif not ForAll( deduped_2_2, function ( a_3 )
                             return a_3 < hoisted_1_2;
                         end ) then
                    return false;
                else
                    return true;
                fi;
                return;
            end ) and ForAll( SetOfGeneratingMorphisms( deduped_9_1 ), function ( m_2 )
                local hoisted_1_2, hoisted_2_2, hoisted_3_2, hoisted_4_2, deduped_5_2, deduped_6_2, deduped_7_2, deduped_8_2;
                deduped_8_2 := deduped_4_1( m_2 );
                deduped_7_2 := deduped_5_1( m_2 );
                deduped_6_2 := deduped_1_1( Range( m_2 ) );
                deduped_5_2 := deduped_1_1( Source( m_2 ) );
                hoisted_4_2 := AsList( deduped_8_2 );
                hoisted_3_2 := AsList( deduped_6_2 );
                hoisted_2_2 := AsList( deduped_5_2 );
                hoisted_1_2 := AsList( deduped_7_2 );
                return (Length( Range( deduped_7_2 ) ) = Length( Source( deduped_5_2 ) ) and Length( Range( deduped_6_2 ) ) = Length( Source( deduped_8_2 ) ) and List( [ 0 .. Length( Source( deduped_7_2 ) ) - 1 ], function ( i_3 )
                            return hoisted_2_2[1 + hoisted_1_2[(1 + i_3)]];
                        end ) = List( [ 0 .. Length( Source( deduped_6_2 ) ) - 1 ], function ( i_3 )
                            return hoisted_4_2[1 + hoisted_3_2[(1 + i_3)]];
                        end ));
            end ));
end
########
        
    , 100 );
    
    ##
    AddLeftUnitorInverseWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, r_1 )
    local hoisted_1_1, hoisted_2_1, deduped_3_1;
    deduped_3_1 := Integer( a_1 ) - 1;
    hoisted_2_1 := [ 0 .. deduped_3_1 ];
    hoisted_1_1 := [ BigInt( 0 ) .. deduped_3_1 ];
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, r_1, VertexLabeledGraph, NTuple( 2, List( [ 0 .. Integer( r_1 ) - 1 ], function ( i_2 )
                return ZX_IntegerToLabel( i_2, hoisted_1_1, hoisted_2_1, 0 );
            end ), [  ] ) );
end
########
        
    , 100 );
    
    ##
    AddLeftUnitorWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, s_1 )
    local hoisted_1_1, hoisted_2_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := Integer( a_1 ) - 1;
    deduped_4_1 := [ 0 .. deduped_5_1 ];
    hoisted_1_1 := [ BigInt( 0 ) .. deduped_5_1 ];
    hoisted_2_1 := List( [ 0 .. Integer( s_1 ) - 1 ], function ( x_2 )
            return -1 + BigInt( SafePosition( hoisted_1_1, x_2 ) );
        end );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, a_1, VertexLabeledGraph, NTuple( 2, List( deduped_4_1, function ( i_2 )
                return ZX_IntegerToLabel( i_2, hoisted_2_1, deduped_4_1, 0 );
            end ), [  ] ) );
end
########
        
    , 100 );
    
    ##
    AddMorphismConstructor( cat,
        
########
function ( cat_1, arg2_1, arg3_1, arg4_1 )
    return CreateCapCategoryMorphismWithAttributes( cat_1, arg2_1, arg4_1, VertexLabeledGraph, arg3_1 );
end
########
        
    , 100 );
    
    ##
    AddMorphismDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return VertexLabeledGraph( arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddObjectConstructor( cat,
        
########
function ( cat_1, arg2_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Integer, arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddObjectDatum( cat,
        
########
function ( cat_1, arg2_1 )
    return Integer( arg2_1 );
end
########
        
    , 100 );
    
    ##
    AddPreCompose( cat,
        
########
function ( cat_1, alpha_1, beta_1 )
    local deduped_1_1, hoisted_2_1, deduped_3_1, hoisted_4_1, deduped_5_1, deduped_7_1, hoisted_8_1, hoisted_9_1, hoisted_10_1, hoisted_11_1, hoisted_12_1, hoisted_13_1, hoisted_14_1, hoisted_15_1, hoisted_18_1, hoisted_19_1, hoisted_20_1, hoisted_21_1, deduped_22_1, deduped_23_1, deduped_24_1, deduped_25_1, deduped_26_1, deduped_27_1, deduped_28_1, deduped_29_1, deduped_30_1, deduped_31_1, deduped_32_1, deduped_33_1, deduped_34_1, deduped_35_1, deduped_36_1, deduped_37_1, deduped_38_1, deduped_39_1, deduped_40_1, deduped_41_1, deduped_42_1, deduped_43_1, deduped_44_1, deduped_45_1, deduped_46_1, deduped_47_1, deduped_48_1, deduped_49_1, deduped_50_1, deduped_51_1;
    deduped_51_1 := VertexLabeledGraph( beta_1 );
    deduped_50_1 := VertexLabeledGraph( alpha_1 );
    deduped_49_1 := Range( beta_1 );
    deduped_48_1 := Source( alpha_1 );
    deduped_47_1 := deduped_51_1[2];
    deduped_46_1 := deduped_50_1[2];
    deduped_45_1 := Integer( Source( beta_1 ) );
    deduped_44_1 := Integer( Range( alpha_1 ) );
    deduped_43_1 := deduped_51_1[1];
    deduped_42_1 := deduped_50_1[1];
    deduped_41_1 := Length( deduped_47_1 );
    deduped_40_1 := Length( deduped_46_1 );
    deduped_39_1 := Length( deduped_43_1 );
    deduped_38_1 := Length( deduped_42_1 );
    deduped_37_1 := deduped_40_1 + deduped_41_1;
    deduped_36_1 := deduped_38_1 + deduped_39_1;
    deduped_35_1 := RangeCategoryOfHomomorphismStructure( ModelingCategory( UnderlyingCategory( ModelingCategory( cat_1 ) ) ) );
    deduped_34_1 := [ 0 .. deduped_41_1 - 1 ];
    deduped_33_1 := [ 0 .. deduped_40_1 - 1 ];
    deduped_32_1 := deduped_36_1 - 1;
    deduped_31_1 := CreateCapCategoryObjectWithAttributes( deduped_35_1, Length, deduped_37_1 );
    deduped_30_1 := CreateCapCategoryObjectWithAttributes( deduped_35_1, Length, deduped_36_1 );
    deduped_29_1 := [ 0 .. deduped_37_1 - 1 ];
    deduped_28_1 := CreateCapCategoryMorphismWithAttributes( deduped_35_1, CreateCapCategoryObjectWithAttributes( deduped_35_1, Length, 0 ), deduped_31_1, AsList, [  ] );
    deduped_27_1 := SKELETAL_FIN_SETS_ExplicitCoequalizer( deduped_31_1, [ deduped_28_1, deduped_28_1 ] );
    deduped_5_1 := [ deduped_38_1 .. deduped_32_1 ];
    deduped_3_1 := [ "input", "input_output" ];
    hoisted_4_1 := List( PositionsProperty( deduped_43_1, function ( x_2 )
              return x_2 in deduped_3_1;
          end ), function ( p_2 )
            return p_2 - 1;
        end );
    deduped_1_1 := [ "output", "input_output" ];
    hoisted_2_1 := List( PositionsProperty( deduped_42_1, function ( x_2 )
              return x_2 in deduped_1_1;
          end ), function ( p_2 )
            return p_2 - 1;
        end );
    deduped_26_1 := SKELETAL_FIN_SETS_ExplicitCoequalizer( deduped_30_1, [ CreateCapCategoryMorphismWithAttributes( deduped_35_1, CreateCapCategoryObjectWithAttributes( deduped_35_1, Length, deduped_44_1 ), deduped_30_1, AsList, List( [ 0 .. deduped_44_1 - 1 ], function ( i_2 )
                    return hoisted_2_1[1 + i_2];
                end ) ), CreateCapCategoryMorphismWithAttributes( deduped_35_1, CreateCapCategoryObjectWithAttributes( deduped_35_1, Length, deduped_45_1 ), deduped_30_1, AsList, List( [ 0 .. deduped_45_1 - 1 ], function ( i_2 )
                    return deduped_5_1[1 + hoisted_4_1[(1 + i_2)]];
                end ) ) ] );
    deduped_25_1 := Concatenation( List( deduped_33_1, function ( i_2 )
              return CAP_JIT_INCOMPLETE_LOGIC( CAP_JIT_INCOMPLETE_LOGIC( deduped_46_1[1 + i_2] )[2] );
          end ), List( deduped_34_1, function ( i_2 )
              return deduped_5_1[1 + CAP_JIT_INCOMPLETE_LOGIC( CAP_JIT_INCOMPLETE_LOGIC( deduped_47_1[(1 + i_2)] )[2] )];
          end ) );
    deduped_24_1 := Concatenation( List( deduped_33_1, function ( i_2 )
              return CAP_JIT_INCOMPLETE_LOGIC( CAP_JIT_INCOMPLETE_LOGIC( deduped_46_1[1 + i_2] )[1] );
          end ), List( deduped_34_1, function ( i_2 )
              return deduped_5_1[1 + CAP_JIT_INCOMPLETE_LOGIC( CAP_JIT_INCOMPLETE_LOGIC( deduped_47_1[(1 + i_2)] )[1] )];
          end ) );
    deduped_23_1 := BigInt( Length( deduped_26_1 ) );
    deduped_22_1 := CreateCapCategoryObjectWithAttributes( deduped_35_1, Length, deduped_23_1 );
    hoisted_20_1 := ListN( deduped_24_1, deduped_25_1, function ( s_2, t_2 )
            return t_2;
        end );
    deduped_7_1 := List( [ 0 .. deduped_32_1 ], function ( x_2 )
            return -1 + BigInt( SafeUniquePositionProperty( deduped_26_1, function ( c_3 )
                        return (x_2 in c_3);
                    end ) );
        end );
    hoisted_21_1 := CreateCapCategoryMorphismWithAttributes( deduped_35_1, deduped_31_1, deduped_22_1, AsList, List( deduped_29_1, function ( i_2 )
              return deduped_7_1[1 + hoisted_20_1[(1 + i_2)]];
          end ) );
    hoisted_18_1 := ListN( deduped_24_1, deduped_25_1, function ( s_2, t_2 )
            return s_2;
        end );
    hoisted_19_1 := CreateCapCategoryMorphismWithAttributes( deduped_35_1, deduped_31_1, deduped_22_1, AsList, List( deduped_29_1, function ( i_2 )
              return deduped_7_1[1 + hoisted_18_1[(1 + i_2)]];
          end ) );
    hoisted_11_1 := List( [ 0 .. deduped_39_1 - 1 ], function ( i_2 )
            return deduped_7_1[1 + deduped_5_1[(1 + i_2)]];
        end );
    hoisted_10_1 := List( PositionsProperty( deduped_43_1, function ( x_2 )
              return x_2 in deduped_1_1;
          end ), function ( p_2 )
            return p_2 - 1;
        end );
    hoisted_15_1 := List( [ 0 .. Integer( deduped_49_1 ) - 1 ], function ( i_2 )
            return hoisted_11_1[1 + hoisted_10_1[(1 + i_2)]];
        end );
    hoisted_9_1 := List( [ 0 .. deduped_38_1 - 1 ], function ( i_2 )
            return deduped_7_1[1 + i_2];
        end );
    hoisted_8_1 := List( PositionsProperty( deduped_42_1, function ( x_2 )
              return x_2 in deduped_3_1;
          end ), function ( p_2 )
            return p_2 - 1;
        end );
    hoisted_14_1 := List( [ 0 .. Integer( deduped_48_1 ) - 1 ], function ( i_2 )
            return hoisted_9_1[1 + hoisted_8_1[(1 + i_2)]];
        end );
    hoisted_13_1 := Concatenation( List( deduped_42_1, ZX_LabelToInteger ), List( deduped_43_1, ZX_LabelToInteger ) );
    hoisted_12_1 := BigInt( 0 );
    return CreateCapCategoryMorphismWithAttributes( cat_1, deduped_48_1, deduped_49_1, VertexLabeledGraph, NTuple( 2, List( [ 0 .. deduped_23_1 - 1 ], function ( i_2 )
                local deduped_1_2;
                deduped_1_2 := CAP_JIT_INCOMPLETE_LOGIC( i_2 );
                return ZX_IntegerToLabel( i_2, hoisted_14_1, hoisted_15_1, CAP_JIT_INCOMPLETE_LOGIC( IdFunc( function (  )
                              if not deduped_1_2 in deduped_7_1 then
                                  return hoisted_12_1;
                              else
                                  return hoisted_13_1[SafePosition( deduped_7_1, deduped_1_2 )];
                              fi;
                              return;
                          end )(  ) ) );
            end ), ListN( List( deduped_27_1, function ( x_2 )
                  return hoisted_19_1( x_2[1] );
              end ), List( deduped_27_1, function ( x_2 )
                  return hoisted_21_1( x_2[1] );
              end ), function ( s_2, t_2 )
                return NTuple( 2, s_2, t_2 );
            end ) ) );
end
########
        
    , 100 );
    
    ##
    AddRightUnitorInverseWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, r_1 )
    local hoisted_1_1, deduped_3_1;
    deduped_3_1 := [ 0 .. Integer( r_1 ) - 1 ];
    hoisted_1_1 := [ 0 .. Integer( a_1 ) - 1 ];
    return CreateCapCategoryMorphismWithAttributes( cat_1, a_1, r_1, VertexLabeledGraph, NTuple( 2, List( deduped_3_1, function ( i_2 )
                return ZX_IntegerToLabel( i_2, hoisted_1_1, deduped_3_1, 0 );
            end ), [  ] ) );
end
########
        
    , 100 );
    
    ##
    AddRightUnitorWithGivenTensorProduct( cat,
        
########
function ( cat_1, a_1, s_1 )
    local hoisted_2_1, deduped_4_1, deduped_5_1;
    deduped_5_1 := [ 0 .. Integer( s_1 ) - 1 ];
    deduped_4_1 := [ 0 .. Integer( a_1 ) - 1 ];
    hoisted_2_1 := List( deduped_5_1, function ( x_2 )
            return -1 + BigInt( SafePosition( deduped_4_1, x_2 ) );
        end );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, a_1, VertexLabeledGraph, NTuple( 2, List( deduped_4_1, function ( i_2 )
                return ZX_IntegerToLabel( i_2, hoisted_2_1, deduped_5_1, 0 );
            end ), [  ] ) );
end
########
        
    , 100 );
    
    ##
    AddTensorProductOnMorphismsWithGivenTensorProducts( cat,
        
########
function ( cat_1, s_1, alpha_1, beta_1, r_1 )
    local deduped_1_1, hoisted_2_1, hoisted_3_1, deduped_4_1, deduped_5_1, hoisted_6_1, hoisted_7_1, hoisted_8_1, hoisted_9_1, hoisted_10_1, deduped_13_1, deduped_14_1, deduped_15_1, deduped_16_1, deduped_17_1, deduped_18_1, deduped_19_1, deduped_20_1, deduped_21_1, deduped_22_1;
    deduped_22_1 := VertexLabeledGraph( beta_1 );
    deduped_21_1 := VertexLabeledGraph( alpha_1 );
    deduped_20_1 := deduped_22_1[2];
    deduped_19_1 := deduped_21_1[2];
    deduped_18_1 := deduped_22_1[1];
    deduped_17_1 := deduped_21_1[1];
    deduped_16_1 := Length( deduped_17_1 );
    deduped_15_1 := [ 0 .. Length( deduped_20_1 ) - 1 ];
    deduped_14_1 := [ 0 .. Length( deduped_19_1 ) - 1 ];
    deduped_13_1 := deduped_16_1 + Length( deduped_18_1 ) - 1;
    deduped_5_1 := [ "output", "input_output" ];
    hoisted_7_1 := List( PositionsProperty( deduped_18_1, function ( x_2 )
              return x_2 in deduped_5_1;
          end ), function ( p_2 )
            return p_2 - 1;
        end );
    hoisted_6_1 := List( PositionsProperty( deduped_17_1, function ( x_2 )
              return x_2 in deduped_5_1;
          end ), function ( p_2 )
            return p_2 - 1;
        end );
    deduped_4_1 := [ deduped_16_1 .. deduped_13_1 ];
    hoisted_10_1 := Concatenation( List( [ 0 .. Integer( Range( alpha_1 ) ) - 1 ], function ( i_2 )
              return hoisted_6_1[1 + i_2];
          end ), List( [ 0 .. Integer( Range( beta_1 ) ) - 1 ], function ( i_2 )
              return deduped_4_1[1 + hoisted_7_1[(1 + i_2)]];
          end ) );
    deduped_1_1 := [ "input", "input_output" ];
    hoisted_3_1 := List( PositionsProperty( deduped_18_1, function ( x_2 )
              return x_2 in deduped_1_1;
          end ), function ( p_2 )
            return p_2 - 1;
        end );
    hoisted_2_1 := List( PositionsProperty( deduped_17_1, function ( x_2 )
              return x_2 in deduped_1_1;
          end ), function ( p_2 )
            return p_2 - 1;
        end );
    hoisted_9_1 := Concatenation( List( [ 0 .. Integer( Source( alpha_1 ) ) - 1 ], function ( i_2 )
              return hoisted_2_1[1 + i_2];
          end ), List( [ 0 .. Integer( Source( beta_1 ) ) - 1 ], function ( i_2 )
              return deduped_4_1[1 + hoisted_3_1[(1 + i_2)]];
          end ) );
    hoisted_8_1 := Concatenation( List( deduped_17_1, ZX_LabelToInteger ), List( deduped_18_1, ZX_LabelToInteger ) );
    return CreateCapCategoryMorphismWithAttributes( cat_1, s_1, r_1, VertexLabeledGraph, NTuple( 2, List( [ 0 .. deduped_13_1 ], function ( i_2 )
                return ZX_IntegerToLabel( i_2, hoisted_9_1, hoisted_10_1, hoisted_8_1[1 + i_2] );
            end ), ListN( Concatenation( List( deduped_14_1, function ( i_2 )
                    return CAP_JIT_INCOMPLETE_LOGIC( CAP_JIT_INCOMPLETE_LOGIC( deduped_19_1[1 + i_2] )[1] );
                end ), List( deduped_15_1, function ( i_2 )
                    return deduped_4_1[1 + CAP_JIT_INCOMPLETE_LOGIC( CAP_JIT_INCOMPLETE_LOGIC( deduped_20_1[(1 + i_2)] )[1] )];
                end ) ), Concatenation( List( deduped_14_1, function ( i_2 )
                    return CAP_JIT_INCOMPLETE_LOGIC( CAP_JIT_INCOMPLETE_LOGIC( deduped_19_1[1 + i_2] )[2] );
                end ), List( deduped_15_1, function ( i_2 )
                    return deduped_4_1[1 + CAP_JIT_INCOMPLETE_LOGIC( CAP_JIT_INCOMPLETE_LOGIC( deduped_20_1[(1 + i_2)] )[2] )];
                end ) ), function ( s_2, t_2 )
                return NTuple( 2, s_2, t_2 );
            end ) ) );
end
########
        
    , 100 );
    
    ##
    AddTensorProductOnObjects( cat,
        
########
function ( cat_1, arg2_1, arg3_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Integer, Integer( arg2_1 ) + Integer( arg3_1 ) );
end
########
        
    , 100 );
    
    ##
    AddTensorUnit( cat,
        
########
function ( cat_1 )
    return CreateCapCategoryObjectWithAttributes( cat_1, Integer, BigInt( 0 ) );
end
########
        
    , 100 );
    
    if IsBound( cat!.precompiled_functions_added ) then
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "precompiled functions have already been added before" );
        
    fi;
    
    cat!.precompiled_functions_added := true;
    
end );

BindGlobal( "CategoryOfZXDiagrams_as_CategoryOfCospans_CategoryOfDecoratedQuivers_precompiled", function (  )
  local category_constructor, cat;
    
    category_constructor :=
        
        
        function (  )
    return CategoryOfZXDiagrams_as_CategoryOfCospans_CategoryOfDecoratedQuivers(  );
end;
        
        
    
    cat := category_constructor(  : FinalizeCategory := false, no_precompiled_code := true );
    
    ADD_FUNCTIONS_FOR_CategoryOfZXDiagrams_as_CategoryOfCospans_CategoryOfDecoratedQuivers_precompiled( cat );
    
    Finalize( cat );
    
    return cat;
    
end );
