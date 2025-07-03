const testVectorsStr = """
[
	{
		"name":"should correctly encrypt an empty string",
		"input":"",
    "key":"9a237b85deae4b1d2d4201ea37a3ea8c40366e5e079197c0ba28b5a23ea6a5db",
    "ivec":"cba5cf486baed5e44b00e60d9be348e5",
		"output":"1c8dde585565fa894c02f50371f6d774",
		"shouldPass":true
	},
  {
		"name":"should correctly encrypt abc",
		"input":"616263",
    "key":"9a237b85deae4b1d2d4201ea37a3ea8c40366e5e079197c0ba28b5a23ea6a5db",
    "ivec":"cba5cf486baed5e44b00e60d9be348e5",
		"output":"8a2c73217e5ee78a955e265f40cae382",
		"shouldPass":true
	},
  {
		"name":"should correctly hash a longer alphanumeric string",
		"input":"6162636465666768696a6b6c6d6e6f707172737475767778797a",
    "key":"9a237b85deae4b1d2d4201ea37a3ea8c40366e5e079197c0ba28b5a23ea6a5db",
    "ivec":"cba5cf486baed5e44b00e60d9be348e5",
		"output":"c6928a54ac867378b8390d8d79472ee1456dcd75d6de02974110b2575bdb5210",
		"shouldPass":true
	}
]
""";
