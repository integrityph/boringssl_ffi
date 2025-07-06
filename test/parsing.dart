List<Map<String, dynamic>> keyValueToJSON(String src, String name, {String separator=":", String unnamedTagKey=""}) {
  final List<String> lines = src
      .split("\n")
      .map((line) => line.trim())
      .toList();
  final List<Map<String, dynamic>> result = [];

  Map<String, dynamic>? tempMap;
  List<String> parts;
  int counter = 1;
  String unnamedTagValue = "";
  for (final line in lines) {
    if (line.startsWith("#")) {
      continue;
    }
    if (line.isEmpty && tempMap != null) {
      result.add(tempMap);
      tempMap = null;
      counter++;
      continue;
    }

    if (line.isEmpty) {
      continue;
    }
    if (line.substring(0,1)=="[" && unnamedTagKey != "") {
      unnamedTagValue = line.substring(1,line.length-1);
    }
    if (!line.contains(separator)) {
      continue;
    }
    // at this point we have a sample
    tempMap ??= {"_name": "sample #$counter"};
    if (unnamedTagValue != "") {
      tempMap[unnamedTagKey] = unnamedTagValue;
    }
    parts = line.split(separator).map((part) => part.trim()).toList();
    tempMap[parts[0]] = parts[1].replaceAll("\"", "").trim();
  }

  // check if we still have a sample that wasn't added yet
  if (tempMap != null) {
    tempMap["_name"] = "sample #$counter";
    result.add(tempMap);
  }

  return result;
}
