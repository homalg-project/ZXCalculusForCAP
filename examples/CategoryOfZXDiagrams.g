#! @Chapter The category of ZX-diagrams
#! @Section Example

#! @Example

LoadPackage( "ZXCalculusForCAP", false );
#! true

ZX;
#! CategoryOfZXDiagrams( )

zero := Qubits( 0 );
#! <An object in CategoryOfZXDiagrams( ) representing 0 input/output vertices>
one := Qubits( 1 );
#! <An object in CategoryOfZXDiagrams( ) representing 1 input/output vertices>
two := Qubits( 2 );
#! <An object in CategoryOfZXDiagrams( ) representing 2 input/output vertices>
three := Qubits( 3 );
#! <An object in CategoryOfZXDiagrams( ) representing 3 input/output vertices>

three = one + two;
#! true
three = zero + three;
#! true
three = 3 * one;
#! true

id := IdentityMorphism( one );
#! <An identity morphism in CategoryOfZXDiagrams( )>
id3 := IdentityMorphism( three );
#! <An identity morphism in CategoryOfZXDiagrams( )>
id3 = 3 * id;
#! true
ev := EvaluationForDual( three );
#! <A morphism in CategoryOfZXDiagrams( )>
coev := CoevaluationForDual( three );
#! <A morphism in CategoryOfZXDiagrams( )>

PreCompose( ev, IdentityMorphism( zero ) );
#! <A morphism in CategoryOfZXDiagrams( )>
PreCompose( IdentityMorphism( TensorProduct( three, three ) ), ev );
#! <A morphism in CategoryOfZXDiagrams( )>

PreCompose( coev, IdentityMorphism( TensorProduct( three, three ) ) );
#! <A morphism in CategoryOfZXDiagrams( )>
PreCompose( IdentityMorphism( zero ), coev );
#! <A morphism in CategoryOfZXDiagrams( )>

Display( PreCompose( coev, ev ) );
#! A morphism in CategoryOfZXDiagrams( ) given by a ZX-diagram \
#! with 0 vertex labels
#!   [  ],
#!   inputs
#!   [  ],
#!   outputs
#!   [  ],
#!   and 0 edges
#!   [  ].
Display( PreCompose( ev, coev ) );
#! A morphism in CategoryOfZXDiagrams( ) given by a ZX-diagram \
#! with 6 vertex labels
#!   [ "neutral", "neutral", "neutral", "neutral", "neutral", "neutral" ],
#!   inputs
#!   [ 0, 1, 2, 0, 1, 2 ],
#!   outputs
#!   [ 3, 4, 5, 3, 4, 5 ],
#!   and 0 edges
#!   [  ].

IdentityMorphism( one ) + IdentityMorphism( two ) = id3;
#! true

AssociatorLeftToRight( zero, one, two ) = id3;
#! true

AssociatorRightToLeft( zero, one, two ) = id3;
#! true

LeftUnitor( three ) = id3;
#! true

LeftUnitorInverse( three ) = id3;
#! true

RightUnitor( three ) = id3;
#! true

RightUnitorInverse( three ) = id3;
#! true

Braiding( one, two ) = BraidingInverse( two, one );
#! true

X_1_1 := X_Spider( 1, 1 );
#! <A morphism in CategoryOfZXDiagrams( )>
IsWellDefined( X_1_1 );
#! true

Z_1_1 := Z_Spider( 1, 1 );
#! <A morphism in CategoryOfZXDiagrams( )>
IsWellDefined( Z_1_1 );
#! true

H := H_Gate( );
#! <A morphism in CategoryOfZXDiagrams( )>
IsWellDefined( H );
#! true

X_1_2 := X_Spider( 1, 2 );
#! <A morphism in CategoryOfZXDiagrams( )>
IsWellDefined( X_1_2 );
#! true

Z_2_1 := Z_Spider( 2, 1 );
#! <A morphism in CategoryOfZXDiagrams( )>
IsWellDefined( Z_2_1 );
#! true

X_1_2_Z_2_1 := PreCompose( X_1_2, Z_2_1 );
#! <A morphism in CategoryOfZXDiagrams( )>
IsWellDefined( X_1_2_Z_2_1 );
#! true

GHZ := ( 3 * X_Spider( 0, 1 ) ) * ( id + H + id ) *
       ( X_1_2 + Z_Spider( 1, 1 ) + X_1_2 ) *
       ( id + Z_Spider( 3, 1 ) + id );
#! <A morphism in CategoryOfZXDiagrams( )>
IsWellDefined( GHZ );
#! true

#! @EndExample
