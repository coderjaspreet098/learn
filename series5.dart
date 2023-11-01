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
        // Find the index of the cart item to delete from the cartList
        final index = cartList.indexWhere((cart) => cart.carts!.any((c) => c.id == id));
        if (index != -1) {
          // Remove the cart item from the cartList
          cartList.removeAt(index);
        }
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
        // Update the cart item in the cartList
        final cartToUpdate = cartList.firstWhere(
          (cart) => cart.carts!.any((c) => c.id == id),
          orElse: () => null,
        );

        if (cartToUpdate != null) {
          cartToUpdate.total = totalController.text;
          cartToUpdate.discountedTotal = discountedtotalController.text;
          cartToUpdate.userId = userIdController.text;
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
