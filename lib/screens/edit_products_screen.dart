import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../models/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/editProduct';
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editedProduct = Product(
    id: '',
    name: '',
    price: 0,
    description: '',
    imageUrl: '',
    collection: '',
    type: '',
  );

  var _initValues = {
    'id': '',
    'name': '',
    'description': '',
    'price': '',
    'collection': '',
    'type': '',
    'imageUrl': '',
    'isFav': false,
  };

  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print(_editedProduct.id);
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String?;
      if (productId != null) {
        final _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        print('${_editedProduct.id} in init didchangedependencies');
        _initValues = {
          'id': _editedProduct.id as String,
          'name': _editedProduct.name,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'collection': _editedProduct.collection,
          'type': _editedProduct.type,
          'imageUrl': '',
          'isFav': _editedProduct.isFav,
        };

        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();

    super.dispose();
  }

  void _updateImageUrl() {
    debugPrint('in update ${_editedProduct.id}');
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() async {
    debugPrint('in saveform ${_editedProduct.id}');
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }

    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    _editedProduct = Product(
      name: _editedProduct.name,
      price: _editedProduct.price,
      description: _editedProduct.description,
      collection: _editedProduct.collection,
      type: _editedProduct.type,
      id: _initValues['id'] as String,
      imageUrl: _editedProduct.imageUrl,
      isFav: _initValues['isFav'] as bool,
    );
    print('${_editedProduct.id} id');

    try {
      if ((_initValues['id'] as String).isNotEmpty) {
        await Provider.of<Products>(context, listen: false)
            .updateProduct(_initValues['id'] as String, _editedProduct);
      } else {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      }
    } on Exception catch (e) {
      await showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('An Error Occured'),
              content: const Text('Something Went Wrong'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Center(child: Text('Ok')),
                ),
              ],
            );
          });
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 30,
              color: Color.fromARGB(190, 51, 51, 51),
            ),
          ),
        ),
        title: const Text('Edit Product'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                debugPrint('${_editedProduct.id} in onPressed save.');
                _saveForm();
              },
              icon: const Icon(Icons.save),
              color: const Color.fromARGB(255, 221, 133, 96),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 221, 133, 96),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValues['name'] as String,
                      decoration: const InputDecoration(
                        labelText: 'Product Name',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Product Name.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        debugPrint(
                            '${_editedProduct.name} in product name form field.');
                        _editedProduct = Product(
                          name: value!,
                          price: _editedProduct.price,
                          description: _editedProduct.description,
                          collection: _editedProduct.collection,
                          type: _editedProduct.type,
                          id: _editedProduct.id,
                          imageUrl: _editedProduct.imageUrl,
                          isFav: _initValues['isFav'] as bool,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'] as String,
                      decoration: const InputDecoration(
                        labelText: 'Price',
                      ),
                      focusNode: _priceFocusNode,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Price.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a number greater than 0.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          name: _editedProduct.name,
                          price: double.parse(value!),
                          description: _editedProduct.description,
                          collection: _editedProduct.collection,
                          type: _editedProduct.type,
                          id: _editedProduct.id,
                          imageUrl: _editedProduct.imageUrl,
                          isFav: _initValues['isFav'] as bool,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'] as String,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 3,
                      focusNode: _descriptionFocusNode,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a description.';
                        }
                        if (value.length < 10) {
                          return 'Should be atleast 10 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          name: _editedProduct.name,
                          price: _editedProduct.price,
                          description: value!,
                          collection: _editedProduct.collection,
                          type: _editedProduct.type,
                          id: _editedProduct.id,
                          imageUrl: _editedProduct.imageUrl,
                          isFav: _initValues['isFav'] as bool,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['collection'] as String,
                      decoration: const InputDecoration(
                        labelText: 'Collection',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Collection name.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          name: _editedProduct.name,
                          price: _editedProduct.price,
                          description: _editedProduct.description,
                          collection: value!.trim(),
                          type: _editedProduct.type,
                          id: _editedProduct.id,
                          imageUrl: _editedProduct.imageUrl,
                          isFav: _initValues['isFav'] as bool,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['type'] as String,
                      decoration: const InputDecoration(
                        labelText: 'Type',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Type.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          name: _editedProduct.name,
                          price: _editedProduct.price,
                          description: _editedProduct.description,
                          collection: _editedProduct.collection,
                          type: value!.trim(),
                          id: _editedProduct.id,
                          imageUrl: _editedProduct.imageUrl,
                          isFav: _initValues['isFav'] as bool,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? const Center(child: Text('Enter a URL'))
                              : Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            onEditingComplete: () {
                              setState(() {});
                            },
                            focusNode: _imageUrlFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter an Image URL.';
                              }
                              // if (!value.startsWith('http') &&
                              //     value.startsWith('https')) {
                              //   return 'Please enter a valid URL';
                              // }
                              // if (!value.endsWith('.png') &&
                              //     !value.endsWith('.jpg') &&
                              //     !value.endsWith('.jpeg')) {
                              //   return 'Please enter a valid Image URL';
                              // }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                name: _editedProduct.name,
                                price: _editedProduct.price,
                                description: _editedProduct.description,
                                collection: _editedProduct.collection,
                                type: _editedProduct.type,
                                id: _editedProduct.id,
                                imageUrl: value!,
                                isFav: _initValues['isFav'] as bool,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
