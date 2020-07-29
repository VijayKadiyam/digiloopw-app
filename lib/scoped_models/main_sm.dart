import 'package:scoped_model/scoped_model.dart';

// Scoped Models
import 'connected_sm.dart';
import 'auth_sm.dart';
import 'listing_details_sm.dart';
import 'sales_order_sm.dart';
import 'email_sm.dart';
import 'login_sm.dart';

class MainModel extends Model
    with
        ConnectedModel,
        AuthModel,
        ListingDetailsModel,
        SalesOrderModel,
        EmailModel,
        LoginModel {}
