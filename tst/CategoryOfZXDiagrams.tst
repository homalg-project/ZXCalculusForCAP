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
gap> Display( three );
An object in Category of ZX-diagrams representing 3 input/output vertices.

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
gap> IsEqualForMorphisms( TensorProductOnMorphisms( IdentityMorphism( one ), IdentityMorphism( two ) ), IdentityMorphism( three ) );
true

#
gap> IsEqualForMorphisms( AssociatorLeftToRight( zero, one, two ), IdentityMorphism( three ) );
true

#
gap> IsEqualForMorphisms( AssociatorRightToLeft( zero, one, two ), IdentityMorphism( three ) );
true

#
gap> IsEqualForMorphisms( LeftUnitor( three ), IdentityMorphism( three ) );
true

#
gap> IsEqualForMorphisms( LeftUnitorInverse( three ), IdentityMorphism( three ) );
true

#
gap> IsEqualForMorphisms( RightUnitor( three ), IdentityMorphism( three ) );
true

#
gap> IsEqualForMorphisms( RightUnitorInverse( three ), IdentityMorphism( three ) );
true

#
gap> IsEqualForMorphisms( Braiding( one, two ), BraidingInverse( two, one ) );
true

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
# due to reordering during import/export, we have to make some roundtrips
# until import/export is stable
gap> test_inverse := function( mor0 )
>      local json, mor1, json2, mor2, json3, mor3;
>        json := ExportAsQGraphString( mor0 );
>        mor1 := ImportFromQGraphString( ZX, json );
>        json2 := ExportAsQGraphString( mor1 );
>        mor2 := ImportFromQGraphString( ZX, json2 );
>        json3 := ExportAsQGraphString( mor2 );
>        mor3 := ImportFromQGraphString( ZX, json3 );
>        return IsEqualForMorphisms( mor2, mor3 ) and json2 = json3;
>    end;;

#
gap> test_inverse( id );
true
gap> test_inverse( ev );
true
gap> test_inverse( coev );
true
gap> test_inverse( X_1_1 );
true
gap> test_inverse( Z_1_1 );
true
gap> test_inverse( H );
true
gap> test_inverse( X_1_2 );
true
gap> test_inverse( Z_2_1 );
true
gap> test_inverse( X_1_2_Z_2_1 );
true

#
# The following JSON is obtained from PyZX and encoded in Base64 to avoid conversion errors to Julia.
# It contains a non-zero phase of an X-spider and hence enhances S_ZX_EDGES dynamically. This only works when using the precompiled code.
# """{"wire_vertices": {"b0": {"annotation": {"boundary": true, "coord": [-3.75, 4.75], "input": 0}}, "b1": {"annotation": {"boundary": true, "coord": [-3.75, 2.75], "input": 1}}, "b2": {"annotation": {"boundary": true, "coord": [0.75, 4.75], "output": 0}}, "b3": {"annotation": {"boundary": true, "coord": [0.75, 2.75], "output": 1}}}, "node_vertices": {"v0": {"annotation": {"coord": [-2.25, 4.75]}, "data": {"type": "X"}}, "v1": {"annotation": {"coord": [-0.5, 2.75]}, "data": {"type": "X", "value": "\u03c0"}}, "v2": {"annotation": {"coord": [-2.25, 2.75]}, "data": {"type": "Z"}}}, "undir_edges": {"e0": {"src": "b0", "tgt": "v0"}, "e1": {"src": "b1", "tgt": "v2"}, "e2": {"src": "b2", "tgt": "v0"}, "e3": {"src": "b3", "tgt": "v1"}, "e4": {"src": "v0", "tgt": "v2"}, "e5": {"src": "v1", "tgt": "v2"}}}"""
#@if ValueOption( "no_precompiled_code" ) <> true
gap> succ_mod_4 := ImportFromQGraphString( ZX, StringBase64( "eyJ3aXJlX3ZlcnRpY2VzIjogeyJiMCI6IHsiYW5ub3RhdGlvbiI6IHsiYm91bmRhcnkiOiB0cnVlLCAiY29vcmQiOiBbLTMuNzUsIDQuNzVdLCAiaW5wdXQiOiAwfX0sICJiMSI6IHsiYW5ub3RhdGlvbiI6IHsiYm91bmRhcnkiOiB0cnVlLCAiY29vcmQiOiBbLTMuNzUsIDIuNzVdLCAiaW5wdXQiOiAxfX0sICJiMiI6IHsiYW5ub3RhdGlvbiI6IHsiYm91bmRhcnkiOiB0cnVlLCAiY29vcmQiOiBbMC43NSwgNC43NV0sICJvdXRwdXQiOiAwfX0sICJiMyI6IHsiYW5ub3RhdGlvbiI6IHsiYm91bmRhcnkiOiB0cnVlLCAiY29vcmQiOiBbMC43NSwgMi43NV0sICJvdXRwdXQiOiAxfX19LCAibm9kZV92ZXJ0aWNlcyI6IHsidjAiOiB7ImFubm90YXRpb24iOiB7ImNvb3JkIjogWy0yLjI1LCA0Ljc1XX0sICJkYXRhIjogeyJ0eXBlIjogIlgifX0sICJ2MSI6IHsiYW5ub3RhdGlvbiI6IHsiY29vcmQiOiBbLTAuNSwgMi43NV19LCAiZGF0YSI6IHsidHlwZSI6ICJYIiwgInZhbHVlIjogIs+AIn19LCAidjIiOiB7ImFubm90YXRpb24iOiB7ImNvb3JkIjogWy0yLjI1LCAyLjc1XX0sICJkYXRhIjogeyJ0eXBlIjogIloifX19LCAidW5kaXJfZWRnZXMiOiB7ImUwIjogeyJzcmMiOiAiYjAiLCAidGd0IjogInYwIn0sICJlMSI6IHsic3JjIjogImIxIiwgInRndCI6ICJ2MiJ9LCAiZTIiOiB7InNyYyI6ICJiMiIsICJ0Z3QiOiAidjAifSwgImUzIjogeyJzcmMiOiAiYjMiLCAidGd0IjogInYxIn0sICJlNCI6IHsic3JjIjogInYwIiwgInRndCI6ICJ2MiJ9LCAiZTUiOiB7InNyYyI6ICJ2MSIsICJ0Z3QiOiAidjIifX19" ) );;
gap> test_inverse( succ_mod_4 );
true
#@fi

#
gap> STOP_TEST( "CategoryOfZXDiagrams" );
