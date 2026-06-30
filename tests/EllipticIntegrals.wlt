(* Unit tests for the EllipticIntegrals paclet *)

(* Setup: load the package with alias context *)
VerificationTest[
  Quiet[Needs["ArnoudBuzing`EllipticIntegrals`" -> "ei`"]],
  Null,
  TestID -> "load-package-alias"
]

(* Legendre Complete Integrals *)

VerificationTest[
  ei`EllipticK[0.5],
  EllipticK[0.5],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-k"
]

VerificationTest[
  ei`EllipticE[0.5],
  EllipticE[0.5],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-e"
]

VerificationTest[
  ei`EllipticPi[0.2, 0.5],
  EllipticPi[0.2, 0.5],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-pi"
]

VerificationTest[
  ei`EllipticD[0.5],
  (EllipticK[0.5] - EllipticE[0.5])/0.5,
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-d"
]

(* Legendre Incomplete Integrals *)

VerificationTest[
  ei`EllipticF[1.0, 0.5],
  EllipticF[1.0, 0.5],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-f"
]

VerificationTest[
  ei`EllipticE[1.0, 0.5],
  EllipticE[1.0, 0.5],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-einc"
]

VerificationTest[
  ei`EllipticPi[0.2, 1.0, 0.5],
  EllipticPi[0.2, 1.0, 0.5],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-piinc"
]

VerificationTest[
  ei`EllipticPiBulirsch[0.2, 1.0, 0.5],
  EllipticPi[0.2, 1.0, 0.5],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-piinc-bulirsch"
]

VerificationTest[
  ei`EllipticD[1.0, 0.5],
  (EllipticF[1.0, 0.5] - EllipticE[1.0, 0.5])/0.5,
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-dinc"
]

(* Carlson Symmetric Integrals *)

VerificationTest[
  ei`CarlsonRF[1.0, 2.0, 3.0],
  CarlsonRF[1.0, 2.0, 3.0],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "carlson-rf"
]

VerificationTest[
  ei`CarlsonRG[1.0, 2.0, 3.0],
  CarlsonRG[1.0, 2.0, 3.0],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "carlson-rg"
]

VerificationTest[
  ei`CarlsonRD[1.0, 2.0, 3.0],
  CarlsonRD[1.0, 2.0, 3.0],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "carlson-rd"
]

VerificationTest[
  ei`CarlsonRJ[1.0, 2.0, 3.0, 4.0],
  CarlsonRJ[1.0, 2.0, 3.0, 4.0],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "carlson-rj"
]

VerificationTest[
  ei`CarlsonRC[1.0, 2.0],
  CarlsonRC[1.0, 2.0],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "carlson-rc"
]

(* Error and symbolic argument checks *)

VerificationTest[
  ei`CarlsonRF[1.0, 2.0, -3.0],
  Indeterminate,
  TestID -> "carlson-error-domain"
]

VerificationTest[
  ei`EllipticK[x],
  ei`EllipticK[x],
  TestID -> "symbolic-ellip-k"
]
