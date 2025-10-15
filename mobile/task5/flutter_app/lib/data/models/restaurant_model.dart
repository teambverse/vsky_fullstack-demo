import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

@JsonSerializable()
class RestaurantModel {
  final String? id;
  final String? name;
  final String? address;

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  final dynamic rating; // 👈 made dynamic

  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @JsonKey(name: 'menu_items_count')
  final int? menuItemsCount;

  RestaurantModel({
    this.id,
    this.name,
    this.address,
    this.phoneNumber,
    this.rating,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.menuItemsCount,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  /// Converts both `String` and `num` to `double`
  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
