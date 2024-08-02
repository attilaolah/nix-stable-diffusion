# WARNING: This file was automatically generated. You should avoid editing it.
# If you run pynixify again, the file will be either overwritten or
# deleted, and you will lose the changes you made to it.
{
  buildPythonPackage,
  fetchPypi,
  torch,
  pyparsing,
  transformers,
  diffusers,
  setuptools-rust,
  rustPlatform,
}:
buildPythonPackage rec {
  pname = "safetensors";
  version = "0.3.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "571da56ff8d0bec8ae54923b621cda98d36dcef10feb36fd492c4d0c2cd0e869";
  };

  pythonRemoveDeps = ["setuptools-rust"];
  nativeBuildInputs =
    [setuptools-rust]
    ++ (with rustPlatform; [
      cargoSetupHook
      rust.cargo
      rust.rustc
    ]);
  propagatedBuildInputs = [pyparsing torch transformers diffusers setuptools-rust];
  sourceRoot = "${pname}-${version}";
  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src sourceRoot;
    name = sourceRoot;
    hash = "sha256-m1pB2SqFFlx/YFblGvmRlV7Iwx+ei2gx7PUq6wZIoa4=";
    patches = [./cargo-lock.patch];
  };

  patches = [./cargo-lock.patch];

  # TODO FIXME
  doCheck = false;

  meta = {
    description = "A text prompt weighting and blending library for transformers-type text embedding systems";
    homepage = "https://pypi.org/project/compel/#description";
  };
}
