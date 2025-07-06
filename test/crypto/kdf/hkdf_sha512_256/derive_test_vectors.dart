const testVectorsStr = """
[
	{
		"name":"should correctly derive from a 16 bytes random secret",
		"secret":"53b076c3dce7a6bf3a3d92f4b226d83d",
    "salt":"bb3dd07ea68762470d41efc4edbe408e04d70a109a980bbd06fd3b6ffce0a97e",
    "info":"3ad3f13ac74b3edad97ed8ddda84d101c1fa15d420163730",
    "keyLength":32,
		"output":"60c0e66309d9520c2f319bd5e26b2491a948c83990345abdd73331e7054fa3e0",
		"shouldPass":true
	},
  {
		"name":"should correctly derive from a 32 bytes random secret",
		"secret":"5a9c5f373067ed09e7083b899f1b76af83ea8ef5f6ade653",
    "salt":"bb3dd07ea68762470d41efc4edbe408e04d70a109a980bbd06fd3b6ffce0a97e",
    "info":"3ad3f13ac74b3edad97ed8ddda84d101c1fa15d420163730",
    "keyLength":32,
		"output":"7a7b5d7395e339dffa05de5cd386e943b6b72ac0d39e53a9beded4ec2b4e40a4",
		"shouldPass":true
	},
  {
		"name":"should correctly derive from a 64 bytes random secret",
		"secret":"bdddbce07ac275a5fab6bab697190308ecdd1d4fd3255d4631078cc7403c2580",
    "salt":"bb3dd07ea68762470d41efc4edbe408e04d70a109a980bbd06fd3b6ffce0a97e",
    "info":"3ad3f13ac74b3edad97ed8ddda84d101c1fa15d420163730",
    "keyLength":32,
		"output":"b5fe75c5668fe88017fad2c0c86b73b8d00d64f6568f40013f92b5e6a94d56ba",
		"shouldPass":true
	}
]
""";