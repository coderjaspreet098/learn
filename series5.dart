import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:untitled/cart_model.dart';


class Cartapi extends StatefulWidget {
  const Cartapi({super.key});

  @override
  State<Cartapi> createState() => _CartapiState();
}

class _CartapiState extends State<Cartapi> {
  CartModel?cartModel;

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
            Text('API'),
            ElevatedButton(
              onPressed: () {
               cartproducts();
              },
              child: Text('click'),
            ),
            if (cartModel?.carts != null)
              Expanded(
                child: ListView.builder(
                  itemCount: cartModel!.carts!.length,
                  itemBuilder: (context, index) {
                    final product = cartModel!.carts![index];
                    return Card(
                      child: ListTile(
                        title: Column(
                          children: [
                            Text('${product.id}'),
                            Text('${product.products}'),
                            Text('${product.total}'),
                          ],
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

  void cartproducts() async {
    print('here');
    final dio = Dio();
    final response = await dio.get('https://dummyjson.com/carts');
    cartModel = CartModel.fromJson(response.data);
    setState(() {});
    print(cartModel);
  }
}





