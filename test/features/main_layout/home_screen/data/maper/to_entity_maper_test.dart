import 'package:flowery_tracking_app/features/main_layout/home_screen/data/maper/to_entity_maper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/get_pending_orders_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/meta_data_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/order_items_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/orders_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/product_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/store_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/get_pending_orders/user_dto.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/models/logged_driver_data/driver_data_dto.dart';

void main() {
  group('toMetadataEntity', () {
    test('when dto has null values should return entity with null values', () {
      var dto = MetadataDto(
        currentPage: null,
        limit: null,
        totalItems: null,
        totalPages: null,
      );

      var entity = toMetadataEntity(dto);

      expect(entity.currentPage, dto.currentPage);
      expect(entity.limit, dto.limit);
      expect(entity.totalItems, dto.totalItems);
      expect(entity.totalPages, dto.totalPages);
    });

    test('when dto has non-null values should map correctly', () {
      var dto = MetadataDto(
        currentPage: 1,
        limit: 10,
        totalItems: 50,
        totalPages: 5,
      );

      var entity = toMetadataEntity(dto);

      expect(entity.currentPage, dto.currentPage);
      expect(entity.limit, dto.limit);
      expect(entity.totalItems, dto.totalItems);
      expect(entity.totalPages, dto.totalPages);
    });
  });

  group('toProductEntity', () {
    test('when dto has null values should return entity with null values', () {
      var dto = ProductDto(
        id: null,
        v: null,
        updatedAt: null,
        createdAt: null,
        quantity: null,
        price: null,
        category: null,
        description: null,
        images: null,
        imgCover: null,
        isSuperAdmin: null,
        occasion: null,
        priceAfterDiscount: null,
        slug: null,
        sold: null,
        title: null,
      );

      var entity = toProductEntity(dto);

      expect(entity.id, dto.id);
      expect(entity.v, dto.v);
      expect(entity.updatedAt, dto.updatedAt);
      expect(entity.createdAt, dto.createdAt);
      expect(entity.quantity, dto.quantity);
      expect(entity.price, dto.price);
      expect(entity.category, dto.category);
      expect(entity.description, dto.description);
      expect(entity.images, dto.images);
      expect(entity.imgCover, dto.imgCover);
      expect(entity.isSuperAdmin, dto.isSuperAdmin);
      expect(entity.occasion, dto.occasion);
      expect(entity.priceAfterDiscount, dto.priceAfterDiscount);
      expect(entity.slug, dto.slug);
      expect(entity.sold, dto.sold);
      expect(entity.title, dto.title);
    });

    test('when dto has non-null values should map correctly', () {
      var dto = ProductDto(
        id: 'P1',
        title: 'Rose',
        price: 100,
        quantity: 5,
        v: 1,
      );

      var entity = toProductEntity(dto);

      expect(entity.id, dto.id);
      expect(entity.title, dto.title);
      expect(entity.price, dto.price);
      expect(entity.quantity, dto.quantity);
      expect(entity.v, dto.v);
    });
  });

  group('toStoreEntity', () {
    test('when dto has null values should return entity with null values', () {
      var dto = StoreDto(
        name: null,
        address: null,
        latLong: null,
        phoneNumber: null,
        image: null,
      );

      var entity = toStoreEntity(dto);

      expect(entity.name, dto.name);
      expect(entity.address, dto.address);
      expect(entity.latLong, dto.latLong);
      expect(entity.phoneNumber, dto.phoneNumber);
      expect(entity.image, dto.image);
    });

    test('when dto has non-null values should map correctly', () {
      var dto = StoreDto(
        name: 'Flower Store',
        address: 'Cairo',
        latLong: '30,31',
        phoneNumber: '123456789',
        image: 'image.png',
      );

      var entity = toStoreEntity(dto);

      expect(entity.name, dto.name);
      expect(entity.address, dto.address);
      expect(entity.latLong, dto.latLong);
      expect(entity.phoneNumber, dto.phoneNumber);
      expect(entity.image, dto.image);
    });
  });

  group('toUserEntity', () {
    test('when dto has null values should return entity with null values', () {
      var dto = UserDto(
        id: null,
        firstName: null,
        lastName: null,
        email: null,
        phone: null,
        gender: null,
        photo: null,
      );

      var entity = toUserEntity(dto);

      expect(entity.id, dto.id);
      expect(entity.firstName, dto.firstName);
      expect(entity.lastName, dto.lastName);
      expect(entity.email, dto.email);
      expect(entity.phone, dto.phone);
      expect(entity.gender, dto.gender);
      expect(entity.photo, dto.photo);
    });

    test('when dto has non-null values should map correctly', () {
      var dto = UserDto(
        id: 'U1',
        firstName: 'Ahmed',
        lastName: 'Faid',
        email: 'a@a.com',
        phone: '0100000',
        gender: 'male',
        photo: 'user.png',
      );

      var entity = toUserEntity(dto);

      expect(entity.id, dto.id);
      expect(entity.firstName, dto.firstName);
      expect(entity.lastName, dto.lastName);
      expect(entity.email, dto.email);
      expect(entity.phone, dto.phone);
      expect(entity.gender, dto.gender);
      expect(entity.photo, dto.photo);
    });
  });

  group('toDriverDataEntity', () {
    test('when dto has null values should return entity with null values', () {
      var dto = DriverDataDto(
        id: null,
        firstName: null,
        lastName: null,
        email: null,
        vehicleType: null,
        country: null,
        nId: null,
        gender: null,
        nIDImg: null,
        phone: null,
        photo: null,
      );

      var entity = toDriverDataEntity(dto);

      expect(entity.id, dto.id);
      expect(entity.firstName, dto.firstName);
      expect(entity.lastName, dto.lastName);
      expect(entity.email, dto.email);
      expect(entity.vehicleType, dto.vehicleType);
      expect(entity.country, dto.country);
      expect(entity.nid, dto.nId);
      expect(entity.gender, dto.gender);
      expect(entity.nIDImg, dto.nIDImg);
      expect(entity.phone, dto.phone);
      expect(entity.photo, dto.photo);
    });

    test('when dto has non-null values should map correctly', () {
      var dto = DriverDataDto(
        id: 'D1',
        firstName: 'Ahmed',
        lastName: 'Faid',
        email: 'a@a.com',
        vehicleType: 'Car',
        country: 'Egypt',
        nId: '12345',
        gender: 'male',
        nIDImg: 'nid.png',
        phone: '0100000',
        photo: 'driver.png',
      );

      var entity = toDriverDataEntity(dto);

      expect(entity.id, dto.id);
      expect(entity.firstName, dto.firstName);
      expect(entity.lastName, dto.lastName);
      expect(entity.email, dto.email);
      expect(entity.vehicleType, dto.vehicleType);
      expect(entity.country, dto.country);
      expect(entity.nid, dto.nId);
      expect(entity.gender, dto.gender);
      expect(entity.nIDImg, dto.nIDImg);
      expect(entity.phone, dto.phone);
      expect(entity.photo, dto.photo);
    });
  });

  group('toOrdersEntity', () {
    test(
      'when dto has null values should return entity with default/null-safe values',
      () {
        var dto = OrdersDto(
          id: null,
          createdAt: null,
          isDelivered: null,
          isPaid: null,
          orderItems: null,
          orderNumber: null,
          paymentType: null,
          state: null,
          store: null,
          totalPrice: null,
          updatedAt: null,
          user: null,
          v: null,
        );

        var entity = toOrdersEntity(dto);

        expect(entity.id, dto.id);
        expect(entity.createdAt, dto.createdAt);
        expect(entity.isDelivered, dto.isDelivered);
        expect(entity.isPaid, dto.isPaid);
        expect(entity.orderItems, []);
        expect(entity.orderNumber, dto.orderNumber);
        expect(entity.paymentType, dto.paymentType);
        expect(entity.state, dto.state);
        expect(entity.store, null);
        expect(entity.totalPrice, dto.totalPrice);
        expect(entity.updatedAt, dto.updatedAt);
        expect(entity.user, null);
        expect(entity.v, dto.v);
      },
    );

    test('when dto has values should map correctly', () {
      var dto = OrdersDto(
        id: 'O1',
        createdAt: '2025-10-14',
        isDelivered: false,
        isPaid: true,
        orderNumber: '123',
        paymentType: 'cash',
        totalPrice: 200,
        v: 2,
        orderItems: [OrderItemsDto(id: 'I1')],
      );

      var entity = toOrdersEntity(dto);

      expect(entity.id, dto.id);
      expect(entity.createdAt, dto.createdAt);
      expect(entity.isDelivered, dto.isDelivered);
      expect(entity.isPaid, dto.isPaid);
      expect(entity.orderNumber, dto.orderNumber);
      expect(entity.paymentType, dto.paymentType);
      expect(entity.totalPrice, dto.totalPrice);
      expect(entity.v, dto.v);
      expect(entity.orderItems?.first.id, dto.orderItems?.first.id);
    });
  });

  group('toOrderItemsEntity', () {
    test('when dto has null values should return entity with null values', () {
      var dto = OrderItemsDto(
        id: null,
        price: null,
        quantity: null,
        product: null,
      );

      var entity = toOrderItemsEntity(dto);

      expect(entity.id, dto.id);
      expect(entity.price, dto.price);
      expect(entity.quantity, dto.quantity);
      expect(entity.product, dto.product);
    });

    test('when dto has non-null values should map correctly', () {
      var dto = OrderItemsDto(
        id: 'I1',
        price: 50,
        quantity: 2,
        product: ProductDto(id: 'P1'),
      );

      var entity = toOrderItemsEntity(dto);

      expect(entity.id, dto.id);
      expect(entity.price, dto.price);
      expect(entity.quantity, dto.quantity);
      expect(entity.product?.id, dto.product?.id);
    });
  });

  group('toGetPendingOrdersEntity', () {
    test(
      'when dto has null values should return entity with null/default values',
      () {
        var dto = GetPendingOrdersDto(
          message: null,
          metadata: null,
          orders: null,
        );

        var entity = toGetPendingOrdersEntity(dto);

        expect(entity.message, dto.message);
        expect(entity.metadata, null);
        expect(entity.orders, []);
      },
    );

    test('when dto has non-null values should map correctly', () {
      var dto = GetPendingOrdersDto(
        message: 'Success',
        metadata: MetadataDto(totalPages: 5),
        orders: [OrdersDto(id: 'O1')],
      );

      var entity = toGetPendingOrdersEntity(dto);

      expect(entity.message, dto.message);
      expect(entity.metadata?.totalPages, dto.metadata?.totalPages);
      expect(entity.orders?.first.id, dto.orders?.first.id);
    });
  });
}
