String removeSpacesAndTabs(String inputText) {
  // Define a regular expression to match consecutive spaces and tabs
  final regex = RegExp(r'\s+');

  // Use the replaceAll method to replace all matches with a single space
  final cleanedText = inputText.replaceAll(regex, ' ');

  return cleanedText;
}
