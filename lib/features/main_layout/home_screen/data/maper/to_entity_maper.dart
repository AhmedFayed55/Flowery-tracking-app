import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/get_pending_orders_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/meta_data_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/order_items_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/orders_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/product_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/store_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/user_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/logged_driver_data/driver_data_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/get_pending_orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/metadata_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/product_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/store_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/user_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/logged_driver_data/driver_data_entity.dart';

import '../../domain/entities/get_pending_orders/order_items_entity.dart';

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

DriverDataEntity toDriverDataEntity(DriverDataDto dto) => DriverDataEntity(
  id: dto.id,
  lastName: dto.lastName,
  gender: dto.gender,
  firstName: dto.firstName,
  email: dto.email,
  photo: dto.photo,
  phone: dto.phone,
  country: dto.country,
  nid: dto.nId,
  nIDImg: dto.nIDImg,
  vehicleType: dto.vehicleType,
);
