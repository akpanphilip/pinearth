import 'agent_model.dart';
import 'user_model.dart';

class PropertyModel {
  final int id;
  final UserModel owner;
  final AgentModel? agent;
  final AgentModel? developer;
  final AgentModel? landlord;
  final String? title;
  final String? desc;
  final String? propertyType;
  final int? noOfRooms;
  final int? noOfBathrooms;
  final int? lotSize;
  final String? address;
  final String? propertyStatus;
  final String? propertyPrice;
  final String? incomePerMonth;
  final int? yearsBuilt;
  final int? yearsRenovated;
  final int? yearsReconstructed;
  final String? parkingSpace;
  final String? appliance;
  final List<Appliances> appliances;
  final String? location;
  final String? role;
  final bool? available;
  final DateTime? createdAt;
  final List<HouseView> houseView;
  final List<LivingRoom> livingRoom;
  final List<BedRoom> bedRoom;
  final List<Toilet> toilet;
  final List<Kitchen> kitchen;
  final List<Document> documents;
  final List<HousePlan> housePlan;
  final List<Size> size;
  final List<ReviewModel>? reviews;
  final String? duration;

  PropertyModel({
    required this.id,
    required this.owner,
    this.agent,
    this.title,
    this.desc,
    this.propertyType,
    this.noOfRooms,
    this.noOfBathrooms,
    this.lotSize,
    this.duration,
    this.address,
    this.propertyStatus,
    this.appliances = const <Appliances>[],
    this.propertyPrice,
    this.incomePerMonth,
    this.yearsBuilt,
    this.yearsRenovated,
    this.yearsReconstructed,
    this.parkingSpace,
    this.appliance,
    this.location,
    this.role,
    this.available,
    this.createdAt,
    required this.houseView,
    required this.livingRoom,
    required this.bedRoom,
    required this.toilet,
    required this.kitchen,
    required this.documents,
    required this.housePlan,
    required this.size,
    this.developer,
    this.landlord,
    this.reviews,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    AgentModel? agent;

    if (json["agent"] != null) {
      agent = AgentModel.fromJson(json["agent"]);
    } else if (json["developer"] != null) {
      agent = AgentModel.fromJson(json["developer"]);
    } else if (json["landlord"] != null) {
      agent = AgentModel.fromJson(json["landlord"]);
    } else if (json["hotel"] != null) {
      agent = AgentModel.fromJson(json["hotel"]);
    } else if (json["short_let"] != null) {
      agent = AgentModel.fromJson(json["hotel"]);
    }

    return PropertyModel(
      id: json["id"],
      owner: UserModel.fromJson(json["owner"]),
      agent: agent,
      developer: (json["developer"] == null)
          ? null
          : AgentModel.fromJson(json["developer"]),
      landlord: (json["landlord"] == null)
          ? null
          : AgentModel.fromJson(json["landlord"]),
      title: json["title"],
      desc: json["desc"],
      propertyType: json["property_type"],
      noOfRooms: json["no_of_rooms"],
      noOfBathrooms: json["no_of_bathrooms"],
      lotSize: json["lot_size"],
      address: json["address"],
      propertyStatus: json["property_status"],
      propertyPrice: json["property_price"],
      incomePerMonth: json["income_per_month"],
      yearsBuilt: json["years_built"],
      yearsRenovated: json["years_renovated"],
      yearsReconstructed: json["years_reconstructed"],
      parkingSpace: json["parking_space"],
      duration: json["duration"],
      appliance: json["appliance"],
      appliances: (json["appliances"] != null)
          ? List.from((json["appliances"]))
              .map((e) => Appliances.fromJson(e))
              .toList()
          : [],
      location: json["location"],
      role: json["role"],
      available: json["available"],
      createdAt: DateTime.parse(json["created_at"]),
      houseView: List<HouseView>.from(
          json["house_view"].map((x) => HouseView.fromJson(x))),
      livingRoom: List<LivingRoom>.from(
          json["living_room"].map((x) => LivingRoom.fromJson(x))),
      bedRoom:
          List<BedRoom>.from(json["bed_room"].map((x) => BedRoom.fromJson(x))),
      toilet: List<Toilet>.from(json["toilet"].map((x) => Toilet.fromJson(x))),
      kitchen:
          List<Kitchen>.from(json["kitchen"].map((x) => Kitchen.fromJson(x))),
      documents: List<Document>.from(
          json["documents"].map((x) => Document.fromJson(x))),
      housePlan: List<HousePlan>.from(
          json["house_plan"].map((x) => HousePlan.fromJson(x))),
      size: List<Size>.from(json["size"].map((x) => Size.fromJson(x))),
      reviews: (json["reviews"] == null)
          ? null
          : List<ReviewModel>.from(
              json["reviews"].map((x) => ReviewModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "owner": owner.toJson(),
        "title": title,
        "desc": desc,
        "property_type": propertyType,
        "no_of_rooms": noOfRooms,
        "no_of_bathrooms": noOfBathrooms,
        "duration": duration,
        "lot_size": lotSize,
        "address": address,
        "property_status": propertyStatus,
        "property_price": propertyPrice,
        "income_per_month": incomePerMonth,
        "years_built": yearsBuilt,
        "years_renovated": yearsRenovated,
        "years_reconstructed": yearsReconstructed,
        "parking_space": parkingSpace,
        "appliance": appliance,
        "location": location,
        "role": role,
        "appliances": appliances.map((e) => e.toJson()).toList(),
        "agent": (agent == null) ? null : agent!.toJson(),
        "available": available,
        "created_at": createdAt?.toIso8601String(),
        "house_view": List<dynamic>.from(houseView.map((x) => x.toJson())),
        "living_room": List<dynamic>.from(livingRoom.map((x) => x.toJson())),
        "bed_room": List<dynamic>.from(bedRoom.map((x) => x.toJson())),
        "toilet": List<dynamic>.from(toilet.map((x) => x.toJson())),
        "kitchen": List<dynamic>.from(kitchen.map((x) => x.toJson())),
        "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
        "house_plan": List<dynamic>.from(housePlan.map((x) => x.toJson())),
        "size": List<dynamic>.from(size.map((x) => x.toJson())),
        "comments": (reviews == null)
            ? null
            : List<UserModel>.from(reviews!.map((x) => x.toJson())),
      };
}

class Appliances {
  final int? id;
  final String? name;

  const Appliances({this.id, this.name});

  Appliances.fromJson(dynamic json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class BedRoom {
  final String bedRoom;

  BedRoom({
    required this.bedRoom,
  });

  factory BedRoom.fromJson(Map<String, dynamic> json) => BedRoom(
        bedRoom: json["bed_room"],
      );

  Map<String, dynamic> toJson() => {
        "bed_room": bedRoom,
      };
}

class Document {
  final String documents;

  Document({
    required this.documents,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        documents: json["documents"],
      );

  Map<String, dynamic> toJson() => {
        "documents": documents,
      };
}

class HousePlan {
  final String housePlan;

  HousePlan({
    required this.housePlan,
  });

  factory HousePlan.fromJson(Map<String, dynamic> json) => HousePlan(
        housePlan: json["house_plan"],
      );

  Map<String, dynamic> toJson() => {
        "house_plan": housePlan,
      };
}

class HouseView {
  final String houseView;

  HouseView({
    required this.houseView,
  });

  factory HouseView.fromJson(Map<String, dynamic> json) => HouseView(
        houseView: json["house_view"],
      );

  Map<String, dynamic> toJson() => {
        "house_view": houseView,
      };
}

class Kitchen {
  final String kitchen;

  Kitchen({
    required this.kitchen,
  });

  factory Kitchen.fromJson(Map<String, dynamic> json) => Kitchen(
        kitchen: json["kitchen"],
      );

  Map<String, dynamic> toJson() => {
        "kitchen": kitchen,
      };
}

class LivingRoom {
  final String livingRoom;

  LivingRoom({
    required this.livingRoom,
  });

  factory LivingRoom.fromJson(Map<String, dynamic> json) => LivingRoom(
        livingRoom: json["living_room"],
      );

  Map<String, dynamic> toJson() => {
        "living_room": livingRoom,
      };
}

class Size {
  final String size;

  Size({
    required this.size,
  });

  factory Size.fromJson(Map<String, dynamic> json) => Size(
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "size": size,
      };
}

class Toilet {
  final String toilet;

  Toilet({
    required this.toilet,
  });

  factory Toilet.fromJson(Map<String, dynamic> json) => Toilet(
        toilet: json["toilet"],
      );

  Map<String, dynamic> toJson() => {
        "toilet": toilet,
      };
}

class ReviewModel {
  final int? id;
  final UserModel? userModel;
  final String? comment;
  final int? rate;
  final String? createdAt;

  ReviewModel({
    this.id,
    this.userModel,
    this.comment,
    this.rate,
    this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
      id: json['id'],
      userModel:
          (json["user"] == null) ? null : UserModel.fromJson(json["user"]),
      comment: json['comment'],
      rate: json['rate'],
      createdAt: json['created_at']);

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "rate": rate,
        "created_at": createdAt,
        "id": id,
        "user": (userModel == null) ? null : userModel!.toJson()
      };
}
