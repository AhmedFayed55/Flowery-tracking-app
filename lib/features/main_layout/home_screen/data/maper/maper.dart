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

GetPendingOrdersEntity toGetPendingOrdersEntity(GetPendingOrdersDto dto) => GetPendingOrdersEntity(
    message: dto.message,
    metadata: toMetadataEntity(dto.metadata!),
    orders: dto.orders?.map(toOrdersEntity).toList()
  );

MetadataEntity toMetadataEntity(MetadataDto dto) => MetadataEntity(
  currentPage: dto.currentPage,
  limit: dto.limit,
  totalItems: dto.totalItems,
  totalPages: dto.totalPages
);

OrderItemsEntity toOrderItemsEntity(OrderItemsDto dto) => OrderItemsEntity(
  id: dto.id,
  price: dto.price,
  product: toProductEntity(dto.product!),
  quantity: dto.quantity
);

OrdersEntity toOrdersEntity(OrdersDto dto) => OrdersEntity(
  id: dto.id,
  createdAt: dto.createdAt,
  isDelivered: dto.isDelivered,
  isPaid: dto.isPaid,
  orderItems: dto.orderItems?.map(toOrderItemsEntity).toList(),
  orderNumber: dto.orderNumber,
  paymentType: dto.paymentType,
  state: dto.state,
  store: toStoreEntity(dto.store!),
  totalPrice: dto.totalPrice,
  updatedAt: dto.updatedAt,
  user: toUserEntity(dto.user!),
  v: dto.v
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
  title: dto.title
);

StoreEntity toStoreEntity(StoreDto dto) => StoreEntity(
  address: dto.address,
  image: dto.image,
  latLong: dto.latLong,
  name: dto.name,
  phoneNumber: dto.phoneNumber
);

UserEntity toUserEntity(UserDto dto) => UserEntity(
  id: dto.id,
  phone: dto.phone,
  photo: dto.photo,
  email: dto.email,
  firstName: dto.firstName,
  lastName: dto.lastName,
  gender: dto.gender
);