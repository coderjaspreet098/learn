class CartController extends GetxController {
  // ... other code ...

  Future<void deleteCartData(String id) async {
    var token = 'token_id';
    try {
      var response = await http.delete(
        Uri.parse('https://dummyjson.com/carts/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        // Remove the deleted item from the cartList
        cartList.removeWhere((cart) => cart.carts!.any((c) => c.id == id));
        update();
      } else {
        print('Cart not deleted');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void updateUserData(String id) async {
    var token = 'token_id';
    try {
      var body = {
        'total': totalController.text,
        'discountedTotal': discountedtotalController.text,
        'userId': userIdController.text,
      };

      var response = await http.put(
        Uri.parse('https://dummyjson.com/carts/$id'),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Data updated');
        // You can update the cartList here if needed
        // Find the cart item and update its values
        var updatedCart = cartList.firstWhere(
          (cart) => cart.carts!.any((c) => c.id == id),
          orElse: () => null,
        );
        if (updatedCart != null) {
          updatedCart.total = totalController.text;
          updatedCart.discountedTotal = discountedtotalController.text;
          updatedCart.userId = userIdController.text;
        }
        update();
      } else {
        print('Response status code not 200');
      }
    } catch (e) {
      print(e);
    }
  }

  // ... other code ...
}
