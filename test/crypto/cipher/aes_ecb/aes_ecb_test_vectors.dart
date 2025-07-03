const testVectorsStr = """
[
	{
		"name":"should correctly encrypt an empty string",
		"input":"",
    "key":"20627a3ac45977845fe278f747dc0121f072ee81af35ea8d8545c47d84f0a771",
		"output":"70bad46f4fb9717146bb8f1a0b91ac15",
		"shouldPass":true
	},
  {
		"name":"should correctly encrypt abc",
		"input":"616263",
    "key":"20627a3ac45977845fe278f747dc0121f072ee81af35ea8d8545c47d84f0a771",
		"output":"ea3f71b2f1001556b09f9b4749369452",
		"shouldPass":true
	},
  {
		"name":"should correctly hash a longer alphanumeric string",
		"input":"6162636465666768696a6b6c6d6e6f707172737475767778797a",
    "key":"20627a3ac45977845fe278f747dc0121f072ee81af35ea8d8545c47d84f0a771",
		"output":"7ac1177dc9889d497b66144d536991b8096673922c71e2906ee15e8f842aad00",
		"shouldPass":true
	}
]
""";
