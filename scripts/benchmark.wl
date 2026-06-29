(* Benchmark script comparing Rust vs WL built-in elliptic functions *)

$projectDir = DirectoryName[DirectoryName[$InputFileName]];
$pacletDir = FileNameJoin[{$projectDir, "EllipticIntegrals"}];

PacletDirectoryLoad[$pacletDir];
Needs["ArnoudBuzing`EllipticIntegrals`"];

Print["Generating benchmark datasets (10,000 elements each)..."];
SeedRandom[12345];

nPoints = 10000;

(* Legendre domains: m < 1, n < 1 *)
dataLegendre1D = RandomReal[{-2.0, 0.99}, nPoints];
dataLegendre2D = RandomReal[{-2.0, 0.99}, {nPoints, 2}];
dataLegendre3D = RandomReal[{-2.0, 0.99}, {nPoints, 3}];

(* Carlson domains: variables > 0 *)
dataCarlson2D = RandomReal[{0.01, 10.0}, {nPoints, 2}];
dataCarlson3D = RandomReal[{0.01, 10.0}, {nPoints, 3}];
dataCarlson4D = RandomReal[{0.01, 10.0}, {nPoints, 4}];

benchmark[name_String, fRust_, fWL_, data_] := Module[
  {tRust, tWL, ratio},
  Print["Running benchmark for: ", name, "..."];
  (* Warm up *)
  If[MatrixQ[data],
    fRust @@ First[data];
    fWL @@ First[data];
    ,
    fRust[First[data]];
    fWL[First[data]];
  ];
  
  tRust = First[AbsoluteTiming[
    If[MatrixQ[data],
      Do[fRust @@ item, {item, data}],
      Do[fRust[item], {item, data}]
    ];
  ]];
  
  tWL = First[AbsoluteTiming[
    If[MatrixQ[data],
      Do[fWL @@ item, {item, data}],
      Do[fWL[item], {item, data}]
    ];
  ]];
  
  ratio = tWL / tRust;
  
  Print[StringTemplate["Results for ``:\n  Rust Link:   ``s\n  Built-in WL: ``s\n  Speedup:     ``x\n"][
    name,
    ToString[Round[tRust, 0.0001]],
    ToString[Round[tWL, 0.0001]],
    ToString[Round[ratio, 0.1]]
  ]];
]

Print["\nStarting benchmarks..."];
benchmark["EllipK / EllipticK", EllipK, EllipticK, dataLegendre1D];
benchmark["EllipE / EllipticE", EllipE, EllipticE, dataLegendre1D];
benchmark["EllipPi / EllipticPi", EllipPi, EllipticPi, dataLegendre2D];
benchmark["EllipD / (K-E)/m", EllipD, (EllipticK[#] - EllipticE[#])/# &, dataLegendre1D];

benchmark["EllipRF / CarlsonRF", EllipRF, CarlsonRF, dataCarlson3D];
benchmark["EllipRG / CarlsonRG", EllipRG, CarlsonRG, dataCarlson3D];
benchmark["EllipRD / CarlsonRD", EllipRD, CarlsonRD, dataCarlson3D];
benchmark["EllipRJ / CarlsonRJ", EllipRJ, CarlsonRJ, dataCarlson4D];
benchmark["EllipRC / CarlsonRC", EllipRC, CarlsonRC, dataCarlson2D];

Print["Benchmarks completed!"];
