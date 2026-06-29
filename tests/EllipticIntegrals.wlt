(* Unit tests for the EllipticIntegrals paclet *)

(* Setup: load the package *)
VerificationTest[
  Needs["ArnoudBuzing`EllipticIntegrals`"],
  Null,
  TestID -> "load-package"
]

(* Legendre Complete Integrals *)

VerificationTest[
  rEllipticK[0.5],
  EllipticK[0.5],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-k"
]

VerificationTest[
  rEllipticE[0.5],
  EllipticE[0.5],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-e"
]

VerificationTest[
  rEllipticPi[0.2, 0.5],
  EllipticPi[0.2, 0.5],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-pi"
]

VerificationTest[
  rEllipticD[0.5],
  (EllipticK[0.5] - EllipticE[0.5])/0.5,
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-d"
]

(* Legendre Incomplete Integrals *)

VerificationTest[
  rEllipticF[1.0, 0.5],
  EllipticF[1.0, 0.5],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-f"
]

VerificationTest[
  rEllipticE[1.0, 0.5],
  EllipticE[1.0, 0.5],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-einc"
]

VerificationTest[
  rEllipticPi[0.2, 1.0, 0.5],
  EllipticPi[0.2, 1.0, 0.5],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-piinc"
]

VerificationTest[
  rEllipticPiBulirsch[0.2, 1.0, 0.5],
  EllipticPi[0.2, 1.0, 0.5],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-piinc-bulirsch"
]

VerificationTest[
  rEllipticD[1.0, 0.5],
  (EllipticF[1.0, 0.5] - EllipticE[1.0, 0.5])/0.5,
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-dinc"
]

(* Carlson Symmetric Integrals *)

VerificationTest[
  rCarlsonRF[1.0, 2.0, 3.0],
  CarlsonRF[1.0, 2.0, 3.0],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "carlson-rf"
]

VerificationTest[
  rCarlsonRG[1.0, 2.0, 3.0],
  CarlsonRG[1.0, 2.0, 3.0],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "carlson-rg"
]

VerificationTest[
  rCarlsonRD[1.0, 2.0, 3.0],
  CarlsonRD[1.0, 2.0, 3.0],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "carlson-rd"
]

VerificationTest[
  rCarlsonRJ[1.0, 2.0, 3.0, 4.0],
  CarlsonRJ[1.0, 2.0, 3.0, 4.0],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "carlson-rj"
]

VerificationTest[
  rCarlsonRC[1.0, 2.0],
  CarlsonRC[1.0, 2.0],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "carlson-rc"
]

(* Error and symbolic argument checks *)

VerificationTest[
  rCarlsonRF[1.0, 2.0, -3.0],
  Indeterminate,
  TestID -> "carlson-error-domain"
]

VerificationTest[
  rEllipticK[x],
  rEllipticK[x],
  TestID -> "symbolic-ellip-k"
]
