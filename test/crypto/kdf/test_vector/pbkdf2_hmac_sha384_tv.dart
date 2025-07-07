const testVectorsStr = """
[
	{
		"_name":"should correctly derive a a key from random 8 bytes password",
		"password":"d034d3bf6839d057",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":2048,
    "keyLength":32,
		"output":"2a1ecd1d8e586ba63d67e39c813ab3e64d6cb6e7767980a06119604052ad6b07",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive a a key from random 16 bytes password",
		"password":"4b46bf5b839774f909415029665e7b3d",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":2048,
    "keyLength":32,
		"output":"41f03f9587a2789ae5615a5e2fbcb51bd1b0af6d0ee9ec3054ababe4ef76c671",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive a a key from random 32 bytes password",
		"password":"f75d83155875bb0a2a214eb1c97d70eb856f8ca49ce9c464d14041ec63cb5c24",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":2048,
    "keyLength":32,
		"output":"3f98ab377000a584e55c28fe183d2244c9a53f75ab0973b80a36ef5ddae1e3ac",
		"shouldPass":true
	}
]
""";