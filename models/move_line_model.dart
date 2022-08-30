class MoveLineModel {
  final id;
  final date;
  final reference;
  final product_id;
  final location_id;
  final location_dest_id;
  final product_uom_qty;
  final qty_done;
  final lot_id;
  final package_id;
  final result_package_id;
  MoveLineModel({
    required this.id, 
    required this.date, 
    required this.reference, 
    required this.product_id, 
    required this.location_id, 
    required this.location_dest_id, 
    required this.product_uom_qty, 
    required this.qty_done, 
    required this.lot_id, 
    required this.package_id, 
    required this.result_package_id});
  factory MoveLineModel.fromJson(Map<String, dynamic> json) =>
      MoveLineModel(
          id: json['id'],
          date: json['date'],
          reference: json['reference'],
          product_id: json['product_id'],
          location_id: json['location_id'],
          location_dest_id: json['location_dest_id'],
          product_uom_qty: json['product_uom_qty'],
          qty_done: json['qty_done'],
          lot_id: json['lot_id'],
          package_id: json['package_id'],
          result_package_id: json['result_package_id']
      );          

          
}

