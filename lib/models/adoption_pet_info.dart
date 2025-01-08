class AdoptionPetInfo {
  final String name;
  final String type;
  final double age;
  final String gender;
  final String location;
  final String description;
  final String petURLPhoto;
  final double friendlinessRate;
  final double trainablityRate;
  final double healthRate;
  final double adaptibilityRate;
  final String userId;


  AdoptionPetInfo(
    this.name,
    this.type,
    this.age,
    this.gender,
    this.location,
    this.description,
    this.friendlinessRate,
    this.trainablityRate,
    this.healthRate,
    this.adaptibilityRate,
    this.petURLPhoto, this.userId,
  );

  // Convert to Firestore document
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "type": type,
      "age": age,
      "gender": gender,
      "location": location,
      "description": description,
      "friendlinessRate": friendlinessRate,
      "trainablityRate": trainablityRate,
      "healthRate": healthRate,
      "adaptibilityRate": adaptibilityRate,
      "petURLPhoto":petURLPhoto,
      "userId":userId,

    };
  }

  // Create from Firestore document
  factory AdoptionPetInfo.fromMap(Map<String, dynamic> map) {
    return AdoptionPetInfo(
        map["name"],
        map["type"],
        map["age"].toDouble(),
        map["gender"],
        map["location"],
        map["description"],
        map["friendlinessRate"],
        map["trainablityRate"],
        map["healthRate"],
        map["adaptibilityRate"],
        map["petURLPhoto"],
        map["userId"]??"",

    );
  }
}
