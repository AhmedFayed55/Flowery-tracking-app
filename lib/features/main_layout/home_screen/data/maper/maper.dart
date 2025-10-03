import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/meta_data_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/order_items_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/orders_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/product_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/store_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/user_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/metadata_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/orderItems_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/product_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/store_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/user_entity.dart';

GetPendingOrdersEntity toGetPendingOrdersEntity(GetPendingOrdersDto dto) =>
    GetPendingOrdersEntity(
      message: dto.message,
      metadata: dto.metadata != null ? toMetadataEntity(dto.metadata!) : null,
      orders: dto.orders?.map(toOrdersEntity).toList() ?? [],
    );

MetadataEntity toMetadataEntity(MetadataDto dto) => MetadataEntity(
  currentPage: dto.currentPage,
  limit: dto.limit,
  totalItems: dto.totalItems,
  totalPages: dto.totalPages,
);

OrderItemsEntity toOrderItemsEntity(OrderItemsDto dto) => OrderItemsEntity(
  id: dto.id,
  price: dto.price,
  product: dto.product != null ? toProductEntity(dto.product!) : null,
  quantity: dto.quantity,
);

OrdersEntity toOrdersEntity(OrdersDto dto) => OrdersEntity(
  id: dto.id,
  createdAt: dto.createdAt,
  isDelivered: dto.isDelivered,
  isPaid: dto.isPaid,
  orderItems: dto.orderItems?.map(toOrderItemsEntity).toList() ?? [],
  orderNumber: dto.orderNumber,
  paymentType: dto.paymentType,
  state: dto.state,
  store: dto.store != null ? toStoreEntity(dto.store!) : null,
  totalPrice: dto.totalPrice,
  updatedAt: dto.updatedAt,
  user: dto.user != null ? toUserEntity(dto.user!) : null,
  v: dto.v,
);

ProductEntity toProductEntity(ProductDto dto) => ProductEntity(
  v: dto.v,
  updatedAt: dto.updatedAt,
  createdAt: dto.createdAt,
  id: dto.id,
  quantity: dto.quantity,
  price: dto.price,
  category: dto.category,
  description: dto.description,
  images: dto.images,
  imgCover: dto.imgCover,
  isSuperAdmin: dto.isSuperAdmin,
  occasion: dto.occasion,
  priceAfterDiscount: dto.priceAfterDiscount,
  slug: dto.slug,
  sold: dto.sold,
  title: dto.title,
);

StoreEntity toStoreEntity(StoreDto dto) => StoreEntity(
  address: dto.address,
  image: dto.image,
  latLong: dto.latLong,
  name: dto.name,
  phoneNumber: dto.phoneNumber,
);

UserEntity toUserEntity(UserDto dto) => UserEntity(
  id: dto.id,
  phone: dto.phone,
  photo: dto.photo,
  email: dto.email,
  firstName: dto.firstName,
  lastName: dto.lastName,
  gender: dto.gender,
);

//  ================= Entity -> DTO ==================

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
