const testVectorsStr = """
[
	{
		"_name":"should correctly derive from a 16 bytes random secret",
		"secret":"53b076c3dce7a6bf3a3d92f4b226d83d",
    "salt":"bb3dd07ea68762470d41efc4edbe408e04d70a109a980bbd06fd3b6ffce0a97e",
    "info":"3ad3f13ac74b3edad97ed8ddda84d101c1fa15d420163730",
    "keyLength":32,
		"output":"4379bd2e71c8422553c269d4124f5fe7c19f38c501f10808160cd30b4e1058d3",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive from a 32 bytes random secret",
		"secret":"5a9c5f373067ed09e7083b899f1b76af83ea8ef5f6ade653",
    "salt":"bb3dd07ea68762470d41efc4edbe408e04d70a109a980bbd06fd3b6ffce0a97e",
    "info":"3ad3f13ac74b3edad97ed8ddda84d101c1fa15d420163730",
    "keyLength":32,
		"output":"d9161375def0095407ec8b4827cbc3e776bd7f3744ab66c5df4b9d0eb0d142bf",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive from a 64 bytes random secret",
		"secret":"bdddbce07ac275a5fab6bab697190308ecdd1d4fd3255d4631078cc7403c2580",
    "salt":"bb3dd07ea68762470d41efc4edbe408e04d70a109a980bbd06fd3b6ffce0a97e",
    "info":"3ad3f13ac74b3edad97ed8ddda84d101c1fa15d420163730",
    "keyLength":32,
		"output":"25f0acd482d8acaed4005c9a5c56e753bf80a3fa00b62a15026ac00a0239a660",
		"shouldPass":true
	}
]
""";