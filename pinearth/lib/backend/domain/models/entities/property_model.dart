
import 'user_model.dart';

class PropertyModel {
    final int id;
    final UserModel owner;
    final String title;
    final String desc;
    final String propertyType;
    final int noOfRooms;
    final int noOfBathrooms;
    final int lotSize;
    final String address;
    final String propertyStatus;
    final String propertyPrice;
    final String incomePerMonth;
    final int yearsBuilt;
    final int yearsRenovated;
    final int yearsReconstructed;
    final String parkingSpace;
    final String appliance;
    final String location;
    final String role;
    final bool available;
    final DateTime createdAt;
    final List<HouseView> houseView;
    final List<LivingRoom> livingRoom;
    final List<BedRoom> bedRoom;
    final List<Toilet> toilet;
    final List<Kitchen> kitchen;
    final List<Document> documents;
    final List<HousePlan> housePlan;
    final List<Size> size;
    final List<dynamic> reviews;

    PropertyModel({
        required this.id,
        required this.owner,
        required this.title,
        required this.desc,
        required this.propertyType,
        required this.noOfRooms,
        required this.noOfBathrooms,
        required this.lotSize,
        required this.address,
        required this.propertyStatus,
        required this.propertyPrice,
        required this.incomePerMonth,
        required this.yearsBuilt,
        required this.yearsRenovated,
        required this.yearsReconstructed,
        required this.parkingSpace,
        required this.appliance,
        required this.location,
        required this.role,
        required this.available,
        required this.createdAt,
        required this.houseView,
        required this.livingRoom,
        required this.bedRoom,
        required this.toilet,
        required this.kitchen,
        required this.documents,
        required this.housePlan,
        required this.size,
        required this.reviews,
    });

    factory PropertyModel.fromJson(Map<String, dynamic> json) => PropertyModel(
        id: json["id"],
        owner: UserModel.fromJson(json["owner"]),
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
        appliance: json["appliance"],
        location: json["location"],
        role: json["role"],
        available: json["available"],
        createdAt: DateTime.parse(json["created_at"]),
        houseView: List<HouseView>.from(json["house_view"].map((x) => HouseView.fromJson(x))),
        livingRoom: List<LivingRoom>.from(json["living_room"].map((x) => LivingRoom.fromJson(x))),
        bedRoom: List<BedRoom>.from(json["bed_room"].map((x) => BedRoom.fromJson(x))),
        toilet: List<Toilet>.from(json["toilet"].map((x) => Toilet.fromJson(x))),
        kitchen: List<Kitchen>.from(json["kitchen"].map((x) => Kitchen.fromJson(x))),
        documents: List<Document>.from(json["documents"].map((x) => Document.fromJson(x))),
        housePlan: List<HousePlan>.from(json["house_plan"].map((x) => HousePlan.fromJson(x))),
        size: List<Size>.from(json["size"].map((x) => Size.fromJson(x))),
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "owner": owner.toJson(),
        "title": title,
        "desc": desc,
        "property_type": propertyType,
        "no_of_rooms": noOfRooms,
        "no_of_bathrooms": noOfBathrooms,
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
        "available": available,
        "created_at": createdAt.toIso8601String(),
        "house_view": List<dynamic>.from(houseView.map((x) => x.toJson())),
        "living_room": List<dynamic>.from(livingRoom.map((x) => x.toJson())),
        "bed_room": List<dynamic>.from(bedRoom.map((x) => x.toJson())),
        "toilet": List<dynamic>.from(toilet.map((x) => x.toJson())),
        "kitchen": List<dynamic>.from(kitchen.map((x) => x.toJson())),
        "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
        "house_plan": List<dynamic>.from(housePlan.map((x) => x.toJson())),
        "size": List<dynamic>.from(size.map((x) => x.toJson())),
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
    };
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