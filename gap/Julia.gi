# SPDX-License-Identifier: GPL-2.0-or-later
# ZXCalculusForCAP: The category of ZX-diagrams
#
# Implementations
#

# this can automatically be handled by CAP once CategoryConstructor supports CreateCapCategoryWithDataTypes

InstallOtherMethod( MorphismConstructor,
                    [ ObjectFilter( ZX ), IsJuliaObject, ObjectFilter( ZX ) ],
                    
  function ( source, julia_list, range )
    
    return MorphismConstructor( source, ConvertJuliaToGAP( julia_list ), range );
    
end );

InstallOtherMethod( MorphismConstructor,
                    [ CategoryFilter( ZX ), ObjectFilter( ZX ), IsJuliaObject, ObjectFilter( ZX ) ],
                    
  function ( cat, source, julia_list, range )
    
    return MorphismConstructor( cat, source, ConvertJuliaToGAP( julia_list ), range );
    
end );
