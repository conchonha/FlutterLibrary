class Country {
  int? id;
  String? name;
  String? emoji;
  String? emojiU;
  List<City>? city;

  Country({this.id, this.name, this.emoji, this.emojiU, this.city});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emoji = json['emoji'];
    emojiU = json['emojiU'];
    if (json['state'] != null) {
      city = <City>[];
      json['state'].forEach((v) {
        city!.add(City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['emoji'] = emoji;
    data['emojiU'] = emojiU;
    if (city != null) {
      data['state'] = city!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  int? id;
  String? name;
  int? countryId;
  List<District>? districts;

  City({this.id, this.name, this.countryId, this.districts});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
    if (json['city'] != null) {
      districts = <District>[];
      json['city'].forEach((v) {
        districts!.add(District.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_id'] = countryId;
    if (districts != null) {
      data['city'] = districts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class District {
  int? id;
  String? name;
  int? stateId;

  District({this.id, this.name, this.stateId});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stateId = json['state_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['state_id'] = stateId;
    return data;
  }
}
