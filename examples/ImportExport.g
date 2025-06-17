#! @Chapter Tools
#! @Section Example

#! Test ExportAsQGraphFile and ImportFromQGraphFile.
#! Due to reordering during import/export, we have to make some roundtrips
#! until import/export is stable.

#! @Example
LoadPackage( "ZXCalculusForCAP", false );
#! true

ZX;
#! CategoryOfZXDiagrams( )

X_1_2 := X_Spider( 1, 2 );
#! <A morphism in CategoryOfZXDiagrams( )>
IsWellDefinedForMorphisms( X_1_2 );
#! true

Z_2_1 := Z_Spider( 2, 1 );
#! <A morphism in CategoryOfZXDiagrams( )>
IsWellDefinedForMorphisms( Z_2_1 );
#! true

X_1_2_Z_2_1 := PreCompose( X_1_2, Z_2_1 );
#! <A morphism in CategoryOfZXDiagrams( )>
IsWellDefinedForMorphisms( X_1_2_Z_2_1 );
#! true

#
tmp_dir := DirectoryTemporary( );;
ExportAsQGraphFile( X_1_2_Z_2_1, Filename( tmp_dir, "X_1_2_Z_2_1" ) );
reimported := ImportFromQGraphFile( ZX, Filename( tmp_dir, "X_1_2_Z_2_1" ) );
#! <A morphism in CategoryOfZXDiagrams( )>
IsWellDefinedForMorphisms( reimported );
#! true


json := ExportAsQGraphString( X_1_2_Z_2_1 );;
mor1 := ImportFromQGraphString( ZX, json );;
json2 := ExportAsQGraphString( mor1 );;
mor2 := ImportFromQGraphString( ZX, json2 );;
json3 := ExportAsQGraphString( mor2 );;
mor3 := ImportFromQGraphString( ZX, json3 );;

IsEqualForMorphisms( mor2, mor3 ) and json2 = json3;
#! true

#! @EndExample
