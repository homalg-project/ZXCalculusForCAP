# SPDX-License-Identifier: GPL-2.0-or-later
# ZXCalculusForCAP: The category of ZX-diagrams
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "ZXCalculusForCAP",
Subtitle := "The category of ZX-diagrams",
Version := "2025.06-07",
Date := (function ( ) if IsBound( GAPInfo.SystemEnvironment.GAP_PKG_RELEASE_DATE ) then return GAPInfo.SystemEnvironment.GAP_PKG_RELEASE_DATE; else return Concatenation( ~.Version{[ 1 .. 4 ]}, "-", ~.Version{[ 6, 7 ]}, "-01" ); fi; end)( ),
License := "GPL-2.0-or-later",

Persons := [
  rec(
    FirstNames := "Fabian",
    LastName := "Zickgraf",
    WWWHome := "https://zickgraf.github.io/",
    Email := "fabian.zickgraf@uni-siegen.de",
    IsAuthor := true,
    IsMaintainer := true,
    PostalAddress := Concatenation(
               "Walter-Flex-Straße 3\n",
               "57072 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
],

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/ZXCalculusForCAP",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/ZXCalculusForCAP",
PackageInfoURL  := "https://homalg-project.github.io/ZXCalculusForCAP/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/ZXCalculusForCAP/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/ZXCalculusForCAP/releases/download/v", ~.Version, "/ZXCalculusForCAP-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "ZXCalculusForCAP",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "The category of ZX-diagrams",
),

Dependencies := rec(
  GAP := ">= 4.13.0",
  NeededOtherPackages := [
      [ "CAP", ">= 2025.06-06" ],
      [ "MonoidalCategories", ">= 2023.05-03" ], # monoidal structure
      [ "FinSetsForCAP", ">= 2023.06-05" ], # SKELETAL_FIN_SETS_ExplicitCoequalizer_primitive_input
  ],
  SuggestedOtherPackages := [
      [ "FunctorCategories", ">= 2023.07-01" ], # CategoryOfDecoratedQuivers
      [ "json", "2.1.1" ], # Exporting to JSON
  ],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

));
