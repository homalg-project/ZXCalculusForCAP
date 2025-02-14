#! @Chapter Precompilation

#! @Section Precompiling the category of ZX-diagrams

#! @Example

#! #@if ValueOption( "no_precompiled_code" ) <> true and _gap_old_formatting

LoadPackage( "ZXCalculusForCAP", false );
#! true

ReadPackageOnce( "FinSetsForCAP", "gap/CompilerLogic.gi" );
#! true

ReadPackageOnce( "Algebroids", "gap/CompilerLogic.gi" );
#! true

ReadPackageOnce( "FunctorCategories", "gap/CompilerLogic.gi" );
#! true

ReadPackageOnce( "ZXCalculusForCAP", "gap/CompilerLogic.gi" );
#! true

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

CategoryOfZXDiagrams_precompiled( );
#! Category of ZX-diagrams

cat := CategoryOfZXDiagrams( );
#! Category of ZX-diagrams

cat!.precompiled_functions_added;
#! true

#! #@fi

#! @EndExample
