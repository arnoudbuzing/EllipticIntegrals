(* Paclet build script *)

$projectDir = DirectoryName[DirectoryName[$InputFileName]];
$resourceDefinitionPath = FileNameJoin[{$projectDir, "EllipticIntegrals", "ResourceDefinition.nb"}];

Print["Starting paclet build using UsingFrontEnd..."];

result = UsingFrontEnd[
  Needs["DefinitionNotebookClient`"];
  Needs["PacletResource`DefinitionNotebook`"];
  Needs["DocumentationBuild`"];
  DocumentationBuild`Make`Private`nksIndexedFunctions = {};
  
  Print["Opening resource definition notebook: ", $resourceDefinitionPath];
  nb = NotebookOpen[$resourceDefinitionPath];
  
  Print["Running BuildPaclet..."];
  PacletResource`DefinitionNotebook`BuildPaclet[nb, All]
];

Print["Build result: ", result];
