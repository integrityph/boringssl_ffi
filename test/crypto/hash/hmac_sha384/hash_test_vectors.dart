const testVectorsStr = """
[
	{
		"name":"should correctly hash an empty string",
		"input":"",
    "key":"8784d01f4b9e2fd1e40c5920532b6cf66e19e8e2c57960b9b947cd635513fe26",
		"output":"4f48cdbe8f98b3a5b774aaf4893b7dddacd3eda5aa59f7fa89248ea41f9240fd53fc1e5eecbe3b42e74bcb2bab9937fb",
		"shouldPass":true
	},
  {
		"name":"should correctly hash abc",
		"input":"616263",
    "key":"8784d01f4b9e2fd1e40c5920532b6cf66e19e8e2c57960b9b947cd635513fe26",
		"output":"0caed5ae21056a2df37e14c1c18086000945edc81ae58cd5bfc7a79d4121aece969435d8e15e505596019eaf1f73f8e6",
		"shouldPass":true
	},
  {
		"name":"should correctly hash a longer alphanumeric string",
		"input":"6162636465666768696a6b6c6d6e6f707172737475767778797a",
    "key":"8784d01f4b9e2fd1e40c5920532b6cf66e19e8e2c57960b9b947cd635513fe26",
		"output":"0b074909c5899e8bdd614776cfcdea9862b9321ae7965749543f3344142bf4d147e446d22c490efa8e6c7dc8109d0967",
		"shouldPass":true
	}
]
""";