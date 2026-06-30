(* Paclet deploy script *)

$projectDir = DirectoryName[DirectoryName[$InputFileName]];
$resourceDefinitionPath = FileNameJoin[{$projectDir, "EllipticIntegrals", "ResourceDefinition.nb"}];

Print["Starting paclet deployment using UsingFrontEnd..."];

result = UsingFrontEnd[
  Needs["DefinitionNotebookClient`"];
  
  Print["Opening resource definition notebook: ", $resourceDefinitionPath];
  nb = NotebookOpen[$resourceDefinitionPath];
  
  Print["Running DeployResource to CloudPublic..."];
  DefinitionNotebookClient`DeployResource[nb, "CloudPublic"]
];

Print["Deployment result: ", result];
