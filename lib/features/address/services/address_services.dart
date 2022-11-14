import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';

class AddressServices {
  saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    log(address);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'address': address,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            address: jsonDecode(res.body)['address'],
          );

          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get all the products
  placeOrder({
    required BuildContext context,
    required String address,
    required String paymentMethod,
    required double totalSum,
    required bool isDirect,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/order'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
          'cart': isDirect
              ? userProvider.user.favorite.map((e) {
                  return {
                    'product': e['product'],
                    'quantity': 1,
                    '_id': const Uuid().v1(),
                  };
                }).toList()
              : userProvider.user.cart,
            'payment': paymentMethod,
            'address': address,
            'totalPrice': totalSum,
            'isDirect': isDirect,
          },
        ),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
        toaster('Your order has been placed!');

        if (!isDirect) {
          User user = userProvider.user.copyWith(
            cart: [],
          );
          userProvider.setUserFromModel(user);
        } else {
          User user = userProvider.user.copyWith(
            favorite: [],
          );
          userProvider.setUserFromModel(user);
        }
        },
      );
    // } catch (e) {
    //   showSnackBar(context, e.toString());
    // }
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
