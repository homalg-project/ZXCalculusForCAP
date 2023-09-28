gap> START_TEST( "CategoryOfZXDiagrams_export" );

#
# test ExportAsQGraph
gap> tmp_dir := DirectoryTemporary( );;
gap> ExportAsQGraph( id, Filename( tmp_dir, "id" ) );
gap> ExportAsQGraph( ev, Filename( tmp_dir, "ev" ) );
gap> ExportAsQGraph( coev, Filename( tmp_dir, "coev" ) );
gap> ExportAsQGraph( X_1_1, Filename( tmp_dir, "X_1_1" ) );
gap> ExportAsQGraph( Z_1_1, Filename( tmp_dir, "Z_1_1" ) );
gap> ExportAsQGraph( H, Filename( tmp_dir, "H" ) );
gap> ExportAsQGraph( PreCompose( X_1_2, Z_2_1 ), Filename( tmp_dir, "X_1_2_Z_2_1" ) );

#
gap> STOP_TEST( "CategoryOfZXDiagrams_export" );
