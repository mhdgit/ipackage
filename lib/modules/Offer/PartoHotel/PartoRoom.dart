
class PartoRoom {
  String name;
  int adultCount;
  int childCount;
  int childAges;
  String mealType;
  bool sharingBedding;
  String bedGroups;

  PartoRoom({
    this.name,
    this.adultCount,
    this.childCount,
    this.childAges,
    this.mealType,
    this.sharingBedding,
    this.bedGroups,
  });

  factory PartoRoom.fromJson(Map<String, dynamic> json) {

    return PartoRoom(
      name: json['Name'] as String,
      adultCount: json['AdultCount'] as int,
      childCount: json['ChildCount'] as int,
      childAges: json['ChildAges'] as int,
      mealType: json['MealType'] as String,
      sharingBedding: json['SharingBedding'] as bool,
      bedGroups: json['BedGroups'] as String,
    );
  }
}
