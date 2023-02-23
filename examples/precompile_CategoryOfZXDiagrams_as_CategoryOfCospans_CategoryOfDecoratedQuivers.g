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

category_constructor := { } ->
    CategoryOfZXDiagrams_as_CategoryOfCospans_CategoryOfDecoratedQuivers( );;
given_arguments := [ ];;
compiled_category_name := Concatenation(
    "CategoryOfZXDiagrams_as_CategoryOfCospans_CategoryOfDecoratedQuivers",
    "_precompiled"
);;
package_name := "ZXCalculusForCAP";;

CapJitPrecompileCategoryAndCompareResult(
    category_constructor,
    given_arguments,
    package_name,
    compiled_category_name :
    operations := "primitive"
);;

# @EndExample
