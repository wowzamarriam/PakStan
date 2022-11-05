import 'package:flutter/material.dart';

import '../../wishlist/screens/wishlist_screen.dart';
import '../services/account_services.dart';
import 'account_button.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);
  navigateToWishlistScreen(BuildContext context) {
    Navigator.of(context).pushNamed(WishListScreen.routeName);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Log Out',
              onTap: () => AccountServices().logOut(context),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            // AccountButton(
            //   text: 'Your Orders',
            //   onTap: () {},
            // ),
            AccountButton(
              text: 'Wish List',
              onTap: () => navigateToWishlistScreen(context),
            ),
          ],
        ),
      ],
    );
  }
}
