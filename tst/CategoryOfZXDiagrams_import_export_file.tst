gap> START_TEST( "CategoryOfZXDiagrams_import_export_file" );

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
gap> STOP_TEST( "CategoryOfZXDiagrams_import_export_file" );
