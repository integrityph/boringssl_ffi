const testVectorsStr = """
[
	{
		"name":"should correctly hash an empty string",
		"input":"",
    "key":"8784d01f4b9e2fd1e40c5920532b6cf66e19e8e2c57960b9b947cd635513fe26",
		"output":"ae2053cf3b71f9204b9685218898375d267bc1baf6332be5b4117d94578b564f",
		"shouldPass":true
	},
  {
		"name":"should correctly hash abc",
		"input":"616263",
    "key":"8784d01f4b9e2fd1e40c5920532b6cf66e19e8e2c57960b9b947cd635513fe26",
		"output":"9421ba067b75bbe9081470a0f252510c2dcbd531456d2591fa9dc898fc55e06d",
		"shouldPass":true
	},
  {
		"name":"should correctly hash a longer alphanumeric string",
		"input":"6162636465666768696a6b6c6d6e6f707172737475767778797a",
    "key":"8784d01f4b9e2fd1e40c5920532b6cf66e19e8e2c57960b9b947cd635513fe26",
		"output":"45c49369d1fc5a382ddf2f4bff2348bee31c14b035f10faee10a37a763015780",
		"shouldPass":true
	}
]
""";