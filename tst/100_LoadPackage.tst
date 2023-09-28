# SPDX-License-Identifier: GPL-2.0-or-later
# ZXCalculusForCAP: The category of ZX-diagrams
#
# This file tests if the package can be loaded without errors or warnings.
#
# do not load suggested dependencies automatically
gap> PushOptions( rec( OnlyNeeded := true ) );
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "Toposes", false );
true
gap> LoadPackage( "FreydCategoriesForCAP", false );
true
gap> LoadPackage( "FunctorCategories", false );
true
gap> LoadPackage( "json", false );
true
gap> LoadPackage( "ZXCalculusForCAP", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "Toposes" );
true
gap> LoadPackage( "FreydCategoriesForCAP" );
true
gap> LoadPackage( "FunctorCategories" );
true
gap> LoadPackage( "json" );
true
gap> LoadPackage( "ZXCalculusForCAP" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
