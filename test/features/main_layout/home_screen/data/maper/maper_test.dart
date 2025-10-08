// import 'package:flowery_tracking_app/features/main_layout/home_screen/data/maper/maper.dart';
// import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/meta_data_dto.dart';
// import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/order_items_dto.dart';
// import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/store_dto.dart';
// import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/user_dto.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/get_pending_orders_dto.dart';
// import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/orders_dto.dart';
// import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/product_dto.dart';
// import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders_entity.dart';
// import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/metadata_entity.dart';
// import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/orderItems_entity.dart';
// import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/orders_entity.dart';
// import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/product_entity.dart';
// import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/store_entity.dart';
// import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/user_entity.dart';
//
// void main() {
//
//   group('toGetPendingOrdersEntity', () {
//     test('should return null values', () {
//       GetPendingOrdersDto dto = GetPendingOrdersDto(
//         message: null,
//         metadata: null,
//         orders: null,
//       );
//
//       GetPendingOrdersEntity entity = toGetPendingOrdersEntity(dto);
//
//       expect(entity.message, null);
//       expect(entity.metadata, null);
//       expect(entity.orders, isEmpty);
//     });
//
//     test('should return correct values when dto fields are non-null', () {
//       GetPendingOrdersDto dto = GetPendingOrdersDto(
//         message: "success",
//         metadata: MetadataDto(currentPage: 1),
//         orders: [
//           OrdersDto(
//             id: "1",),
//           OrdersDto(
//             id: "2",),
//         ],
//       );
//
//       GetPendingOrdersEntity entity = toGetPendingOrdersEntity(dto);
//
//       expect(entity.message, dto.message);
//       expect(entity.metadata!.currentPage, dto.metadata!.currentPage);
//       expect(entity.orders!.length, dto.orders!.length);
//     });
//   });
//
//   group('toMetadataEntity', () {
//     test('should return null values when dto fields are null', () {
//       MetadataDto dto = MetadataDto(
//         currentPage: null,
//         limit: null,
//         totalItems: null,
//         totalPages: null,
//       );
//
//       MetadataEntity entity = toMetadataEntity(dto);
//
//       expect(entity.currentPage, null);
//       expect(entity.limit, null);
//       expect(entity.totalItems, null);
//       expect(entity.totalPages, null);
//     });
//
//     test('should return correct values when dto fields are non-null', () {
//       MetadataDto dto = MetadataDto(
//         currentPage: 1,
//         limit: 10,
//         totalItems: 100,
//         totalPages: 10,
//       );
//
//       MetadataEntity entity = toMetadataEntity(dto);
//
//       expect(entity.currentPage, dto.currentPage);
//       expect(entity.limit, dto.limit);
//       expect(entity.totalItems, dto.totalItems);
//       expect(entity.totalPages, dto.totalPages);
//     });
//   });
//
//   group('toOrderItemsEntity', () {
//     test('should return nulls when dto fields are null', () {
//       OrderItemsDto dto = OrderItemsDto(
//         id: null,
//         price: null,
//         product: null,
//         quantity: null,
//       );
//
//       OrderItemsEntity entity = toOrderItemsEntity(dto);
//
//       expect(entity.id, null);
//       expect(entity.price, null);
//       expect(entity.product, null);
//       expect(entity.quantity, null);
//     });
//
//     test('should return correct values when dto fields are non-null', () {
//       ProductDto product = ProductDto(
//         id: "p1",
//         title: "Rose",
//         price: 200,
//       );
//
//       OrderItemsDto dto = OrderItemsDto(
//         id: "oi1",
//         price: 200,
//         product: product,
//         quantity: 2,
//       );
//
//       OrderItemsEntity entity = toOrderItemsEntity(dto);
//
//       expect(entity.id, dto.id);
//       expect(entity.price, dto.price);
//       expect(entity.product!.id, product.id);
//       expect(entity.quantity, dto.quantity);
//     });
//   });
//
//   group('toOrdersEntity', () {
//     test('should return empty lists and nulls when dto fields are null', () {
//       OrdersDto dto = OrdersDto(
//         id: null,
//         createdAt: null,
//         isDelivered: null,
//         isPaid: null,
//         orderItems: null,
//         orderNumber: null,
//         paymentType: null,
//         state: null,
//         store: null,
//         totalPrice: null,
//         updatedAt: null,
//         user: null,
//         v: null,
//       );
//
//       OrdersEntity entity = toOrdersEntity(dto);
//
//       expect(entity.id, null);
//       expect(entity.createdAt, null);
//       expect(entity.isDelivered, null);
//       expect(entity.isPaid, null);
//       expect(entity.orderNumber, null);
//       expect(entity.paymentType, null);
//       expect(entity.state, null);
//       expect(entity.store, null);
//       expect(entity.totalPrice, null);
//       expect(entity.updatedAt, null);
//       expect(entity.user, null);
//       expect(entity.v, null);
//
//     });
//
//     test('should return correct values when dto fields are non-null', () {
//       OrdersDto dto = OrdersDto(
//         id: "1541521",
//         createdAt: "2025-01-01",
//         isDelivered: true,
//         isPaid: true,
//         orderItems: [
//           OrderItemsDto(
//             id: "1",
//             price: 100,
//             product: ProductDto(
//               id: "1",
//               title: "Rose",
//             ),
//             quantity: 2,
//           ),
//           OrderItemsDto(
//             id: "2",
//             price: 100,
//             product: ProductDto(
//               id: "2",
//               title: "Flower",
//             ),
//             quantity: 2,
//           ),
//         ],
//         orderNumber: "123",
//         paymentType: "cash",
//         state: "pending",
//         store: StoreDto(address: "Nasr City"),
//         totalPrice: 200,
//         updatedAt: "2025-01-02",
//         user: UserDto(id: "u1"),
//         v: 1,
//       );
//
//       OrdersEntity entity = toOrdersEntity(dto);
//
//       expect(entity.id, dto.id);
//       expect(entity.createdAt, dto.createdAt);
//       expect(entity.isDelivered, dto.isDelivered);
//       expect(entity.isPaid, dto.isPaid);
//       expect(entity.orderItems!.length, dto.orderItems!.length);
//       expect(entity.orderItems![0].id, dto.orderItems![0].id);
//       expect(entity.orderNumber, dto.orderNumber);
//       expect(entity.paymentType, dto.paymentType);
//       expect(entity.state, dto.state);
//       expect(entity.store!.address, dto.store!.address);
//       expect(entity.totalPrice, dto.totalPrice);
//       expect(entity.updatedAt, dto.updatedAt);
//       expect(entity.user!.id, dto.user!.id);
//       expect(entity.v, dto.v);
//     });
//   });
//
//   group('toProductEntity', () {
//     test('should return null values when dto fields are null', () {
//       ProductDto dto = ProductDto(
//         v: null,
//         updatedAt: null,
//         createdAt: null,
//         id: null,
//         quantity: null,
//         price: null,
//         category: null,
//         description: null,
//         images: null,
//         imgCover: null,
//         isSuperAdmin: null,
//         occasion: null,
//         priceAfterDiscount: null,
//         slug: null,
//         sold: null,
//         title: null,
//       );
//
//       ProductEntity entity = toProductEntity(dto);
//
//       expect(entity.id, null);
//       expect(entity.price, null);
//       expect(entity.title, null);
//       expect(entity.imgCover, null);
//       expect(entity.images, null);
//       expect(entity.category, null);
//       expect(entity.description, null);
//       expect(entity.quantity, null);
//       expect(entity.occasion, null);
//       expect(entity.sold, null);
//       expect(entity.v, null);
//       expect(entity.isSuperAdmin, null);
//       expect(entity.createdAt, null);
//       expect(entity.updatedAt, null);
//       expect(entity.priceAfterDiscount, null);
//       expect(entity.slug, null);
//     });
//
//     test('should return correct values when dto fields are non-null', () {
//       ProductDto dto = ProductDto(
//         v: 1,
//         updatedAt: "2025-01-01",
//         createdAt: "2025-01-01",
//         id: "1",
//         quantity: 10,
//         price: 200,
//         category: "flowers",
//         description: "red roses",
//         images: ["img1", "img2"],
//         imgCover: "cover.jpg",
//         isSuperAdmin: false,
//         occasion: "valentine",
//         priceAfterDiscount: 150,
//         slug: "roses",
//         sold: 5,
//         title: "Red Rose",
//       );
//
//       ProductEntity entity = toProductEntity(dto);
//
//       expect(entity.id, dto.id);
//       expect(entity.title, dto.title);
//       expect(entity.price, dto.price);
//       expect(entity.category, dto.category);
//       expect(entity.images!.length, equals(dto.images!.length));
//       expect(entity.imgCover, dto.imgCover);
//       expect(entity.description, dto.description);
//       expect(entity.quantity, dto.quantity);
//       expect(entity.occasion, dto.occasion);
//       expect(entity.sold, dto.sold);
//       expect(entity.v, dto.v);
//       expect(entity.isSuperAdmin, dto.isSuperAdmin);
//       expect(entity.createdAt, dto.createdAt);
//       expect(entity.updatedAt, dto.updatedAt);
//       expect(entity.priceAfterDiscount, dto.priceAfterDiscount);
//       expect(entity.slug, dto.slug);
//
//     });
//   });
//
//   group('toStoreEntity', () {
//     test('should return null values when dto fields are null', () {
//       StoreDto dto = StoreDto(
//         address: null,
//         image: null,
//         latLong: null,
//         name: null,
//         phoneNumber: null,
//       );
//
//       StoreEntity entity = toStoreEntity(dto);
//
//       expect(entity.address, null);
//       expect(entity.image, null);
//       expect(entity.name, null);
//       expect(entity.phoneNumber, null);
//       expect(entity.latLong, null);
//     });
//
//     test('should return correct values when dto fields are non-null', () {
//       StoreDto dto = StoreDto(
//         address: "Nasr City",
//         image: "shop.jpg",
//         latLong: "31.2514,30.1124",
//         name: "Flower Store",
//         phoneNumber: "0101234567",
//       );
//
//       StoreEntity entity = toStoreEntity(dto);
//
//       expect(entity.address, dto.address);
//       expect(entity.name, dto.name);
//       expect(entity.image, dto.image);
//       expect(entity.phoneNumber, dto.phoneNumber);
//       expect(entity.latLong, dto.latLong);
//     });
//   });
//
//   group('toUserEntity', () {
//     test('should return null values when dto fields are null', () {
//       UserDto dto = UserDto(
//         id: null,
//         phone: null,
//         photo: null,
//         email: null,
//         firstName: null,
//         lastName: null,
//         gender: null,
//       );
//
//       UserEntity entity = toUserEntity(dto);
//
//       expect(entity.id, null);
//       expect(entity.firstName, null);
//       expect(entity.email, null);
//       expect(entity.lastName, null);
//       expect(entity.phone, null);
//       expect(entity.photo, null);
//       expect(entity.gender, null);
//     });
//
//     test('should return correct values when dto fields are non-null', () {
//       UserDto dto = UserDto(
//         id: "u1",
//         phone: "01095343145",
//         photo: "user.jpg",
//         email: "test@mail.com",
//         firstName: "Ahmed",
//         lastName: "Fayed",
//         gender: "male",
//       );
//
//       UserEntity entity = toUserEntity(dto);
//
//       expect(entity.id, dto.id);
//       expect(entity.email, dto.email);
//       expect(entity.firstName, dto.firstName);
//       expect(entity.lastName, dto.lastName);
//       expect(entity.phone, dto.phone);
//       expect(entity.photo, dto.photo);
//       expect(entity.gender, dto.gender);
//     });
//   });
//
// }