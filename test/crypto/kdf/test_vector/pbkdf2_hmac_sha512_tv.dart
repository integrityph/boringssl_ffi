const testVectorsStr = """
[
	{
		"_name":"should correctly derive a a key from random 8 bytes password",
		"password":"d034d3bf6839d057",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":2048,
    "keyLength":32,
		"output":"5d03031d88194f29d730f82fdfaa7934b0373737f95eae0037348465d92f8193",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive a a key from random 16 bytes password",
		"password":"4b46bf5b839774f909415029665e7b3d",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":2048,
    "keyLength":32,
		"output":"3ac68349f226086112ebf667c5bc8f022a25fd32206c1e8ed4f2c4c6f5dabf57",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive a a key from random 32 bytes password",
		"password":"f75d83155875bb0a2a214eb1c97d70eb856f8ca49ce9c464d14041ec63cb5c24",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":2048,
    "keyLength":32,
		"output":"32f5983e3f992f9bff955b28e677993903dc6a7197b396c42267f6db3c075996",
		"shouldPass":true
	}
]
""";