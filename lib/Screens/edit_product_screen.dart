import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  static const routename = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageurlController = TextEditingController();
  final _imageUrlfocusnode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: '', title: '', description: '', price: 0, imageUrl: '');
  var _isInit = true;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlfocusnode.addListener(_updateImageUrl);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    try {
      if (_isInit = true) {
        final productId = ModalRoute.of(context)!.settings.arguments as String;
        if (productId != null) {
          _editedProduct =
              Provider.of<Products>(context, listen: false).findById(productId);
          _initValues = {
            'title': _editedProduct.title,
            'description': _editedProduct.description,
            'price': _editedProduct.price.toString(),
            'imageUrl': ''
          };
          _imageurlController.text = _editedProduct.imageUrl;
        }
      }
    } catch (e) {
      return;
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlfocusnode.removeListener(_updateImageUrl);
    _imageUrlfocusnode.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageurlController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    // if ((_imageurlController.text.startsWith('http') &&
    //         _imageurlController.text.startsWith('https')) ||
    //     (_imageurlController.text.endsWith('.png') &&
    //         (_imageurlController.text.endsWith('.jpg') &&
    //             (_imageurlController.text.endsWith('jpeg'))))) {
    //   return;
    // }
    if (!_imageUrlfocusnode.hasFocus) {
      setState(() {});
    }
  }

  void _saveform() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != '') {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct)
          .catchError((error) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occured'),
            content: Text('Something went wrong!'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Okay'))
            ],
          ),
        );
      }).then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [IconButton(onPressed: _saveform, icon: Icon(Icons.save))],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (val) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: val!,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: _editedProduct.isFavorite);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Product title can\'t be empty!';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (val) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: double.parse(val!),
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: _editedProduct.isFavorite);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Product price can\'t be empty!';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid price';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Price can\'t be zero';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      onSaved: (val) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: val!,
                            price: _editedProduct.price,
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: _editedProduct.isFavorite);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Product description can\'t be empty!';
                        }
                        if (value.length < 10) {
                          return 'Should be atleast 10 characters';
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: _imageurlController.text.isEmpty
                              ? Center(
                                  child: Text(
                                  'Enter image URL',
                                  textAlign: TextAlign.center,
                                ))
                              : FittedBox(
                                  child: Image.network(
                                    _imageurlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          // width: MediaQuery.of(context).size.width - 140,
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Enter Image Url Here'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageurlController,
                            focusNode: _imageUrlfocusnode,
                            onFieldSubmitted: (_) {
                              _saveform();
                            },
                            onSaved: (val) {
                              _editedProduct = Product(
                                  id: _editedProduct.id,
                                  title: _editedProduct.title,
                                  description: _editedProduct.description,
                                  price: _editedProduct.price,
                                  imageUrl: val!,
                                  isFavorite: _editedProduct.isFavorite);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Product URL can\'t be empty!';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
