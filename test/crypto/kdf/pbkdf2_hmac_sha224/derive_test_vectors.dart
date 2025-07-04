const testVectorsStr = """
[
	{
		"name":"should correctly derive a a key from random 8 bytes password",
		"password":"d034d3bf6839d057",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":2048,
    "keyLength":32,
		"output":"1add857537ac15e3b37278ea11b3adbd627050238640d6a9374b48ef0715dc17",
		"shouldPass":true
	},
  {
		"name":"should correctly derive a a key from random 16 bytes password",
		"password":"4b46bf5b839774f909415029665e7b3d",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":2048,
    "keyLength":32,
		"output":"530283c5f4f17224ff8260a854900a88f0904b2d16284c5f5c88d10a6537096a",
		"shouldPass":true
	},
  {
		"name":"should correctly derive a a key from random 32 bytes password",
		"password":"f75d83155875bb0a2a214eb1c97d70eb856f8ca49ce9c464d14041ec63cb5c24",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":2048,
    "keyLength":32,
		"output":"1c0fe8c3a70f04ceb9dff189855afd8ad68d309958913d8e697c90ec931af66f",
		"shouldPass":true
	}
]
""";