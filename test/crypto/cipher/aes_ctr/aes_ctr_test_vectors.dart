const testVectorsStr = """
[
	{
		"name":"should correctly encrypt an empty string",
		"input":"",
    "key":"55c377a1655e3428985f5c6bcbb62463e4846b78b3ad62c14d040541fce8d635",
    "ivec":"74e9c25d5d3f0a89c9ef2cbc4c7c7dbf",
    "ecount_buf":"00000000000000000000000000000000",
    "num":0,
		"output":"",
		"shouldPass":true
	},
  {
		"name":"should correctly encrypt abc",
		"input":"616263",
    "key":"55c377a1655e3428985f5c6bcbb62463e4846b78b3ad62c14d040541fce8d635",
    "ivec":"74e9c25d5d3f0a89c9ef2cbc4c7c7dbf",
    "ecount_buf":"00000000000000000000000000000000",
    "num":0,
		"output":"6f4026",
		"shouldPass":true
	},
  {
		"name":"should correctly hash a longer alphanumeric string",
		"input":"6162636465666768696a6b6c6d6e6f707172737475767778797a",
    "key":"55c377a1655e3428985f5c6bcbb62463e4846b78b3ad62c14d040541fce8d635",
    "ivec":"74e9c25d5d3f0a89c9ef2cbc4c7c7dbf",
    "ecount_buf":"00000000000000000000000000000000",
    "num":0,
		"output":"6f402654383bb0f8a3095a805c66d9ca757882028a51f608ff67",
		"shouldPass":true
	}
]
""";
