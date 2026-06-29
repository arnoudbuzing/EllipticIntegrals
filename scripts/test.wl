(* Test runner script *)

$projectDir = DirectoryName[DirectoryName[$InputFileName]];
$pacletDir = FileNameJoin[{$projectDir, "EllipticIntegrals"}];

(* Add local paclet directory *)
PacletDirectoryLoad[$pacletDir];

format[outcome_String] := Switch[
  outcome,
  "Success", "\:2705",
  "Failure", "\:274c",
  _, "\:26a0"
];

files = If[ 
  Length[$CommandLine]>3, 
  { Last[$CommandLine] }, (* to run a specific file *)
  FileNames["*.wlt", FileNameJoin[{$projectDir, "tests"}], Infinity]
];

report = TestReport[
  files,
  HandlerFunctions -> <|
    "ReportStarted" -> Function[r, Print["Starting test report: " <> r["EventID"]]],
    "ReportCompleted" -> Function[r, Print["Test report completed: " <> r["EventID"]]],
    "FileStarted" -> Function[testFile, Print["Starting test file: " <> testFile["TestFileName"]]],
    "FileCompleted" -> Function[testFile, Print["Test file completed: " <> testFile["EventID"]]],
    "TestEvaluated" -> Function[test, Module[{obj},
      obj = test["TestObject"];
      Print["[" <> format[obj["Outcome"]] <> "] " <> ToString[obj["TestID"]]];
    ]]
  |>]

(* Exit with error code if any tests failed *)
If[report["NumberFailed"] > 0 || report["NumberAborted"] > 0,
  Print["Some tests failed: ", report["NumberFailed"], " failed, ", report["NumberAborted"], " aborted."];
  Exit[1],
  Print["All tests passed successfully!"];
  Exit[0]
]
