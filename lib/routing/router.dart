import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// Scoped Model
import '../scoped_models/main_sm.dart';

// Routes
import 'routes.dart';

// Pages
import '../pages/home_page.dart';

// Auth
import '../pages/auth/login_page.dart';
import '../pages/auth/register_page.dart';
import '../pages/auth/forgot_password_page.dart';
import '../pages/auth/loading_page.dart';

// Listings
import '../pages/listings/listing_index_page.dart';
import '../pages/products/product_index_page.dart';
import '../pages/sub_products/sub_product_index_page.dart';

// Cart
import '../pages/cart/add_to_cart_page.dart';
import '../pages/cart/cart_page.dart';

// Profile
import '../pages/profile/profile_index_page.dart';
import '../pages/profile/profile_id_page.dart';

// Logins
import '../pages/logins/login_create_page.dart';
import '../pages/logins/login_id_page.dart';

// Orders
import '../pages/sales_orders/sales_order_index_page.dart';
import '../pages/sales_orders/sales_order_id_page.dart';

// Send KYC
import '../pages/send_kyc/send_kyc_index_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case home:
      return MaterialPageRoute(
        builder: (BuildContext context) => ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) {
            if (model.isAuthChecked) {
              if (model.authenticatedUser == null)
                return LoginPage(
                  model: model,
                );
              else
                return HomePage(
                  model: model,
                );
              // return ListingIndexPage(
              //   model: model,
              // );
            } else
              return LoadingPage();
          },
        ),
      );
    case login:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              return LoginPage(
                model: model,
              );
            },
          );
        },
      );
    case register:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              return RegisterPage(
                model: model,
              );
            },
          );
        },
      );
    case forgotPassword:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              return ForgotPasswordPage(
                model: model,
              );
            },
          );
        },
      );
    // Listings
    case listings:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              // arguments: type
              return ListingIndexPage(
                model: model,
                arguments: settings.arguments,
              );
            },
          );
        },
      );
    case products:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              // arguments: listing_id, name
              return ProductIndexPage(
                model: model,
                arguments: settings.arguments,
              );
            },
          );
        },
      );
    case subProducts:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              // arguments: product_id, name
              return SubProductIndexPage(
                model: model,
                arguments: settings.arguments,
              );
            },
          );
        },
      );
    // Cart
    case addToCart:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              // arguments: sub_product_id, name
              return AddToCartPage(
                model: model,
                arguments: settings.arguments,
              );
            },
          );
        },
      );
    case cart:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              return CartPage(
                model: model,
              );
            },
          );
        },
      );
    // Profile
    case profile:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              return ProfileIndexPage(
                model: model,
              );
            },
          );
        },
      );
    case profileId:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              return ProfileIdPage(
                model: model,
              );
            },
          );
        },
      );
    // Logins
    case loginCreate:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              return LoginCreatePage(
                model: model,
              );
            },
          );
        },
      );
    case loginId:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              // arguments: login
              return LoginIdPage(
                model: model,
                arguments: settings.arguments,
              );
            },
          );
        },
      );
    // Orders
    case orders:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              return SalesOrderIndexPage(
                model: model,
              );
            },
          );
        },
      );
    case orderId:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              // sales_order
              return SalesOrderIdPage(
                model: model,
                arguments: settings.arguments,
              );
            },
          );
        },
      );
    // Send KYc
    case sendKyc:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              return SendKycIndexPage(
                model: model,
                arguments: settings.arguments,
              );
            },
          );
        },
      );
    default:
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              return HomePage(
                model: model,
              );
            },
          );
        },
      );
  }
}
