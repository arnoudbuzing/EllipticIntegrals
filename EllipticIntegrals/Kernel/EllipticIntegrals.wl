BeginPackage["ArnoudBuzing`EllipticIntegrals`"]

(* Force symbol creation in the package context to avoid shadowing built-in System` symbols *)
ArnoudBuzing`EllipticIntegrals`EllipticK;
ArnoudBuzing`EllipticIntegrals`EllipticE;
ArnoudBuzing`EllipticIntegrals`EllipticPi;
ArnoudBuzing`EllipticIntegrals`EllipticF;
ArnoudBuzing`EllipticIntegrals`CarlsonRF;
ArnoudBuzing`EllipticIntegrals`CarlsonRG;
ArnoudBuzing`EllipticIntegrals`CarlsonRD;
ArnoudBuzing`EllipticIntegrals`CarlsonRJ;
ArnoudBuzing`EllipticIntegrals`CarlsonRC;

EllipticK::usage = "EllipticK[m] computes the complete elliptic integral of the first kind K(m)."
EllipticE::usage = "EllipticE[m] computes the complete elliptic integral of the second kind E(m).\nEllipticE[phi, m] computes the incomplete elliptic integral of the second kind E(phi, m)."
EllipticPi::usage = "EllipticPi[n, m] computes the complete elliptic integral of the third kind Pi(n, m).\nEllipticPi[n, phi, m] computes the incomplete elliptic integral of the third kind Pi(n; phi, m)."
EllipticF::usage = "EllipticF[phi, m] computes the incomplete elliptic integral of the first kind F(phi, m)."
EllipticD::usage = "EllipticD[m] computes the Legendre type complete elliptic integral D(m).\nEllipticD[phi, m] computes the Legendre type incomplete elliptic integral D(phi, m)."
EllipticPiBulirsch::usage = "EllipticPiBulirsch[n, phi, m] computes the incomplete elliptic integral of the third kind Pi(n; phi, m) using Bulirsch's algorithm."

Cel::usage = "Cel[kc, p, a, b] computes Bulirsch's general complete elliptic integral cel(kc, p, a, b)."
Cel1::usage = "Cel1[kc] computes Bulirsch's complete elliptic integral of the first kind cel1(kc)."
Cel2::usage = "Cel2[kc, a, b] computes Bulirsch's complete elliptic integral of the second kind cel2(kc, a, b)."
El1::usage = "El1[x, kc] computes Bulirsch's incomplete elliptic integral of the first kind el1(x, kc)."
El2::usage = "El2[x, kc, a, b] computes Bulirsch's incomplete elliptic integral of the second kind el2(x, kc, a, b)."
El3::usage = "El3[x, kc, p] computes Bulirsch's incomplete elliptic integral of the third kind el3(x, kc, p)."

CarlsonRF::usage = "CarlsonRF[x, y, z] computes Carlson's symmetric elliptic integral of the first kind RF(x, y, z)."
CarlsonRG::usage = "CarlsonRG[x, y, z] computes Carlson's symmetric elliptic integral of the second kind RG(x, y, z)."
CarlsonRD::usage = "CarlsonRD[x, y, z] computes Carlson's symmetric elliptic integral of the third kind RD(x, y, z)."
CarlsonRJ::usage = "CarlsonRJ[x, y, z, p] computes Carlson's symmetric elliptic integral of the third kind RJ(x, y, z, p)."
CarlsonRC::usage = "CarlsonRC[x, y] computes Carlson's degenerate symmetric elliptic integral RC(x, y)."

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

(* Load LibraryLink functions *)
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

EllipticK[m_?NumericQ] := iEllipK[N[m]]

EllipticE[m_?NumericQ] := iEllipE[N[m]]
EllipticE[phi_?NumericQ, m_?NumericQ] := iEllipEInc[N[phi], N[m]]

EllipticPi[n_?NumericQ, m_?NumericQ] := iEllipPi[N[n], N[m]]
EllipticPi[n_?NumericQ, phi_?NumericQ, m_?NumericQ] := iEllipPiInc[N[phi], N[n], N[m]]

EllipticF[phi_?NumericQ, m_?NumericQ] := iEllipF[N[phi], N[m]]

EllipticD[m_?NumericQ] := iEllipD[N[m]]
EllipticD[phi_?NumericQ, m_?NumericQ] := iEllipDInc[N[phi], N[m]]

EllipticPiBulirsch[n_?NumericQ, phi_?NumericQ, m_?NumericQ] := iEllipPiIncBulirsch[N[phi], N[n], N[m]]

Cel[kc_?NumericQ, p_?NumericQ, a_?NumericQ, b_?NumericQ] := iCel[N[kc], N[p], N[a], N[b]]
Cel1[kc_?NumericQ] := iCel1[N[kc]]
Cel2[kc_?NumericQ, a_?NumericQ, b_?NumericQ] := iCel2[N[kc], N[a], N[b]]
El1[x_?NumericQ, kc_?NumericQ] := iEl1[N[x], N[kc]]
El2[x_?NumericQ, kc_?NumericQ, a_?NumericQ, b_?NumericQ] := iEl2[N[x], N[kc], N[a], N[b]]
El3[x_?NumericQ, kc_?NumericQ, p_?NumericQ] := iEl3[N[x], N[kc], N[p]]

CarlsonRF[x_?NumericQ, y_?NumericQ, z_?NumericQ] := iEllipRF[N[x], N[y], N[z]]
CarlsonRG[x_?NumericQ, y_?NumericQ, z_?NumericQ] := iEllipRG[N[x], N[y], N[z]]
CarlsonRD[x_?NumericQ, y_?NumericQ, z_?NumericQ] := iEllipRD[N[x], N[y], N[z]]
CarlsonRJ[x_?NumericQ, y_?NumericQ, z_?NumericQ, p_?NumericQ] := iEllipRJ[N[x], N[y], N[z], N[p]]
CarlsonRC[x_?NumericQ, y_?NumericQ] := iEllipRC[N[x], N[y]]

End[]

EndPackage[]
