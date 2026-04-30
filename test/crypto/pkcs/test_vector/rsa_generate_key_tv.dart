const testVectorsStr = """
[
  {
		"_name":"should correctly generate a 512 RSA key",
		"bits":512,
    "exponent":null,
		"shouldPass":true
	},
	{
		"_name":"should correctly generate a 1025 RSA key",
		"bits":1024,
    "exponent":null,
		"shouldPass":true
	},
  {
		"_name":"should correctly generate a 2048 RSA key",
		"bits":2048,
    "exponent":null,
		"shouldPass":true
	},
  {
		"_name":"should correctly generate a 3072 RSA key",
		"bits":3072,
    "exponent":null,
		"shouldPass":true
	},
  {
		"_name":"should correctly generate a 4096 RSA key",
		"bits":4096,
    "exponent":null,
		"shouldPass":true
	}
]
""";