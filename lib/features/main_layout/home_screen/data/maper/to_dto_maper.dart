import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/order_items_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/logged_driver_data/driver_data_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/to_firebase/to_firebase_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orderItems_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/product_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/store_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/to_firebase/to_firebase_entity.dart';

import '../../domain/entities/get_pending_orders/user_entity.dart';
import '../../domain/entities/logged_driver_data/driver_data_entity.dart';
import '../models/get_pending_orders/orders_dto.dart';
import '../models/get_pending_orders/product_dto.dart';
import '../models/get_pending_orders/store_dto.dart';
import '../models/get_pending_orders/user_dto.dart';

OrderItemsDto toOrderItemsDto(OrderItemsEntity entity) => OrderItemsDto(
  id: entity.id,
  price: entity.price!.toInt(),
  product: entity.product != null ? toProductDto(entity.product!) : null,
  quantity: entity.quantity!.toInt(),
);

OrdersDto toOrdersDto(OrdersEntity entity) => OrdersDto(
  id: entity.id,
  createdAt: entity.createdAt,
  isDelivered: entity.isDelivered,
  isPaid: entity.isPaid,
  orderItems: entity.orderItems?.map(toOrderItemsDto).toList(),
  orderNumber: entity.orderNumber,
  paymentType: entity.paymentType,
  state: entity.state,
  store: entity.store != null ? toStoreDto(entity.store!) : null,
  totalPrice: entity.totalPrice!.toInt(),
  updatedAt: entity.updatedAt,
  user: entity.user != null ? toUserDto(entity.user!) : null,
  v: entity.v!.toInt(),
);

ProductDto toProductDto(ProductEntity entity) => ProductDto(
  v: entity.v!.toInt(),
  updatedAt: entity.updatedAt,
  createdAt: entity.createdAt,
  id: entity.id,
  quantity: entity.quantity!.toInt(),
  price: entity.price!.toInt(),
  category: entity.category,
  description: entity.description,
  images: entity.images,
  imgCover: entity.imgCover,
  isSuperAdmin: entity.isSuperAdmin,
  occasion: entity.occasion,
  priceAfterDiscount: entity.priceAfterDiscount!.toInt(),
  slug: entity.slug,
  sold: entity.sold!.toInt(),
  title: entity.title,
);

StoreDto toStoreDto(StoreEntity entity) => StoreDto(
  address: entity.address,
  image: entity.image,
  latLong: entity.latLong,
  name: entity.name,
  phoneNumber: entity.phoneNumber,
);

UserDto toUserDto(UserEntity entity) => UserDto(
  id: entity.id,
  phone: entity.phone,
  photo: entity.photo,
  email: entity.email,
  firstName: entity.firstName,
  lastName: entity.lastName,
  gender: entity.gender,
);

DriverDataDto toDriverDataDto(DriverDataEntity entity) => DriverDataDto(
  id: entity.id,
  phone: entity.phone,
  photo: entity.photo,
  email: entity.email,
  firstName: entity.firstName,
  lastName: entity.lastName,
  vehicleType: entity.vehicleType,
  nId: entity.nid,
  country: entity.country,
  gender: entity.gender,
  nIDImg: entity.nIDImg,
);

ToFirebaseDto toFirebaseDto(ToFirebaseEntity entity) => ToFirebaseDto(
  driverData: entity.driverData != null
      ? toDriverDataDto(entity.driverData!)
      : null,
  driverLocation: null,
  orders: entity.orders != null ? toOrdersDto(entity.orders!) : null,
  userState: AppConstants.inProgress,
);
