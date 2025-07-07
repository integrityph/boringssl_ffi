const testVectorsStr = """
[
	{
		"_name":"should correctly derive from a 16 bytes random secret",
		"secret":"53b076c3dce7a6bf3a3d92f4b226d83d",
    "salt":"bb3dd07ea68762470d41efc4edbe408e04d70a109a980bbd06fd3b6ffce0a97e",
    "info":"3ad3f13ac74b3edad97ed8ddda84d101c1fa15d420163730",
    "keyLength":32,
		"output":"aa7a0ea09647b29f29b91e7bf77163d0bacb2d4473b8f0d7340c2832471ae093",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive from a 32 bytes random secret",
		"secret":"5a9c5f373067ed09e7083b899f1b76af83ea8ef5f6ade653",
    "salt":"bb3dd07ea68762470d41efc4edbe408e04d70a109a980bbd06fd3b6ffce0a97e",
    "info":"3ad3f13ac74b3edad97ed8ddda84d101c1fa15d420163730",
    "keyLength":32,
		"output":"4e42ffa674b8a627c729a8d078dc15eca1816c5e7abe2a4de6b1ddcc8806b2c7",
		"shouldPass":true
	},
  {
		"_name":"should correctly derive from a 64 bytes random secret",
		"secret":"bdddbce07ac275a5fab6bab697190308ecdd1d4fd3255d4631078cc7403c2580",
    "salt":"bb3dd07ea68762470d41efc4edbe408e04d70a109a980bbd06fd3b6ffce0a97e",
    "info":"3ad3f13ac74b3edad97ed8ddda84d101c1fa15d420163730",
    "keyLength":32,
		"output":"d0324768d6fdf01e72cdfd36b20a1115b4b8d1b440495e6912d9164c8c138caa",
		"shouldPass":true
	}
]
""";