// Scoped Models
import 'connected_sm.dart';

// Utils
import '../utils/network.dart';

// Models
import '../models/listing_m.dart';
import '../models/product_m.dart';
import '../models/sub_product_m.dart';
import '../models/quantity_m.dart';

mixin ListingDetailsModel on ConnectedModel {
  void updateDetails() async {
    setLoading();

    final Map<String, dynamic> _responseData = await Network().get(
      url: 'users/${authenticatedUser.id}',
    );

    if (_responseData['success']) {
      Map<String, dynamic> _userData = _responseData['data'];
      // Listings
      listings = [];
      _userData['listings'].forEach((_listing) {
        listings.add(
          Listing(
            id: _listing['id'] ?? '',
            name: _listing['name'] ?? '',
            type: _listing['type'] ?? '',
          ),
        );
      });

      // Sort Products
      var sortedProds = sortItems(_userData['products']);
      // Products
      products = [];
      sortedProds.forEach((_product) {
        products.add(
          Product(
            id: _product['id'] ?? '',
            listingId: _product['listing_id'] ?? '',
            name: _product['name'] ?? '',
          ),
        );
      });

      // Sort Sub Products
      var sortedSubProds = sortItems(_userData['sub_products']);
      // Sub Product
      subProducts = [];
      sortedSubProds.forEach((_subProduct) {
        subProducts.add(
          SubProduct(
            id: _subProduct['id'] ?? '',
            productId: _subProduct['product_id'] ?? '',
            name: _subProduct['name'] ?? '',
            description: _subProduct['description'] ?? '',
            image1Path: _subProduct['image1_path'] ?? '',
            image1Description: _subProduct['image1_description'] ?? '',
            image2Description: _subProduct['image2_description'] ?? '',
            image3Description: _subProduct['image3_description'] ?? '',
            image4Description: _subProduct['image4_description'] ?? '',
            image2Path: _subProduct['image2_path'] ?? '',
            image3Path: _subProduct['image3_path'] ?? '',
            image4Path: _subProduct['image4_path'] ?? '',
          ),
        );
      });

      // Sort Quantities
      var sortedQuantities = sortQuantity(_userData['quantities']);
      // Quantities
      quantities = [];
      sortedQuantities.forEach((_quantity) {
        quantities.add(
          Quantity(
            id: _quantity['id'] ?? null,
            subProductId: _quantity['sub_product_id'] ?? null,
            quantity: _quantity['qty'] ?? null,
            price: _quantity['pivot']['price'] ?? null,
          ),
        );
      });
    }

    unSetLoading();
  }

  sortItems(items) {
    for (var i = 0; i < items.length; i++) {
      for (var j = i + 1; j < items.length; j++) {
        if (items[i]['id'] > items[j]['id']) {
          var temp = items[i];
          items[i] = items[j];
          items[j] = temp;
        }
      }
    }
    return items;
  }

  sortQuantity(items) {
    for (var i = 0; i < items.length; i++) {
      for (var j = i + 1; j < items.length; j++) {
        if (items[i]['qty'] > items[j]['qty']) {
          var temp = items[i];
          items[i] = items[j];
          items[j] = temp;
        }
      }
    }
    return items;
  }
}
