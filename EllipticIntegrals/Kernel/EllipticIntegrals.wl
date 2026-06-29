BeginPackage["ArnoudBuzing`EllipticIntegrals`"]

rEllipticK::usage = "rEllipticK[m] computes the complete elliptic integral of the first kind K(m)."
rEllipticE::usage = "rEllipticE[m] computes the complete elliptic integral of the second kind E(m).\nrEllipticE[phi, m] computes the incomplete elliptic integral of the second kind E(phi, m)."
rEllipticPi::usage = "rEllipticPi[n, m] computes the complete elliptic integral of the third kind Pi(n, m).\nrEllipticPi[n, phi, m] computes the incomplete elliptic integral of the third kind Pi(n; phi, m)."
rEllipticF::usage = "rEllipticF[phi, m] computes the incomplete elliptic integral of the first kind F(phi, m)."
rEllipticD::usage = "rEllipticD[m] computes the Legendre type complete elliptic integral D(m).\nrEllipticD[phi, m] computes the Legendre type incomplete elliptic integral D(phi, m)."
rEllipticPiBulirsch::usage = "rEllipticPiBulirsch[n, phi, m] computes the incomplete elliptic integral of the third kind Pi(n; phi, m) using Bulirsch's algorithm."

rCel::usage = "rCel[kc, p, a, b] computes Bulirsch's general complete elliptic integral cel(kc, p, a, b)."
rCel1::usage = "rCel1[kc] computes Bulirsch's complete elliptic integral of the first kind cel1(kc)."
rCel2::usage = "rCel2[kc, a, b] computes Bulirsch's complete elliptic integral of the second kind cel2(kc, a, b)."
rEl1::usage = "rEl1[x, kc] computes Bulirsch's incomplete elliptic integral of the first kind el1(x, kc)."
rEl2::usage = "rEl2[x, kc, a, b] computes Bulirsch's incomplete elliptic integral of the second kind el2(x, kc, a, b)."
rEl3::usage = "rEl3[x, kc, p] computes Bulirsch's incomplete elliptic integral of the third kind el3(x, kc, p)."

rCarlsonRF::usage = "rCarlsonRF[x, y, z] computes Carlson's symmetric elliptic integral of the first kind RF(x, y, z)."
rCarlsonRG::usage = "rCarlsonRG[x, y, z] computes Carlson's symmetric elliptic integral of the second kind RG(x, y, z)."
rCarlsonRD::usage = "rCarlsonRD[x, y, z] computes Carlson's symmetric elliptic integral of the third kind RD(x, y, z)."
rCarlsonRJ::usage = "rCarlsonRJ[x, y, z, p] computes Carlson's symmetric elliptic integral of the third kind RJ(x, y, z, p)."
rCarlsonRC::usage = "rCarlsonRC[x, y] computes Carlson's degenerate symmetric elliptic integral RC(x, y)."

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

(* Load underlying library functions *)
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

rEllipticK[m_?NumericQ] := iEllipK[N[m]]

rEllipticE[m_?NumericQ] := iEllipE[N[m]]
rEllipticE[phi_?NumericQ, m_?NumericQ] := iEllipEInc[N[phi], N[m]]

rEllipticPi[n_?NumericQ, m_?NumericQ] := iEllipPi[N[n], N[m]]
(* Note argument mapping for incomplete: WL EllipticPi[n, phi, m] -> Rust ellippiinc(phi, n, m) *)
rEllipticPi[n_?NumericQ, phi_?NumericQ, m_?NumericQ] := iEllipPiInc[N[phi], N[n], N[m]]

rEllipticF[phi_?NumericQ, m_?NumericQ] := iEllipF[N[phi], N[m]]

rEllipticD[m_?NumericQ] := iEllipD[N[m]]
rEllipticD[phi_?NumericQ, m_?NumericQ] := iEllipDInc[N[phi], N[m]]

(* Note argument mapping for Bulirsch incomplete: WL EllipticPi[n, phi, m] -> Rust ellippiinc_bulirsch(phi, n, m) *)
rEllipticPiBulirsch[n_?NumericQ, phi_?NumericQ, m_?NumericQ] := iEllipPiIncBulirsch[N[phi], N[n], N[m]]

rCel[kc_?NumericQ, p_?NumericQ, a_?NumericQ, b_?NumericQ] := iCel[N[kc], N[p], N[a], N[b]]
rCel1[kc_?NumericQ] := iCel1[N[kc]]
rCel2[kc_?NumericQ, a_?NumericQ, b_?NumericQ] := iCel2[N[kc], N[a], N[b]]
rEl1[x_?NumericQ, kc_?NumericQ] := iEl1[N[x], N[kc]]
rEl2[x_?NumericQ, kc_?NumericQ, a_?NumericQ, b_?NumericQ] := iEl2[N[x], N[kc], N[a], N[b]]
rEl3[x_?NumericQ, kc_?NumericQ, p_?NumericQ] := iEl3[N[x], N[kc], N[p]]

rCarlsonRF[x_?NumericQ, y_?NumericQ, z_?NumericQ] := iEllipRF[N[x], N[y], N[z]]
rCarlsonRG[x_?NumericQ, y_?NumericQ, z_?NumericQ] := iEllipRG[N[x], N[y], N[z]]
rCarlsonRD[x_?NumericQ, y_?NumericQ, z_?NumericQ] := iEllipRD[N[x], N[y], N[z]]
rCarlsonRJ[x_?NumericQ, y_?NumericQ, z_?NumericQ, p_?NumericQ] := iEllipRJ[N[x], N[y], N[z], N[p]]
rCarlsonRC[x_?NumericQ, y_?NumericQ] := iEllipRC[N[x], N[y]]

End[]

EndPackage[]
