
class PickingModel {
    PickingModel({
        required this.id,
        required this.name,
        required this.partnerId,
        required this.pickingTypeId,
        required this.locationId,
        required this.locationDestId,
        required this.moveLineIds,
        required this.scheduledDate,
        required this.dateDeadline,
        required this.origin,
    });

    final id;
    final name;
    final partnerId;
    final pickingTypeId;
    final locationId;
    final locationDestId;
    final moveLineIds;
    final scheduledDate;
    final dateDeadline;
    final origin;

    factory PickingModel.fromJson(Map<String, dynamic> json) => PickingModel(
        id: json["id"],
        name: json["name"],
        partnerId: json["partner_id"],
        pickingTypeId: json["picking_type_id"],
        locationId: json["location_id"],
        locationDestId: json["location_dest_id"],
        moveLineIds: List<int>.from(json["move_line_ids"].map((x) => x)).join(','),
        scheduledDate: DateTime.parse(json["scheduled_date"]),
        dateDeadline: json["date_deadline"],
        origin: json["origin"],
    );

}

