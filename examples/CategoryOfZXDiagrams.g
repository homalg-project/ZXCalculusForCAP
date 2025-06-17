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

id := IdentityMorphism( three );
#! <An identity morphism in CategoryOfZXDiagrams( )>
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

IdentityMorphism( one ) + IdentityMorphism( two ) = IdentityMorphism( three );
#! true

AssociatorLeftToRight( zero, one, two ) = IdentityMorphism( three );
#! true

AssociatorRightToLeft( zero, one, two ) = IdentityMorphism( three );
#! true

LeftUnitor( three ) = IdentityMorphism( three );
#! true

LeftUnitorInverse( three ) = IdentityMorphism( three );
#! true

RightUnitor( three ) = IdentityMorphism( three );
#! true

RightUnitorInverse( three ) = IdentityMorphism( three );
#! true

Braiding( one, two ) = BraidingInverse( two, one );
#! true

#
X_1_1 := X_Spider( 1, 1 );
#! <A morphism in CategoryOfZXDiagrams( )>
IsWellDefinedForMorphisms( X_1_1 );
#! true

Z_1_1 := Z_Spider( 1, 1 );
#! <A morphism in CategoryOfZXDiagrams( )>
IsWellDefinedForMorphisms( Z_1_1 );
#! true

H := H_Gate( );
#! <A morphism in CategoryOfZXDiagrams( )>
IsWellDefinedForMorphisms( H );
#! true

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

#! @EndExample
