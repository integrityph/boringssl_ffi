const testVectorsStr = """
[
	{
		"name":"should correctly hash an empty string",
		"input":"",
		"output":"38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b",
		"shouldPass":true
	},
  {
		"name":"should correctly hash abc",
		"input":"abc",
		"output":"cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7",
		"shouldPass":true
	},
  {
		"name":"should correctly hash a longer alphanumeric string",
		"input":"abcdefghijklmnopqrstuvwxyz",
		"output":"feb67349df3db6f5924815d6c3dc133f091809213731fe5c7b5f4999e463479ff2877f5f2936fa63bb43784b12f3ebb4",
		"shouldPass":true
	}
]
""";