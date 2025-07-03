const testVectorsStr = """
[
	{
		"name":"should correctly encrypt an empty string",
		"input":"",
    "key":"d1051a519cbe35b0eb0c98fbb1b93f2ce3baf437d579d42fffabd0596c27bf9a",
    "ivec":"cf4ce13fd995a0c2da17674d90acf4ea",
    "num":0,
		"output":"",
		"shouldPass":true
	},
  {
		"name":"should correctly encrypt abc",
		"input":"616263",
    "key":"d1051a519cbe35b0eb0c98fbb1b93f2ce3baf437d579d42fffabd0596c27bf9a",
    "ivec":"cf4ce13fd995a0c2da17674d90acf4ea",
    "num":0,
		"output":"faf438",
		"shouldPass":true
	},
  {
		"name":"should correctly hash a longer alphanumeric string",
		"input":"6162636465666768696a6b6c6d6e6f707172737475767778797a",
    "key":"d1051a519cbe35b0eb0c98fbb1b93f2ce3baf437d579d42fffabd0596c27bf9a",
    "ivec":"cf4ce13fd995a0c2da17674d90acf4ea",
    "num":0,
		"output":"faf438ba27acb5fab25b4e9ab5c36c312f0d2d45abacccd25d3a",
		"shouldPass":true
	}
]
""";
