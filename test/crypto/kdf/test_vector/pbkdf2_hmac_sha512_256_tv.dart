const testVectorsStr = """
[
	{
		"_name":"should correctly derive a a key from random 8 bytes password",
		"password":"d034d3bf6839d057",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":2048,
    "keyLength":32,
		"output":"a9b1165cdde1f57e2da003af128b72d805ba3ec5e6d654fdc313da9b68059c03",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive a a key from random 16 bytes password",
		"password":"4b46bf5b839774f909415029665e7b3d",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":2048,
    "keyLength":32,
		"output":"a32fe8a97593c82bb95dd1f93b45dd80982b976348bb045d87cf455ed6623974",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive a a key from random 32 bytes password",
		"password":"f75d83155875bb0a2a214eb1c97d70eb856f8ca49ce9c464d14041ec63cb5c24",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":2048,
    "keyLength":32,
		"output":"dc5dca570af118d34fec51407a92d551ba66fde3cffd0cb7b03ee21c47769334",
		"shouldPass":true
	}
]
""";