const testVectorsStr = """
[
	{
		"_name":"should correctly derive from a 16 bytes random secret",
		"secret":"53b076c3dce7a6bf3a3d92f4b226d83d",
    "salt":"bb3dd07ea68762470d41efc4edbe408e04d70a109a980bbd06fd3b6ffce0a97e",
    "info":"3ad3f13ac74b3edad97ed8ddda84d101c1fa15d420163730",
    "keyLength":32,
		"output":"0b77ca42bd43fdd58b43f38910a2ff78c9ea961d68ce4329a654b6892e11bf2b",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive from a 32 bytes random secret",
		"secret":"5a9c5f373067ed09e7083b899f1b76af83ea8ef5f6ade653",
    "salt":"bb3dd07ea68762470d41efc4edbe408e04d70a109a980bbd06fd3b6ffce0a97e",
    "info":"3ad3f13ac74b3edad97ed8ddda84d101c1fa15d420163730",
    "keyLength":32,
		"output":"be7866a8c543087ec3119a992074a77469f081fae5b33d9f5420b82baf568318",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive from a 64 bytes random secret",
		"secret":"bdddbce07ac275a5fab6bab697190308ecdd1d4fd3255d4631078cc7403c2580",
    "salt":"bb3dd07ea68762470d41efc4edbe408e04d70a109a980bbd06fd3b6ffce0a97e",
    "info":"3ad3f13ac74b3edad97ed8ddda84d101c1fa15d420163730",
    "keyLength":32,
		"output":"c01b89304dd7a488549d439af64792d66a60b412ee2d937e6e6e76b43e8c0e1e",
		"shouldPass":true
	}
]
""";