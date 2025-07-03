const testVectorsStr = """
[
	{
		"name":"should correctly hash an empty string",
		"input":"",
		"output":"d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f",
		"shouldPass":true
	},
  {
		"name":"should correctly hash abc",
		"input":"abc",
		"output":"23097d223405d8228642a477bda255b32aadbce4bda0b3f7e36c9da7",
		"shouldPass":true
	},
  {
		"name":"should correctly hash a longer alphanumeric string",
		"input":"abcdefghijklmnopqrstuvwxyz",
		"output":"45a5f72c39c5cff2522eb3429799e49e5f44b356ef926bcf390dccc2",
		"shouldPass":true
	}
]
""";