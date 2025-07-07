const testVectorsStr = """
[
	{
		"_name":"should correctly derive a key from random 8 bytes password",
		"password":"d034d3bf6839d057",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":1024,
    "keyLength":20,
		"output":"264a86dfda6cf512e0c2dbb70cc1e6f7d38e9863",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive a key from random 16 bytes password",
		"password":"4b46bf5b839774f909415029665e7b3d",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":1024,
    "keyLength":20,
		"output":"6588624490f713159980904ee694f33db758a4ef",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive a key from random 32 bytes password",
		"password":"f75d83155875bb0a2a214eb1c97d70eb856f8ca49ce9c464d14041ec63cb5c24",
    "salt":"12ed5f088f04cedc8af046a665c414d656ca75a2176eba4f3434a5d9d245d4fc",
    "iterations":1024,
    "keyLength":20,
		"output":"4e63c9d0c1d342a9779684db2ea43d27646d8073",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive a key for RFC-6070 example 1",
		"password":"70617373776f7264",
    "salt":"73616c74",
    "iterations":1,
    "keyLength":20,
		"output":"0c60c80f961f0e71f3a9b524af6012062fe037a6",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive a key for RFC-6070 example 2",
		"password":"70617373776f7264",
    "salt":"73616c74",
    "iterations":2,
    "keyLength":20,
		"output":"ea6c014dc72d6f8ccd1ed92ace1d41f0d8de8957",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive a key for RFC-6070 example 3",
		"password":"70617373776f7264",
    "salt":"73616c74",
    "iterations":4096,
    "keyLength":20,
		"output":"4b007901b765489abead49d926f721d065a429c1",
		"shouldPass":true
	},
  {
  	"_name":"should correctly derive a key for RFC-6070 example 4",
		"password":"70617373776f7264",
    "salt":"73616c74",
    "iterations":16777216,
    "keyLength":20,
		"output":"eefe3d61cd4da4e4e9945b3d6ba2158c2634e984",
		"shouldPass":true
	},
  {
    "_name":"should correctly derive a key for RFC-6070 example 5",
		"password":"70617373776f726450415353574f524470617373776f7264",
    "salt":"73616c7453414c5473616c7453414c5473616c7453414c5473616c7453414c5473616c74",
    "iterations":4096,
    "keyLength":25,
		"output":"3d2eec4fe41c849b80c8d83662c0e44a8b291a964cf2f07038",
		"shouldPass":true
	},
  {
    "_name":"should correctly derive a key for RFC-6070 example 6",
		"password":"7061737300776f7264",
    "salt":"7361006c74",
    "iterations":4096,
    "keyLength":16,
		"output":"56fa6aa75548099dcc37d7f03425e0c3",
		"shouldPass":true
	}
]
""";