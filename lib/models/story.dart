class Story {
  final String title;
  final String description;
  final String urlPhoto;

  Story(this.title, this.urlPhoto, this.description);

  // Convert to Firestore document
  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "URLPhoto": urlPhoto,
    };
  }

  // Create from Firestore document
  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      map["title"],
      map["description"],
      map["urlPhoto"],
    );
  }
}
