# SPDX-License-Identifier: GPL-2.0-or-later
# ZXCalculusForCAP: The category of ZX-diagrams
#
# Reading the implementation part of the package.
#

ReadPackage( "ZXCalculusForCAP", "gap/CategoryOfCospans_for_ZXCalculus.gi" );

ReadPackage( "ZXCalculusForCAP", "gap/precompiled_categories/CategoryOfZXDiagrams_as_CategoryOfCospans_CategoryOfDecoratedQuivers_precompiled.gi" );

ReadPackage( "ZXCalculusForCAP", "gap/CategoryOfZXDiagrams_as_CategoryOfCospans_CategoryOfDecoratedQuivers.gi" );

#= comment for Julia
if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    # COVERAGE_IGNORE_NEXT_LINE
    ReadPackage( "ZXCalculusForCAP", "gap/Julia.gi" );
fi;
# =#
