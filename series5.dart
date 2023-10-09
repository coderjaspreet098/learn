import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled/cart_model.dart';

class Cartapi extends StatefulWidget {
  const Cartapi({super.key});

  @override
  State<Cartapi> createState() => _CartapiState();
}

class _CartapiState extends State<Cartapi> {
  CartModel? cartModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar Title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (cartModel?.carts != null)
              Expanded(
                child: ListView.builder(
                  itemCount: cartModel!.carts!.length,
                  itemBuilder: (context, index) {
                    final product = cartModel!.carts![index];
                    return SizedBox(
                      height: 300,
                      child: Card(
                        child: ListTile(
                          title: Column(
                            children: [
                              Text('${product.id}'),
                              if (product.products != null)
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: product.products!.length,
                                    itemBuilder: (context, index) {
                                      final productlist =
                                      product.products![index];
                                      return ListTile(
                                        title: Text('${productlist.price}'),
                                        subtitle:
                                        Text('${productlist.quantity}'),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    createCart();
  }

  void createCart() async {
    final dio = Dio();

    try {
      final response1 = await dio.post('https://dummyjson.com/carts', data: cartModel?.toJson());

      if (response1.statusCode == 200) {
        print('Cart created successfully.');
        setState(() {
          cartModel = CartModel.fromJson(response1.data);
        });
      } else {
        print('Failed to create cart. Status code: ${response1.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}


