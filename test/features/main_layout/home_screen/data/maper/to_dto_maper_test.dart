import 'package:flowery_tracking_app/core/utils/constants.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/data/maper/to_dto_maper.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/order_items_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/orders_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/product_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/store_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/get_pending_orders/user_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/logged_driver_data/driver_data_entity.dart';
import 'package:flowery_tracking_app/features/main_layout/home_screen/domain/entities/to_firebase/to_firebase_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('toOrderItemsDto', () {
    test('when entity has null values should return dto with null values', () {
      var entity = OrderItemsEntity(
        id: null,
        price: null,
        product: null,
        quantity: null,
      );

      var dto = toOrderItemsDto(entity);

      expect(dto.id, null);
      expect(dto.price, null);
      expect(dto.product, null);
      expect(dto.quantity, null);
    });

    test('when entity has non-null values should map correctly', () {
      var entity = OrderItemsEntity(
        id: '1',
        price: 50,
        quantity: 2,
        product: ProductEntity(id: '6554'),
      );

      var dto = toOrderItemsDto(entity);

      expect(dto.id, entity.id);
      expect(dto.price, entity.price);
      expect(dto.quantity, entity.quantity);
      expect(dto.product?.id, entity.product?.id);
    });
  });

  group('toOrdersDto', () {
    test('when entity is null should handle gracefully', () {
      var entity = OrdersEntity(
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

      var dto = toOrdersDto(entity);

      expect(dto.id, null);
      expect(dto.createdAt, null);
      expect(dto.isDelivered, null);
      expect(dto.isPaid, null);
      expect(dto.orderItems, null);
      expect(dto.orderNumber, null);
      expect(dto.paymentType, null);
      expect(dto.state, null);
      expect(dto.store, null);
      expect(dto.totalPrice, null);
      expect(dto.updatedAt, null);
      expect(dto.user, null);
      expect(dto.v, null);
    });

    test('when entity has non-null values should map correctly', () {
      var entity = OrdersEntity(
        id: '3651',
        createdAt: '2025-10-14',
        isDelivered: true,
        isPaid: true,
        orderItems: [OrderItemsEntity(id: '65154')],
        orderNumber: '123',
        paymentType: 'cash',
        state: 'inProgress',
        store: StoreEntity(name: 'FlowerShop'),
        totalPrice: 200,
        updatedAt: '2025-10-14',
        user: UserEntity(firstName: 'Ahmed'),
        v: 1,
      );

      var dto = toOrdersDto(entity);

      expect(dto.id, entity.id);
      expect(dto.createdAt, entity.createdAt);
      expect(dto.isDelivered, entity.isDelivered);
      expect(dto.isPaid, entity.isPaid);
      expect(dto.orderItems?.length, entity.orderItems?.length);
      expect(dto.orderNumber, entity.orderNumber);
      expect(dto.paymentType, entity.paymentType);
      expect(dto.state, entity.state);
      expect(dto.store?.name, entity.store?.name);
      expect(dto.totalPrice, entity.totalPrice);
      expect(dto.updatedAt, entity.updatedAt);
      expect(dto.user?.firstName, entity.user?.firstName);
      expect(dto.v, entity.v);
    });
  });

  group('toProductDto', () {
    test(
      'when entity has null values should return dto with default values',
      () {
        var entity = ProductEntity(
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

        var dto = toProductDto(entity);

        expect(dto.id, null);
        expect(dto.v, null);
        expect(dto.updatedAt, null);
        expect(dto.createdAt, null);
        expect(dto.quantity, null);
        expect(dto.price, null);
        expect(dto.category, null);
        expect(dto.description, null);
        expect(dto.images, null);
        expect(dto.imgCover, null);
        expect(dto.isSuperAdmin, null);
        expect(dto.occasion, null);
        expect(dto.priceAfterDiscount, null);
        expect(dto.slug, null);
        expect(dto.sold, null);
        expect(dto.title, null);
      },
    );

    test('when entity has values should map correctly', () {
      var entity = ProductEntity(
        id: '1',
        v: 2,
        updatedAt: '2025-01-10',
        createdAt: '2025-01-05',
        quantity: 10,
        price: 50,
        category: 'Roses',
        description: 'Red Tulip',
        images: ['img1.png', 'img2.png'],
        imgCover: 'cover.png',
        isSuperAdmin: false,
        occasion: 'Valentine',
        priceAfterDiscount: 40,
        slug: 'tulip-flowers',
        sold: 5,
        title: 'Tulip',
      );

      var dto = toProductDto(entity);

      expect(dto.id, entity.id);
      expect(dto.v, entity.v);
      expect(dto.updatedAt, entity.updatedAt);
      expect(dto.createdAt, entity.createdAt);
      expect(dto.quantity, entity.quantity);
      expect(dto.price, entity.price);
      expect(dto.category, entity.category);
      expect(dto.description, entity.description);
      expect(dto.images, entity.images);
      expect(dto.imgCover, entity.imgCover);
      expect(dto.isSuperAdmin, entity.isSuperAdmin);
      expect(dto.occasion, entity.occasion);
      expect(dto.priceAfterDiscount, entity.priceAfterDiscount);
      expect(dto.slug, entity.slug);
      expect(dto.sold, entity.sold);
      expect(dto.title, entity.title);
    });
  });

  group('toStoreDto', () {
    test('when entity has null values should return dto with null values', () {
      var entity = StoreEntity(
        address: null,
        image: null,
        latLong: null,
        name: null,
        phoneNumber: null,
      );

      var dto = toStoreDto(entity);

      expect(dto.address, null);
      expect(dto.image, null);
      expect(dto.latLong, null);
      expect(dto.name, null);
      expect(dto.phoneNumber, null);
    });

    test('when entity has non-null values should map correctly', () {
      var entity = StoreEntity(
        address: 'Cairo',
        image: 'store.png',
        latLong: '30.0444,31.2357',
        name: 'Flower Shop',
        phoneNumber: '0123456789',
      );

      var dto = toStoreDto(entity);

      expect(dto.address, entity.address);
      expect(dto.image, entity.image);
      expect(dto.latLong, entity.latLong);
      expect(dto.name, entity.name);
      expect(dto.phoneNumber, entity.phoneNumber);
    });
  });

  group('toUserDto', () {
    test('when entity has null values should return dto with null values', () {
      var entity = UserEntity(
        id: null,
        phone: null,
        photo: null,
        email: null,
        firstName: null,
        lastName: null,
        gender: null,
      );

      var dto = toUserDto(entity);

      expect(dto.id, null);
      expect(dto.phone, null);
      expect(dto.photo, null);
      expect(dto.email, null);
      expect(dto.firstName, null);
      expect(dto.lastName, null);
      expect(dto.gender, null);
    });

    test('when entity has non-null values should map correctly', () {
      var entity = UserEntity(
        id: 'U1',
        phone: '0123456789',
        photo: 'photo.png',
        email: 'a@a.com',
        firstName: 'Ahmed',
        lastName: 'Faid',
        gender: 'male',
      );

      var dto = toUserDto(entity);

      expect(dto.id, entity.id);
      expect(dto.phone, entity.phone);
      expect(dto.photo, entity.photo);
      expect(dto.email, entity.email);
      expect(dto.firstName, entity.firstName);
      expect(dto.lastName, entity.lastName);
      expect(dto.gender, entity.gender);
    });
  });

  group('toDriverDataDto', () {
    test('when entity has null values should return dto with null values', () {
      var entity = DriverDataEntity(
        id: null,
        phone: null,
        photo: null,
        email: null,
        firstName: null,
        lastName: null,
        vehicleType: null,
        nid: null,
        country: null,
        gender: null,
        nIDImg: null,
      );

      var dto = toDriverDataDto(entity);

      expect(dto.id, null);
      expect(dto.phone, null);
      expect(dto.photo, null);
      expect(dto.email, null);
      expect(dto.firstName, null);
      expect(dto.lastName, null);
      expect(dto.vehicleType, null);
      expect(dto.nId, null);
      expect(dto.country, null);
      expect(dto.gender, null);
      expect(dto.nIDImg, null);
    });

    test('when entity has non-null values should map correctly', () {
      var entity = DriverDataEntity(
        id: 'D1',
        phone: '0123456789',
        photo: 'driver.png',
        email: 'driver@car.com',
        firstName: 'Ahmed',
        lastName: 'Faid',
        vehicleType: 'Car',
        nid: '123456789',
        country: 'Egypt',
        gender: 'male',
        nIDImg: 'nid.png',
      );

      var dto = toDriverDataDto(entity);

      expect(dto.id, entity.id);
      expect(dto.phone, entity.phone);
      expect(dto.photo, entity.photo);
      expect(dto.email, entity.email);
      expect(dto.firstName, entity.firstName);
      expect(dto.lastName, entity.lastName);
      expect(dto.vehicleType, entity.vehicleType);
      expect(dto.nId, entity.nid);
      expect(dto.country, entity.country);
      expect(dto.gender, entity.gender);
      expect(dto.nIDImg, entity.nIDImg);
    });
  });

  group('toFirebaseDto', () {
    test(
      'when entity has null values should return dto with null driverData and orders',
      () {
        var entity = ToFirebaseEntity(driverData: null, orders: null);

        var dto = toFirebaseDto(entity);

        expect(dto.driverData, null);
        expect(dto.orders, null);
        expect(dto.userState, AppConstants.inProgress);
      },
    );

    test('when entity has non-null values should map correctly', () {
      var entity = ToFirebaseEntity(
        driverData: DriverDataEntity(
          id: 'D1',
          firstName: 'Ahmed',
          lastName: 'Faid',
          email: 'a@a.com',
        ),
        orders: OrdersEntity(id: 'O1', totalPrice: 100),
      );

      var dto = toFirebaseDto(entity);

      expect(dto.driverData?.id, entity.driverData?.id);
      expect(dto.driverData?.firstName, entity.driverData?.firstName);
      expect(dto.driverData?.lastName, entity.driverData?.lastName);
      expect(dto.orders?.id, entity.orders?.id);
      expect(dto.userState, AppConstants.inProgress);
    });
  });
}
