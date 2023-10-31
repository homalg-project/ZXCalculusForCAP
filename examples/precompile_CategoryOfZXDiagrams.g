# @Chapter Examples and tests

# @Section Examples

# @Example

LoadPackage( "ZXCalculusForCAP", false );
# true

ReadPackageOnce( "FinSetsForCAP", "gap/CompilerLogic.gi" );
# true

ReadPackageOnce( "Algebroids", "gap/CompilerLogic.gi" );
# true

ReadPackageOnce( "FunctorCategories", "gap/CompilerLogic.gi" );
# true

#ReadPackage( "ZXCalculusForCAP", "gap/CompilerLogic.gi" );
# true

CapJitAddTypeSignature( "CoproductFunctorial", [ IsCapCategory, IsList ], function ( input_types )
  local category;
    
    category := input_types[1].category;
    
    Assert( 0, IsSpecializationOfFilter( MorphismFilter( category ), input_types[2].element_type.filter ) );
    
    return CapJitDataTypeOfMorphismOfCategory( category );
    
end );

CapJitAddTypeSignature( "CAP_JIT_INCOMPLETE_LOGIC", [ IsObject ], function ( input_types )
    
    return input_types[1];
    
end );

##
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "value" ],
        src_template := "CAP_JIT_INCOMPLETE_LOGIC( value )",
        dst_template := "value",
    )
);

##
CapJitAddLogicTemplate(
    rec(
        variable_names := [ ],
        src_template := "ZX_IntegerToLabel( BigInt( 0 ) )",
        dst_template := "\"neutral\"",
    )
);

##
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "label" ],
        src_template := "ZX_IntegerToLabel( ZX_LabelToInteger( label ) )",
        dst_template := "label",
    )
);

##
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "func" ],
        src_template := "ForAll( [ ], func )",
        dst_template := "true",
    )
);

##
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "s", "D" ],
        src_template := "SKELETAL_FIN_SETS_ExplicitCoequalizer( s, D )",
        dst_template := "SKELETAL_FIN_SETS_ExplicitCoequalizer_primitive_input( Length( s ), List( D, x -> Triple( Length( Source( x ) ), AsList( x ), Length( Range( x ) ) ) ) )",
        new_funcs := [ [ "x" ] ],
    )
);

##
CapJitAddLogicTemplate(
    rec(
        variable_names := [ "entry" ],
        src_template := "ListWithIdenticalEntries( 2, entry )",
        dst_template := "[ entry, entry ]",
    )
);

category_constructor := { } -> CategoryOfZXDiagrams( );;
given_arguments := [ ];;
compiled_category_name := "CategoryOfZXDiagrams_precompiled";;
package_name := "ZXCalculusForCAP";;

CapJitPrecompileCategoryAndCompareResult(
    category_constructor,
    given_arguments,
    package_name,
    compiled_category_name :
    operations := "primitive",
    number_of_objectified_objects_in_data_structure_of_object := 1,
    number_of_objectified_morphisms_in_data_structure_of_object := 0,
    number_of_objectified_objects_in_data_structure_of_morphism := 2,
    number_of_objectified_morphisms_in_data_structure_of_morphism := 1
);;

# @EndExample
