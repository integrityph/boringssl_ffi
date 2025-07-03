const testVectorsStr = """
[
	{
		"name":"should correctly hash an empty string",
		"input":"",
    "key":"8784d01f4b9e2fd1e40c5920532b6cf66e19e8e2c57960b9b947cd635513fe26",
		"output":"50d5ff62a84f1ee561e1fb93c1fcd62fb453a39632d2201d27cbca27",
		"shouldPass":true
	},
  {
		"name":"should correctly hash abc",
		"input":"616263",
    "key":"8784d01f4b9e2fd1e40c5920532b6cf66e19e8e2c57960b9b947cd635513fe26",
		"output":"9b732a05ec2138658294bd4523c197827a7af9f41e6587f73483273d",
		"shouldPass":true
	},
  {
		"name":"should correctly hash a longer alphanumeric string",
		"input":"6162636465666768696a6b6c6d6e6f707172737475767778797a",
    "key":"8784d01f4b9e2fd1e40c5920532b6cf66e19e8e2c57960b9b947cd635513fe26",
		"output":"9703a20a030f2b298e4082778e0c9bb4a8dcf2b174119e6c88df6abf",
		"shouldPass":true
	}
]
""";