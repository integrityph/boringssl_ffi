const testVectorsStr = """
[
	{
		"_name":"should correctly derive from a 16 bytes random secret",
		"secret":"53b076c3dce7a6bf3a3d92f4b226d83d",
    "salt":"bb3dd07ea68762470d41efc4edbe408e04d70a109a980bbd06fd3b6ffce0a97e",
    "info":"3ad3f13ac74b3edad97ed8ddda84d101c1fa15d420163730",
    "keyLength":32,
		"output":"dfcdfc5a5042dc3601ec45b0cfd090176096789c95f69b66671873419281f250",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive from a 32 bytes random secret",
		"secret":"5a9c5f373067ed09e7083b899f1b76af83ea8ef5f6ade653",
    "salt":"bb3dd07ea68762470d41efc4edbe408e04d70a109a980bbd06fd3b6ffce0a97e",
    "info":"3ad3f13ac74b3edad97ed8ddda84d101c1fa15d420163730",
    "keyLength":32,
		"output":"1849db8e46210cc77edef36d92ab04bb31e39f7bac4c3db5d5731e5f85f4b413",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive from a 64 bytes random secret",
		"secret":"bdddbce07ac275a5fab6bab697190308ecdd1d4fd3255d4631078cc7403c2580",
    "salt":"bb3dd07ea68762470d41efc4edbe408e04d70a109a980bbd06fd3b6ffce0a97e",
    "info":"3ad3f13ac74b3edad97ed8ddda84d101c1fa15d420163730",
    "keyLength":32,
		"output":"d30546b96b31a695d7f48f553689a5f2ad0622311a786ada81d82cf09cd7beea",
		"shouldPass":true
	}
]
""";