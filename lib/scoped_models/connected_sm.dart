import 'package:scoped_model/scoped_model.dart';

// Models
import '../models/user_m.dart';
import '../models/listing_m.dart';
import '../models/product_m.dart';
import '../models/sub_product_m.dart';
import '../models/quantity_m.dart';
import '../models/sales_order_m.dart';

mixin ConnectedModel on Model {
  bool isLoading = false;
  bool isAuthChecked = false;

  // String baseUrl = 'http://192.168.29.9:8080/api/';
  // String mediaUrl = 'http://192.168.29.9:8080/storage/';

  String baseUrl = 'http://api.digiloopw.aaibuzz.com/api/';
  String mediaUrl = 'http://api.digiloopw.aaibuzz.com/storage/digiloop/';

  String companyDetails = '-';

  User authenticatedUser;

  var errors;

  List<Listing> listings = [];
  List<Product> products = [];
  List<SubProduct> subProducts = [];
  List<Quantity> quantities = [];

  List<SalesOrder> salesOrders = [];
  List<Map<String, dynamic>> payments = [];

  SalesOrder salesOrder = SalesOrder(
    createdBy: '2',
    salesOrderDetails: [],
  );

  setLoading() {
    errors = null;
    isLoading = true;
    notifyListeners();
  }

  unSetLoading() {
    isLoading = false;
    notifyListeners();
  }
}
