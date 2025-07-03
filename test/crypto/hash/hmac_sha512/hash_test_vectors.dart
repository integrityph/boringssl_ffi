const testVectorsStr = """
[
	{
		"name":"should correctly hash an empty string",
		"input":"",
    "key":"8784d01f4b9e2fd1e40c5920532b6cf66e19e8e2c57960b9b947cd635513fe26",
		"output":"5fed97ef041c3a56cfd15cde1193777eb37849432c67d8116ea13b5f7fdeadb1138470d8ed3d8602f6cbc003f1d4da9039514a0f727d05766ca7acba7ddc3e35",
		"shouldPass":true
	},
  {
		"name":"should correctly hash abc",
		"input":"616263",
    "key":"8784d01f4b9e2fd1e40c5920532b6cf66e19e8e2c57960b9b947cd635513fe26",
		"output":"30b870ea8ca2a5a0e81b8c26bd79f815ed9bd48251390802510c553cbb683466cc3f07c8016a30bde7ab6e37bb803c0e1ff517b5823e1959bdaf6388225541b3",
		"shouldPass":true
	},
  {
		"name":"should correctly hash a longer alphanumeric string",
		"input":"6162636465666768696a6b6c6d6e6f707172737475767778797a",
    "key":"8784d01f4b9e2fd1e40c5920532b6cf66e19e8e2c57960b9b947cd635513fe26",
		"output":"b01102eed76a3e61dd92879a9a1b7468c35e278018b3906ee108e372ebafa966227db69ecab2f78bde57d3a74ce382f3d6d949d5bd111eea9d13c4c6630993c4",
		"shouldPass":true
	}
]
""";