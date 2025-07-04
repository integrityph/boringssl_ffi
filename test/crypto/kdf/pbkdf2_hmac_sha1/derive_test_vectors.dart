const testVectorsStr = """
[
	{
		"name":"should correctly derive a a key from random 8 bytes password",
		"password":"d034d3bf6839d057",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":1024,
    "keyLength":20,
		"output":"264a86dfda6cf512e0c2dbb70cc1e6f7d38e9863",
		"shouldPass":true
	},
  {
		"name":"should correctly derive a a key from random 16 bytes password",
		"password":"4b46bf5b839774f909415029665e7b3d",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":1024,
    "keyLength":20,
		"output":"6588624490f713159980904ee694f33db758a4ef",
		"shouldPass":true
	},
  {
		"name":"should correctly derive a a key from random 32 bytes password",
		"password":"f75d83155875bb0a2a214eb1c97d70eb856f8ca49ce9c464d14041ec63cb5c24",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":1024,
    "keyLength":20,
		"output":"4e63c9d0c1d342a9779684db2ea43d27646d8073",
		"shouldPass":true
	}
]
""";