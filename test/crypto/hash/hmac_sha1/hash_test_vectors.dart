const testVectorsStr = """
[
	{
		"name":"should correctly hash an empty string",
		"input":"",
    "key":"8784d01f4b9e2fd1e40c5920532b6cf66e19e8e2c57960b9b947cd635513fe26",
		"output":"338488f830696193d596c89609cffb12e12e1d8a",
		"shouldPass":true
	},
  {
		"name":"should correctly hash abc",
		"input":"616263",
    "key":"8784d01f4b9e2fd1e40c5920532b6cf66e19e8e2c57960b9b947cd635513fe26",
		"output":"d4d46dd24ca909462b8bcfad95511e96ff406ff0",
		"shouldPass":true
	},
  {
		"name":"should correctly hash a longer alphanumeric string",
		"input":"6162636465666768696a6b6c6d6e6f707172737475767778797a",
    "key":"8784d01f4b9e2fd1e40c5920532b6cf66e19e8e2c57960b9b947cd635513fe26",
		"output":"8356c38b15b8e2fe9d859c01f37677654f3d3967",
		"shouldPass":true
	}
]
""";