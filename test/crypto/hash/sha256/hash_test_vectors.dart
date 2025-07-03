const testVectorsStr = """
[
	{
		"name":"should correctly hash an empty string",
		"input":"",
		"output":"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
		"shouldPass":true
	},
  {
		"name":"should correctly hash abc",
		"input":"abc",
		"output":"ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad",
		"shouldPass":true
	},
  {
		"name":"should correctly hash a longer alphanumeric string",
		"input":"abcdefghijklmnopqrstuvwxyz",
		"output":"71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73",
		"shouldPass":true
	}
]
""";