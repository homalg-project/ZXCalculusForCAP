gap> START_TEST( "CategoryOfZXDiagrams" );

#
gap> LoadPackage( "ZXCalculusForCAP", false );
true

#
gap> zero := ObjectConstructor( ZX, BigInt( 0 ) );
<An object in Category of ZX-diagrams representing 0 input/output vertices>
gap> one := ObjectConstructor( ZX, BigInt( 1 ) );
<An object in Category of ZX-diagrams representing 1 input/output vertices>
gap> two := ObjectConstructor( ZX, BigInt( 2 ) );
<An object in Category of ZX-diagrams representing 2 input/output vertices>
gap> three := ObjectConstructor( ZX, BigInt( 3 ) );
<An object in Category of ZX-diagrams representing 3 input/output vertices>

#
gap> id := IdentityMorphism( three );;

#
gap> ev := EvaluationForDual( three );;
gap> coev := CoevaluationForDual( three );;

#
gap> PreCompose( ev, IdentityMorphism( zero ) );;
gap> PreCompose( IdentityMorphism( TensorProduct( three, three ) ), ev );;

#
gap> PreCompose( coev, IdentityMorphism( TensorProduct( three, three ) ) );;
gap> PreCompose( IdentityMorphism( zero ), coev );;

#
gap> Display( PreCompose( coev, ev ) );
A morphism in Category of ZX-diagrams given by a ZX diagram with 0 vertex labe\
ls
  [  ],
  inputs
  [  ],
  outputs
  [  ],
  and 0 edges
  [  ].
gap> Display( PreCompose( ev, coev ) );
A morphism in Category of ZX-diagrams given by a ZX diagram with 6 vertex labe\
ls
  [ "neutral", "neutral", "neutral", "neutral", "neutral", "neutral" ],
  inputs
  [ 0, 1, 2, 0, 1, 2 ],
  outputs
  [ 3, 4, 5, 3, 4, 5 ],
  and 0 edges
  [  ].

#
gap> X_1_1 := MorphismConstructor( one, [ [ "neutral", "X", "neutral" ], [ BigInt( 0 ) ], [ BigInt( 2 ) ], [ [ BigInt( 0 ), BigInt( 1 ) ], [ BigInt( 2 ), BigInt( 1 ) ] ] ], one );;
gap> IsWellDefinedForMorphisms( X_1_1 );
true

#
gap> Z_1_1 := MorphismConstructor( one, [ [ "neutral", "Z", "neutral" ], [ BigInt( 0 ) ], [ BigInt( 2 ) ], [ [ BigInt( 0 ), BigInt( 1 ) ], [ BigInt( 2 ), BigInt( 1 ) ] ] ], one );;
gap> IsWellDefinedForMorphisms( Z_1_1 );
true

#
gap> H := MorphismConstructor( one, [ [ "neutral", "H", "neutral" ], [ BigInt( 0 ) ], [ BigInt( 2 ) ], [ [ BigInt( 0 ), BigInt( 1 ) ], [ BigInt( 2 ), BigInt( 1 ) ] ] ], one );;
gap> IsWellDefinedForMorphisms( H );
true

#
gap> X_1_2 := MorphismConstructor( one, [ [ "neutral", "X", "neutral", "neutral" ], [ BigInt( 0 ) ], [ BigInt( 2 ), BigInt( 3 ) ], [ [ BigInt( 0 ), BigInt( 1 ) ], [ BigInt( 2 ), BigInt( 1 ) ], [ BigInt( 3 ), BigInt( 1 ) ] ] ], two );;
gap> IsWellDefinedForMorphisms( X_1_2 );
true

#
gap> Z_2_1 := MorphismConstructor( two, [ [ "neutral", "neutral", "Z", "neutral" ], [ BigInt( 0 ), BigInt( 1 ) ], [ BigInt( 3 ) ], [ [ BigInt( 0 ), BigInt( 2 ) ], [ BigInt( 1 ), BigInt( 2 ) ], [ BigInt( 3 ), BigInt( 2 ) ] ] ], one );;
gap> IsWellDefinedForMorphisms( Z_2_1 );
true

#
gap> X_1_2_Z_2_1 := PreCompose( X_1_2, Z_2_1 );;
gap> IsWellDefinedForMorphisms( X_1_2_Z_2_1 );
true

#
gap> tmp_dir := DirectoryTemporary( );;

#
# test ExportAsQGraphFile
gap> ExportAsQGraphFile( id, Filename( tmp_dir, "id" ) );
gap> ExportAsQGraphFile( ev, Filename( tmp_dir, "ev" ) );
gap> ExportAsQGraphFile( coev, Filename( tmp_dir, "coev" ) );
gap> ExportAsQGraphFile( X_1_1, Filename( tmp_dir, "X_1_1" ) );
gap> ExportAsQGraphFile( Z_1_1, Filename( tmp_dir, "Z_1_1" ) );
gap> ExportAsQGraphFile( H, Filename( tmp_dir, "H" ) );
gap> ExportAsQGraphFile( X_1_2, Filename( tmp_dir, "X_1_2" ) );
gap> ExportAsQGraphFile( Z_2_1, Filename( tmp_dir, "Z_2_1" ) );
gap> ExportAsQGraphFile( X_1_2_Z_2_1, Filename( tmp_dir, "X_1_2_Z_2_1" ) );

#
# test ImportFromQGraphFile
gap> ImportFromQGraphFile( ZX, Filename( tmp_dir, "id" ) );;
gap> ImportFromQGraphFile( ZX, Filename( tmp_dir, "ev" ) );;
gap> ImportFromQGraphFile( ZX, Filename( tmp_dir, "coev" ) );;
gap> ImportFromQGraphFile( ZX, Filename( tmp_dir, "X_1_1" ) );;
gap> ImportFromQGraphFile( ZX, Filename( tmp_dir, "Z_1_1" ) );;
gap> ImportFromQGraphFile( ZX, Filename( tmp_dir, "H" ) );;
gap> ImportFromQGraphFile( ZX, Filename( tmp_dir, "X_1_2" ) );;
gap> ImportFromQGraphFile( ZX, Filename( tmp_dir, "Z_2_1" ) );;
gap> ImportFromQGraphFile( ZX, Filename( tmp_dir, "X_1_2_Z_2_1" ) );;

#
gap> json_id := ExportAsQGraphString( id );;
gap> json_ev := ExportAsQGraphString( ev );;
gap> json_coev := ExportAsQGraphString( coev );;
gap> json_X_1_1 := ExportAsQGraphString( X_1_1 );;
gap> json_Z_1_1 := ExportAsQGraphString( Z_1_1 );;
gap> json_H := ExportAsQGraphString( H );;
gap> json_X_1_2 := ExportAsQGraphString( X_1_2 );;
gap> json_Z_2_1 := ExportAsQGraphString( Z_2_1 );;
gap> json_X_1_2_Z_2_1 := ExportAsQGraphString( X_1_2_Z_2_1 );;

#
# due to reordering during import/export, we have to make some roundtrips
# until import/export is stable
gap> test_inverse := function( json )
>      local mor, json2, mor2, json3, mor3;
>        mor := ImportFromQGraphString( ZX, json );
>        json2 := ExportAsQGraphString( mor );
>        mor2 := ImportFromQGraphString( ZX, json2 );
>        json3 := ExportAsQGraphString( mor2 );
>        mor3 := ImportFromQGraphString( ZX, json3 );
>        return IsEqualForMorphisms( mor2, mor3 ) and json2 = json3;
>    end;;

#
gap> test_inverse( json_id );
true
gap> test_inverse( json_ev );
true
gap> test_inverse( json_coev );
true
gap> test_inverse( json_X_1_1 );
true
gap> test_inverse( json_Z_1_1 );
true
gap> test_inverse( json_H );
true
gap> test_inverse( json_X_1_2 );
true
gap> test_inverse( json_Z_2_1 );
true
gap> test_inverse( json_X_1_2_Z_2_1 );
true

#
gap> STOP_TEST( "CategoryOfZXDiagrams" );
