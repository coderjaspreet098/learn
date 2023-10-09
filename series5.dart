import 'package:flutter/material.dart';
import 'package:untitled/products_response_model.dart';
import 'package:dio/dio.dart';


class Productbutton extends StatefulWidget {
  const Productbutton({Key? key}) : super(key: key);

  @override
  State<Productbutton> createState() => _ProductbuttonState();
}

class _ProductbuttonState extends State<Productbutton> {
  ProductsResponseModel? productsResponseModel;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: Column(
        children: [
          if (productsResponseModel?.products != null)
            Expanded(
              child: ListView.builder(
                itemCount: productsResponseModel!.products!.length,
                itemBuilder: (context, index) {
                  final product = productsResponseModel!.products![index];
                  return ListTile(
                    title: Column(
                      children: [
                        Text('${product.id}'),
                        Text(product.title ?? 'Title'),
                        Text(product.description ?? 'Description'),
                        Text('${product.price}'),
                      ],
                    ),
                  );
                },
              ),
            ),
          _buildAddProductForm(),
        ],
      ),
    );
  }

  Widget _buildAddProductForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _idController,
            decoration: InputDecoration(labelText: 'ID'),
          ),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: _priceController,
            decoration: InputDecoration(labelText: 'Price'),
          ),
          ElevatedButton(
            onPressed: () {
              _addProduct();
            },
            child: Text('Add Product'),
          ),
        ],
      ),
    );
  }

  void initState() {
    super.initState();
    loadProductsAndNavigate();
  }

  Future<void> loadProductsAndNavigate() async {
    try {
      final dio = Dio();
      final response = await dio.get('https://dummyjson.com/products');
      setState(() {
        productsResponseModel = ProductsResponseModel.fromJson(response.data);
      });
    } catch (e) {
      print('Error loading products: $e');
    }
  }

  Future<void> _addProduct() async {
    try {
      final dio = Dio();
      final response1 = await dio.post('https://dummyjson.com/products/add', data: {
        'id': _idController.text,
        'title': _titleController.text,
        'description': _descriptionController.text,
        'price': _priceController.text,

      });
      print(response1);
      if (response1.statusCode == 200) {
        final addedProduct = ProductsResponseModel.fromJson(response1.data);
        productsResponseModel!.products!.add(addedProduct.products!.first);
 
      } else {
        print('Failed to add product: ${response1.statusCode}');
      }

      _idController.clear();
      _titleController.clear();
      _descriptionController.clear();
      _priceController.clear();

      await loadProductsAndNavigate();
    } catch (e) {
      print('Error adding product: $e');
    }
  }
}

