const testVectorsStr = """
[
	{
		"_name":"should correctly derive a a key from random 8 bytes password",
		"password":"d034d3bf6839d057",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":2048,
    "keyLength":32,
		"output":"e32e140ca9256df2ddf291753f06efbb365a17901a75a7ca6a73ff81c298469b",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive a a key from random 16 bytes password",
		"password":"4b46bf5b839774f909415029665e7b3d",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":2048,
    "keyLength":32,
		"output":"836437245acb6cc34453732a6ab25a3d3b9f7da82ab1907126e72a27dbcbfa27",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive a a key from random 32 bytes password",
		"password":"f75d83155875bb0a2a214eb1c97d70eb856f8ca49ce9c464d14041ec63cb5c24",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":2048,
    "keyLength":32,
		"output":"bfb6e62d09edda5479053448934c03cebc458fbb7e3ab22c1d1b5007c8fff742",
		"shouldPass":true
	}
]
""";