# SPDX-License-Identifier: GPL-2.0-or-later
# ZXCalculusForCAP: The category of ZX-diagrams
#
# Reading the implementation part of the package.
#

ReadPackage( "ZXCalculusForCAP", "gap/CategoryOfCospans_for_ZXCalculus.gi" );

ReadPackage( "ZXCalculusForCAP", "gap/precompiled_categories/CategoryOfZXDiagrams_precompiled.gi" );

ReadPackage( "ZXCalculusForCAP", "gap/CategoryOfZXDiagrams.gi" );

#= comment for Julia
if IsPackageMarkedForLoading( "FunctorCategories", ">= 2023.07-01" ) then
    
    ReadPackage( "ZXCalculusForCAP", "gap/CategoryOfZXDiagrams_as_CategoryOfCospans_CategoryOfDecoratedQuivers.gi" );
    
fi;
# =#

ReadPackage( "ZXCalculusForCAP", "gap/init.gi" );
