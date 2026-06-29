Print["Starting cargo build..."];

$installation = "/Applications/Wolfram/15.0/Wolfram.app";
SetEnvironment["WOLFRAM_INSTALLATION" -> $installation];

$projectDir = DirectoryName[DirectoryName[$InputFileName]];

(* Run cargo build --release *)
$result = RunProcess[{"cargo", "build", "--release"}, ProcessDirectory -> $projectDir];

Print[$result["StandardOutput"]];
Print[$result["StandardError"]];

If[$result["ExitCode"] =!= 0,
  Print["Error: Cargo build failed with exit code ", $result["ExitCode"]];
  Exit[$result["ExitCode"]]
];

(* Determine library filename *)
$libExtension = Switch[$SystemID,
  "Windows" | "Windows-x86-64", ".dll",
  "MacOSX" | "MacOSX-x86-64" | "MacOSX-ARM64", ".dylib",
  _, ".so"
];
$libPrefix = If[StringMatchQ[$SystemID, "Windows*"], "", "lib"];
$libName = $libPrefix <> "ellip_link" <> $libExtension;

$srcPath = FileNameJoin[{$projectDir, "target", "release", $libName}];
$destDir = FileNameJoin[{$projectDir, "Ellip", "LibraryResources", $SystemID}];
$destPath = FileNameJoin[{$destDir, $libName}];

If[!DirectoryQ[$destDir],
  CreateDirectory[$destDir, CreateIntermediateDirectories -> True]
];

If[FileExistsQ[$destPath],
  DeleteFile[$destPath]
];

Print["Copying library from: ", $srcPath, " to: ", $destPath];
CopyFile[$srcPath, $destPath];
Print["Build completed successfully!"];
