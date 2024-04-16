gap> START_TEST( "CategoryOfZXDiagrams_export" );

#
# test ExportAsQGraphFile
gap> tmp_dir := DirectoryTemporary( );;
gap> ExportAsQGraphFile( id, Filename( tmp_dir, "id" ) );
gap> ExportAsQGraphFile( ev, Filename( tmp_dir, "ev" ) );
gap> ExportAsQGraphFile( coev, Filename( tmp_dir, "coev" ) );
gap> ExportAsQGraphFile( X_1_1, Filename( tmp_dir, "X_1_1" ) );
gap> ExportAsQGraphFile( Z_1_1, Filename( tmp_dir, "Z_1_1" ) );
gap> ExportAsQGraphFile( H, Filename( tmp_dir, "H" ) );
gap> ExportAsQGraphFile( PreCompose( X_1_2, Z_2_1 ), Filename( tmp_dir, "X_1_2_Z_2_1" ) );

#
gap> STOP_TEST( "CategoryOfZXDiagrams_export" );
