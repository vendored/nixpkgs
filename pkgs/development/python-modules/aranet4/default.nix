{
  lib,
  bleak,
  buildPythonPackage,
  fetchFromGitHub,
  pytestCheckHook,
  pythonOlder,
  requests,
  setuptools,
}:

buildPythonPackage rec {
  pname = "aranet4";
  version = "2.3.3";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "Anrijs";
    repo = "Aranet4-Python";
    rev = "refs/tags/v${version}";
    hash = "sha256-j53d2Ki9xVWGHWkAu1wkjYE56Xq7kfMmqQrQiKrBg2I=";
  };

  build-system = [ setuptools ];

  dependencies = [
    bleak
    requests
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "aranet4" ];

  disabledTests = [
    # Test compares rendered output
    "test_current_values"
  ];

  meta = with lib; {
    description = "Module to interact with Aranet4 devices";
    homepage = "https://github.com/Anrijs/Aranet4-Python";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
    mainProgram = "aranetctl";
  };
}
