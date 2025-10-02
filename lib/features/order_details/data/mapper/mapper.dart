

import 'package:flowery_tracking_app/features/order_details/data/model/order_dto.dart';
import 'package:flowery_tracking_app/features/order_details/data/model/order_items_dto.dart';
import 'package:flowery_tracking_app/features/order_details/data/model/product_dto.dart';
import 'package:flowery_tracking_app/features/order_details/data/model/store_dto.dart';
import 'package:flowery_tracking_app/features/order_details/data/model/user_dto.dart';
import 'package:flowery_tracking_app/features/order_details/domin/entites/order_entity.dart';
import 'package:flowery_tracking_app/features/order_details/domin/entites/order_items_entity.dart';
import 'package:flowery_tracking_app/features/order_details/domin/entites/product_entity.dart';
import 'package:flowery_tracking_app/features/order_details/domin/entites/store_entity.dart';
import 'package:flowery_tracking_app/features/order_details/domin/entites/user_entity.dart';

OrderItemsEntity toOrderItemsEntity(OrderItemsDto dto) => OrderItemsEntity(
  id: dto.id,
  price: dto.price,
  product: toProductEntity(dto.product!),
  quantity: dto.quantity
);

OrdersEntity toOrdersEntity(OrderDto dto) => OrdersEntity(
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