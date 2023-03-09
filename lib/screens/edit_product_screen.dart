import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionNode = FocusNode();
  final _imageUrlControler = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editProduct = Product(
      id: null.toString(), title: '', price: 0, description: '', imageUrl: '');
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': ''
  };
  @override
  var _isInit = true;
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (productId != null) {
        _editProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editProduct.title,
          'description': _editProduct.description,
          'price': _editProduct.price.toString(),
          'imageUrl': ''
        };
        _imageUrlControler.text=_editProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionNode.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    Provider.of<Products>(context, listen: false).addProduct(_editProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    label: const Text(
                      'Title',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editProduct = Product(
                        id: null.toString(),
                        title: _editProduct.title,
                        description: _editProduct.description,
                        price: _editProduct.price,
                        imageUrl: _editProduct.imageUrl);
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    label: const Text(
                      'Price',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide a price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Please enter number greater than zero';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    label: const Text('Description',
                        style: TextStyle(color: Colors.black54)),
                  ),
                  maxLines: 3,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionNode,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide a description';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.only(top: 8, right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: _imageUrlControler.text.isEmpty
                            ? const Text('Enter a URL ')
                            : FittedBox(
                                child: Image.network(
                                  _imageUrlControler.text,
                                  fit: BoxFit.cover,
                                ),
                              )),
                    Expanded(
                      child: TextFormField( 
                       
                        decoration: const InputDecoration(
                          label: Text(
                            'Image URL',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        focusNode: _imageUrlFocusNode,
                        controller: _imageUrlControler,
                        onEditingComplete: () {
                          setState(() {});
                        },
                        onFieldSubmitted: (_) => _saveForm(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please add an image url';
                          }
                          if (!value.startsWith('http') &&
                              !value.startsWith('https')) {
                            return 'Please  enter a valid URL';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
