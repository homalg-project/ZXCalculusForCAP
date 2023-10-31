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
  [ ],
  inputs
  [ ],
  outputs
  [ ],
  and 0 edges
  [ ].
gap> Display( PreCompose( ev, coev ) );
A morphism in Category of ZX-diagrams given by a ZX diagram with 6 vertex labe\
ls
  [ "neutral", "neutral", "neutral", "neutral", "neutral", "neutral" ],
  inputs
  [ 0, 1, 2, 0, 1, 2 ],
  outputs
  [ 3, 4, 5, 3, 4, 5 ],
  and 0 edges
  [ ].

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
gap> STOP_TEST( "CategoryOfZXDiagrams" );
