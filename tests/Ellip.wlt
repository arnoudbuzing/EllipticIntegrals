(* Unit tests for the Ellip paclet *)

(* Setup: load the package *)
VerificationTest[
  Needs["ArnoudBuzing`Ellip`"],
  Null,
  TestID -> "load-package"
]

(* Legendre Complete Integrals *)

VerificationTest[
  EllipK[0.5],
  EllipticK[0.5],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-k"
]

VerificationTest[
  EllipE[0.5],
  EllipticE[0.5],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-e"
]

VerificationTest[
  EllipPi[0.2, 0.5],
  EllipticPi[0.2, 0.5],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-pi"
]

VerificationTest[
  EllipD[0.5],
  (EllipticK[0.5] - EllipticE[0.5])/0.5,
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-d"
]

(* Legendre Incomplete Integrals *)

VerificationTest[
  EllipF[1.0, 0.5],
  EllipticF[1.0, 0.5],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-f"
]

VerificationTest[
  EllipEInc[1.0, 0.5],
  EllipticE[1.0, 0.5],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-einc"
]

VerificationTest[
  EllipPiInc[1.0, 0.2, 0.5],
  EllipticPi[0.2, 1.0, 0.5], (* Note built-in arg order: n, phi, m *)
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-piinc"
]

VerificationTest[
  EllipPiIncBulirsch[1.0, 0.2, 0.5],
  EllipticPi[0.2, 1.0, 0.5],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-piinc-bulirsch"
]

VerificationTest[
  EllipDInc[1.0, 0.5],
  (EllipticF[1.0, 0.5] - EllipticE[1.0, 0.5])/0.5,
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "ellip-dinc"
]

(* Carlson Symmetric Integrals *)

VerificationTest[
  EllipRF[1.0, 2.0, 3.0],
  CarlsonRF[1.0, 2.0, 3.0],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "carlson-rf"
]

VerificationTest[
  EllipRG[1.0, 2.0, 3.0],
  CarlsonRG[1.0, 2.0, 3.0],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "carlson-rg"
]

VerificationTest[
  EllipRD[1.0, 2.0, 3.0],
  CarlsonRD[1.0, 2.0, 3.0],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "carlson-rd"
]

VerificationTest[
  EllipRJ[1.0, 2.0, 3.0, 4.0],
  CarlsonRJ[1.0, 2.0, 3.0, 4.0],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "carlson-rj"
]

VerificationTest[
  EllipRC[1.0, 2.0],
  CarlsonRC[1.0, 2.0],
  SameTest -> (Abs[#1 - #2] < 10^-14 &),
  TestID -> "carlson-rc"
]

(* Error and symbolic argument checks *)

VerificationTest[
  EllipRF[1.0, 2.0, -3.0],
  Indeterminate,
  TestID -> "carlson-error-domain"
]

VerificationTest[
  EllipK[x],
  EllipK[x],
  TestID -> "symbolic-ellip-k"
]
