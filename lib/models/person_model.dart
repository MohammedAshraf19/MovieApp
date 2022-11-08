class PersonModel{
  List<Person>?persons;
  dynamic error;

  PersonModel(this.persons, this.error);

  PersonModel.fromJson(Map<String, dynamic> json,) {
    persons = (json['results'] as List).map((e) =>  Person.fromJson(e)).toList();
    error ='';
  }


}
class Person{
  dynamic id;
  dynamic popularity;
  dynamic name;
  dynamic profileImage;
  dynamic known;
  Person({
    this.id,
    this.name,
    this.profileImage,
    this.known,
    this.popularity,

  });

  Person.fromJson(Map<String, dynamic> json) {
    id= json["id"];
    popularity= json["popularity"];
    profileImage= json["profile_path"];
    name= json["name"];
    known= json["known_for_department"];
  }
}