# SPDX-License-Identifier: GPL-2.0-or-later
# ZXCalculusForCAP: The category of ZX-diagrams
#
# Declarations
#
#! @Chapter Tools

#! @Section Exporting ZX-diagrams

#! @Description
#!   Takes a morphism in a category of ZX-diagrams and a filename **file**
#!   and exports the morphism as **file**.qgraph.
#!   This function is only available if the package `json` is available.
#!   See https://github.com/Quantomatic/quantomatic/blob/stable/docs/json_formats.txt
#!   for an overview of the qgraph format.
#! @Arguments morphism, filename
DeclareGlobalFunction( "ExportAsQGraph" );
