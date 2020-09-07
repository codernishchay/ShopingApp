import 'package:finall_shop/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/data.dart';

class EditPeroductScreen extends StatefulWidget {
  static const routeName = '/efa';
  @override
  _EditPeroductScreenState createState() => _EditPeroductScreenState();
}

class _EditPeroductScreenState extends State<EditPeroductScreen> {
  final _title = FocusNode();
  final _price = FocusNode();
  final _desc = FocusNode();
  final _imageUrlCtlr = TextEditingController();
  final _imageURLfnode = FocusNode();
  final _catogery = FocusNode();
  final _mrp = FocusNode();
  final _quantiny = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    //  catogery: '',
    imageUrl: '',
    //  mrp: 0,
    //   stockVal: 0,
  );
  var _initValues = {
    'title': '',
    'mrp': '',
    'price': '',
    'description': '',
    'catogery': '',
    'isFavorite': false,
    'imageUrl': '',
    'stockVal': '',
  };
  var isInit = true;
  @override
  void initState() {
    _imageURLfnode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _price.dispose();
    _imageURLfnode.removeListener(_updateImageUrl);
    _title.dispose();
    _imageUrlCtlr.dispose();
    _imageURLfnode.dispose();
    _catogery.dispose();
    _mrp.dispose();
    _quantiny.dispose();
    _desc.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'mrp ': _editedProduct.mrp.toString(),
          'description ': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'catogery': _editedProduct.catogery,
          // 'imageUrl': _editedProduct.imageUrl,
          'isFavorite': false,
          'imageUrl': '',
          'stockVal': _editedProduct.stockVal.toString()
        };
      }
    }
    isInit = false;

    super.didChangeDependencies();
  }

  var _isloading = false;
  void _updateImageUrl() {
    if (!_imageURLfnode.hasFocus) {}
  }
  //te get acceess of the data instde this code you need to add a global key

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    _form.currentState.save();
    setState(() {
      _isloading = true;
    });
    print(_editedProduct.title);
    print(_editedProduct.stockVal);
    print(_editedProduct.id);
    print(_editedProduct.price);
    print(_editedProduct.mrp);
    print(_editedProduct.description);
    print(_editedProduct.catogery);
    print(_editedProduct.imageUrl);

    if (_editedProduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProducts(_editedProduct);
        print(_editedProduct.id);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error Occured!'),
            content: Text('Something went Wrong'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      }

      setState(() {
        _isloading = false;
      });

      Navigator.of(context).pop();
      // Navigator.of(context).pop();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      //text form feild configuration
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                  key: _form,
                  //runs our validation logic after every next click
                  //   autovalidate: true,

                  //on will popup pops up if we go back without saving our formsdata
                  //    onWillPop: ,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _initValues['title'],
                        decoration: InputDecoration(
                            labelText: 'Title', alignLabelWithHint: mounted),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_title),
                        onSaved: (newValue) => _editedProduct = Product(
                            title: newValue,
                            price: _editedProduct.price,
                            description: _editedProduct.description,
                            catogery: _editedProduct.catogery,
                            imageUrl: _editedProduct.imageUrl,
                            mrp: _editedProduct.mrp,
                            id: _editedProduct.id,
                            isfavorite: _editedProduct.isfavorite,
                            stockVal: _editedProduct.stockVal),
                      ),

                      TextFormField(
                          initialValue: _initValues['stockVal'],
                          decoration: InputDecoration(
                              labelText: 'Quantity avilable',
                              alignLabelWithHint: mounted),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: _title,
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).requestFocus(_price),
                          validator: (newValue) {
                            if (newValue.isEmpty) {
                              return 'Please enter the no of items avilable ';
                            }
                            if (double.parse(newValue) == null) {
                              return 'Please enter a valid number';
                            }
                            if (double.parse(newValue) <= 0) {
                              return 'Please enter a quantity greater then 1';
                            }
                            return null;
                          },
                          onSaved: (newValue) => _editedProduct = Product(
                                title: _editedProduct.title,
                                stockVal: int.parse(newValue),
                                price: _editedProduct.price,
                                description: _editedProduct.description,
                                catogery: _editedProduct.catogery,
                                imageUrl: _editedProduct.imageUrl,
                                mrp: _editedProduct.mrp,
                                id: _editedProduct.id,
                                isfavorite: _editedProduct.isfavorite,
                              )),

                      TextFormField(
                        initialValue: _initValues['price'],
                        decoration: InputDecoration(
                            labelText: 'Price', alignLabelWithHint: mounted),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _price,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_mrp),
                        validator: (newValue) {
                          if (newValue.isEmpty) {
                            return 'Please enter a price';
                          }
                          if (double.parse(newValue) == null) {
                            return 'Please enter a valid number';
                          }
                          if (double.parse(newValue) <= 0) {
                            return 'Please enter a Price greater than 0';
                          }
                          return null;
                        },
                        onSaved: (newValue) => _editedProduct = Product(
                            title: _editedProduct.title,
                            price: double.parse(newValue),
                            description: _editedProduct.description,
                            catogery: _editedProduct.catogery,
                            imageUrl: _editedProduct.imageUrl,
                            mrp: _editedProduct.mrp,
                            id: _editedProduct.id,
                            isfavorite: _editedProduct.isfavorite,
                            stockVal: _editedProduct.stockVal),
                      ),

                      TextFormField(
                        initialValue: _initValues['mrp'],
                        decoration: InputDecoration(
                            labelText: 'MRP', alignLabelWithHint: mounted),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _mrp,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_desc),
                        validator: (newValue) {
                          if (newValue.isEmpty) {
                            return 'Please enter a price';
                          }
                          if (double.parse(newValue) == null) {
                            return 'Please enter a valid number';
                          }
                          if (double.parse(newValue) <= 0) {
                            return 'Please enter a Price greater than 0';
                          }
                          return null;
                        },
                        onSaved: (newValue) => _editedProduct = Product(
                            title: _editedProduct.title,
                            price: _editedProduct.price,
                            description: _editedProduct.description,
                            catogery: _editedProduct.catogery,
                            imageUrl: _editedProduct.imageUrl,
                            mrp: double.parse(newValue),
                            id: _editedProduct.id,
                            isfavorite: _editedProduct.isfavorite,
                            stockVal: _editedProduct.stockVal),
                      ),

                      TextFormField(
                        initialValue: _initValues['discription'],
                        decoration: InputDecoration(
                            labelText: 'Discription',
                            alignLabelWithHint: mounted),
                        maxLines: 3,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.multiline,
                        focusNode: _desc,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_catogery),
                        validator: (newValue) {
                          if (newValue.isEmpty) {
                            return 'Please Describe your';
                          }
                          if (newValue.length < 30) {
                            return 'Please Describe your Item Nicely';
                          }
                          return null;
                        },
                        onSaved: (newValue) => _editedProduct = Product(
                            title: _editedProduct.title,
                            price: _editedProduct.price,
                            description: newValue,
                            catogery: _editedProduct.catogery,
                            imageUrl: _editedProduct.imageUrl,
                            mrp: _editedProduct.mrp,
                            id: _editedProduct.id,
                            isfavorite: _editedProduct.isfavorite,
                            stockVal: _editedProduct.stockVal),
                      ),

                      TextFormField(
                        initialValue: _initValues['catogery'],
                        decoration: InputDecoration(
                            labelText: 'Catogerry',
                            alignLabelWithHint: mounted),
                        maxLines: 3,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.multiline,
                        focusNode: _catogery,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the catogery';
                          }
                          return null;
                        },
                        onSaved: (newValue) => _editedProduct = Product(
                            title: _editedProduct.title,
                            price: _editedProduct.price,
                            description: _editedProduct.description,
                            catogery: newValue,
                            imageUrl: _editedProduct.imageUrl,
                            mrp: _editedProduct.mrp,
                            id: _editedProduct.id,
                            isfavorite: _editedProduct.isfavorite,
                            stockVal: _editedProduct.stockVal),
                      ),

                      // this part is working well

                      Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: _imageUrlCtlr.text.isEmpty
                                  ? Text('Enter the URL')
                                  : FittedBox(
                                      child: Image.network(
                                      _imageUrlCtlr.text,
                                      fit: BoxFit.cover,
                                    )),
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.orange)),
                            ),
                            Expanded(
                              child: TextFormField(
                                //  initialValue: _initValues['imageUrl'],
                                //if already have controller then no need of init value

                                decoration: InputDecoration(
                                  labelText: 'ImageUrl',
                                ),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                controller: _imageUrlCtlr,
                                focusNode: _imageURLfnode,
                                onFieldSubmitted: (newValue) => _saveForm(),
                                onSaved: (newValue) => _editedProduct = Product(
                                    title: _editedProduct.title,
                                    price: _editedProduct.price,
                                    description: _editedProduct.description,
                                    catogery: _editedProduct.catogery,
                                    imageUrl: newValue,
                                    mrp: _editedProduct.mrp,
                                    id: _editedProduct.id,
                                    isfavorite: _editedProduct.isfavorite,
                                    stockVal: _editedProduct.stockVal),
                              ),
                            ),
                          ])
                    ],
                  )),
            ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _saveForm();
          },
          label: Row(
            children: [Icon(Icons.save), Text('Save')],
          )),
    );
  }
}
