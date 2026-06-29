BeginPackage["ArnoudBuzing`Ellip`"]

EllipK::usage = "EllipK[m] computes the complete elliptic integral of the first kind K(m)."
EllipE::usage = "EllipE[m] computes the complete elliptic integral of the second kind E(m)."
EllipPi::usage = "EllipPi[n, m] computes the complete elliptic integral of the third kind Pi(n, m)."
EllipD::usage = "EllipD[m] computes the Legendre type complete elliptic integral D(m)."

EllipF::usage = "EllipF[phi, m] computes the incomplete elliptic integral of the first kind F(phi, m)."
EllipEInc::usage = "EllipEInc[phi, m] computes the incomplete elliptic integral of the second kind E(phi, m)."
EllipPiInc::usage = "EllipPiInc[phi, n, m] computes the incomplete elliptic integral of the third kind Pi(phi, n, m)."
EllipPiIncBulirsch::usage = "EllipPiIncBulirsch[phi, n, m] computes the incomplete elliptic integral of the third kind using Bulirsch's algorithm."
EllipDInc::usage = "EllipDInc[phi, m] computes the Legendre type incomplete elliptic integral D(phi, m)."

Cel::usage = "Cel[kc, p, a, b] computes Bulirsch's general complete elliptic integral cel(kc, p, a, b)."
Cel1::usage = "Cel1[kc] computes Bulirsch's complete elliptic integral of the first kind cel1(kc)."
Cel2::usage = "Cel2[kc, a, b] computes Bulirsch's complete elliptic integral of the second kind cel2(kc, a, b)."
El1::usage = "El1[x, kc] computes Bulirsch's incomplete elliptic integral of the first kind el1(x, kc)."
El2::usage = "El2[x, kc, a, b] computes Bulirsch's incomplete elliptic integral of the second kind el2(x, kc, a, b)."
El3::usage = "El3[x, kc, p] computes Bulirsch's incomplete elliptic integral of the third kind el3(x, kc, p)."

EllipRF::usage = "EllipRF[x, y, z] computes Carlson's symmetric elliptic integral of the first kind RF(x, y, z)."
EllipRG::usage = "EllipRG[x, y, z] computes Carlson's symmetric elliptic integral of the second kind RG(x, y, z)."
EllipRD::usage = "EllipRD[x, y, z] computes Carlson's symmetric elliptic integral of the third kind RD(x, y, z)."
EllipRJ::usage = "EllipRJ[x, y, z, p] computes Carlson's symmetric elliptic integral of the third kind RJ(x, y, z, p)."
EllipRC::usage = "EllipRC[x, y] computes Carlson's degenerate symmetric elliptic integral RC(x, y)."

Begin["`Private`"]

(* Locate the LibraryLink dynamic library *)
$libExtension = Switch[$SystemID,
  "Windows" | "Windows-x86-64", ".dll",
  "MacOSX" | "MacOSX-x86-64" | "MacOSX-ARM64", ".dylib",
  _, ".so"
];
$libFileName = "libellip_link" <> $libExtension;
$libDir = FileNameJoin[{DirectoryName[DirectoryName[$InputFileName]], "LibraryResources", $SystemID}];
$libPath = FileNameJoin[{$libDir, $libFileName}];

If[!FileExistsQ[$libPath],
  $libPath = FindLibrary["ellip_link"]
];

If[!StringQ[$libPath] || !FileExistsQ[$libPath],
  $libPath = "ellip_link" (* Fallback to search path *)
];

(* Load functions *)
iEllipK = LibraryFunctionLoad[$libPath, "ellipk", {Real}, Real];
iEllipE = LibraryFunctionLoad[$libPath, "ellipe", {Real}, Real];
iEllipPi = LibraryFunctionLoad[$libPath, "ellippi", {Real, Real}, Real];
iEllipD = LibraryFunctionLoad[$libPath, "ellipd", {Real}, Real];

iEllipF = LibraryFunctionLoad[$libPath, "ellipf", {Real, Real}, Real];
iEllipEInc = LibraryFunctionLoad[$libPath, "ellipeinc", {Real, Real}, Real];
iEllipPiInc = LibraryFunctionLoad[$libPath, "ellippiinc", {Real, Real, Real}, Real];
iEllipPiIncBulirsch = LibraryFunctionLoad[$libPath, "ellippiinc_bulirsch", {Real, Real, Real}, Real];
iEllipDInc = LibraryFunctionLoad[$libPath, "ellipdinc", {Real, Real}, Real];

iCel = LibraryFunctionLoad[$libPath, "cel", {Real, Real, Real, Real}, Real];
iCel1 = LibraryFunctionLoad[$libPath, "cel1", {Real}, Real];
iCel2 = LibraryFunctionLoad[$libPath, "cel2", {Real, Real, Real}, Real];
iEl1 = LibraryFunctionLoad[$libPath, "el1", {Real, Real}, Real];
iEl2 = LibraryFunctionLoad[$libPath, "el2", {Real, Real, Real, Real}, Real];
iEl3 = LibraryFunctionLoad[$libPath, "el3", {Real, Real, Real}, Real];

iEllipRF = LibraryFunctionLoad[$libPath, "elliprf", {Real, Real, Real}, Real];
iEllipRG = LibraryFunctionLoad[$libPath, "elliprg", {Real, Real, Real}, Real];
iEllipRD = LibraryFunctionLoad[$libPath, "elliprd", {Real, Real, Real}, Real];
iEllipRJ = LibraryFunctionLoad[$libPath, "elliprj", {Real, Real, Real, Real}, Real];
iEllipRC = LibraryFunctionLoad[$libPath, "elliprc", {Real, Real}, Real];

(* Definitions and argument coercion/validation *)
EllipK[m_?NumericQ] := iEllipK[N[m]]
EllipE[m_?NumericQ] := iEllipE[N[m]]
EllipPi[n_?NumericQ, m_?NumericQ] := iEllipPi[N[n], N[m]]
EllipD[m_?NumericQ] := iEllipD[N[m]]

EllipF[phi_?NumericQ, m_?NumericQ] := iEllipF[N[phi], N[m]]
EllipEInc[phi_?NumericQ, m_?NumericQ] := iEllipEInc[N[phi], N[m]]
EllipPiInc[phi_?NumericQ, n_?NumericQ, m_?NumericQ] := iEllipPiInc[N[phi], N[n], N[m]]
EllipPiIncBulirsch[phi_?NumericQ, n_?NumericQ, m_?NumericQ] := iEllipPiIncBulirsch[N[phi], N[n], N[m]]
EllipDInc[phi_?NumericQ, m_?NumericQ] := iEllipDInc[N[phi], N[m]]

Cel[kc_?NumericQ, p_?NumericQ, a_?NumericQ, b_?NumericQ] := iCel[N[kc], N[p], N[a], N[b]]
Cel1[kc_?NumericQ] := iCel1[N[kc]]
Cel2[kc_?NumericQ, a_?NumericQ, b_?NumericQ] := iCel2[N[kc], N[a], N[b]]
El1[x_?NumericQ, kc_?NumericQ] := iEl1[N[x], N[kc]]
El2[x_?NumericQ, kc_?NumericQ, a_?NumericQ, b_?NumericQ] := iEl2[N[x], N[kc], N[a], N[b]]
El3[x_?NumericQ, kc_?NumericQ, p_?NumericQ] := iEl3[N[x], N[kc], N[p]]

EllipRF[x_?NumericQ, y_?NumericQ, z_?NumericQ] := iEllipRF[N[x], N[y], N[z]]
EllipRG[x_?NumericQ, y_?NumericQ, z_?NumericQ] := iEllipRG[N[x], N[y], N[z]]
EllipRD[x_?NumericQ, y_?NumericQ, z_?NumericQ] := iEllipRD[N[x], N[y], N[z]]
EllipRJ[x_?NumericQ, y_?NumericQ, z_?NumericQ, p_?NumericQ] := iEllipRJ[N[x], N[y], N[z], N[p]]
EllipRC[x_?NumericQ, y_?NumericQ] := iEllipRC[N[x], N[y]]

End[]

EndPackage[]
