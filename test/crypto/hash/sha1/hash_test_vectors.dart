const testVectorsStr = """
[
	{
		"name":"should correctly hash an empty string",
		"input":"",
		"output":"da39a3ee5e6b4b0d3255bfef95601890afd80709",
		"shouldPass":true
	},
  {
		"name":"should correctly hash abc",
		"input":"abc",
		"output":"a9993e364706816aba3e25717850c26c9cd0d89d",
		"shouldPass":true
	},
  {
		"name":"should correctly hash a longer alphanumeric string",
		"input":"abcdefghijklmnopqrstuvwxyz",
		"output":"32d10c7b8cf96570ca04ce37f2a19d84240d3a89",
		"shouldPass":true
	}
]
""";