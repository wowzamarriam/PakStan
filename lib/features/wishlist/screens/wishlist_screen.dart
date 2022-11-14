import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pakkstan/common/widgets/custom_button.dart';
import 'package:pakkstan/features/wishlist/services/wishlist_services.dart';
import 'package:pakkstan/models/product.dart';
import 'package:pakkstan/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../Constants/global_variables.dart';
import '../../address/screens/address_screen.dart';
import '../../product_details/screens/product_details_screen.dart';
import '../../search/widget/searched_product.dart';

class WishListScreen extends StatefulWidget {
  static const String routeName = '/wishlist';

  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final WishlistServices wishlistServices = WishlistServices();

  removeFromWishList(Product product) async {
    await wishlistServices.removeFromWishLIst(
        context: context, product: product);
    setState(() {});
  }

  navigateToAddress(int sum) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => AddressScreen(
          totalAmount: sum.toString(),
          isDirect: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    int sum = 0;
    user.favorite.map((e) => e['product']['price'] as int).toList();
    // log(user.cart.toString());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 120,
                  height: 45,
                  fit: BoxFit.fitWidth,
                  color: Colors.black,
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.only(left: 15, right: 15),
              //   child: Row(
              //     children: const [
              //       Padding(
              //         padding: EdgeInsets.only(right: 15),
              //         child: Icon(Icons.notifications_outlined),
              //       ),//shehzadi yeh button kiu lgaye??hata den inko
              //       Icon(
              //         Icons.search,
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
      body: user.favorite.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 8,
                    ),
                    child: Text(
                      'Oops! Your wishlist is empty!',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            )
          : ListView(
              children: [
                ...user.favorite.map(
                  (e) {
                    Product product = Product.fromMap(e['product']);
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ProductDetailScreen.routeName,
                          arguments: product,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                        child: Stack(
                          children: [
                            SearchedProduct(
                              product: product,
                            ),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: IconButton(
                                onPressed: () async {
                                  await removeFromWishList(
                                    product,
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 8,
                  ),
                  child: CustomButton(
                    text: 'Checkout all items',
                    onTap: () => navigateToAddress(sum),
                  ),
                ),
              ],
            ),
    );
  }
}
