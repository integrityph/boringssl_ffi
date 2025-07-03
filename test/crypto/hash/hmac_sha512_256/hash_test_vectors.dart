const testVectorsStr = """
[
	{
		"name":"should correctly hash an empty string",
		"input":"",
    "key":"8784d01f4b9e2fd1e40c5920532b6cf66e19e8e2c57960b9b947cd635513fe26",
		"output":"165972f579588e7290597b463421d2c0e53640b4028f64087ef420e1e4116c62",
		"shouldPass":true
	},
  {
		"name":"should correctly hash abc",
		"input":"616263",
    "key":"8784d01f4b9e2fd1e40c5920532b6cf66e19e8e2c57960b9b947cd635513fe26",
		"output":"66cf8b810a56bb6b4a99f2aad76f3a145072d531362224c4109c31625c312465",
		"shouldPass":true
	},
  {
		"name":"should correctly hash a longer alphanumeric string",
		"input":"6162636465666768696a6b6c6d6e6f707172737475767778797a",
    "key":"8784d01f4b9e2fd1e40c5920532b6cf66e19e8e2c57960b9b947cd635513fe26",
		"output":"57ade69ffc045a50db21e51c365eda3e8eabca848e82e3a840f1d063d66dc1a3",
		"shouldPass":true
	}
]
""";