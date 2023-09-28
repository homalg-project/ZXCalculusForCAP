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
  [ ]
  and 0 edges
  [ ].
gap> Display( PreCompose( ev, coev ) );
A morphism in Category of ZX-diagrams given by a ZX diagram with 12 vertex lab\
els
  [ "input", "input", "input", "input", "input", "input", "output", "output", \
"output", "output", "output", "output" ]
  and 6 edges
  [ [ 0, 5 ], [ 1, 4 ], [ 2, 3 ], [ 6, 11 ], [ 7, 10 ], [ 8, 9 ] ].

#
gap> X_1_1 := MorphismConstructor( one, [ [ "input", "X", "output" ], [ [ BigInt( 0 ), BigInt( 1 ) ], [ BigInt( 1 ), BigInt( 2 ) ] ] ], one );;
gap> IsWellDefinedForMorphisms( X_1_1 );
true

#
gap> Z_1_1 := MorphismConstructor( one, [ [ "input", "Z", "output" ], [ [ BigInt( 0 ), BigInt( 1 ) ], [ BigInt( 1 ), BigInt( 2 ) ] ] ], one );;
gap> IsWellDefinedForMorphisms( Z_1_1 );
true

#
gap> H := MorphismConstructor( one, [ [ "input", "H", "output" ], [ [ BigInt( 0 ), BigInt( 1 ) ], [ BigInt( 1 ), BigInt( 2 ) ] ] ], one );;
gap> IsWellDefinedForMorphisms( H );
true

#
gap> STOP_TEST( "CategoryOfZXDiagrams" );
