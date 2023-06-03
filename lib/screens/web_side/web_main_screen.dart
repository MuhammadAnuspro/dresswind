import 'package:dresswind/screens/web_side/addProduct_screen.dart';
import 'package:dresswind/screens/web_side/cardProduct_screen.dart';
import 'package:dresswind/screens/web_side/dashboard_screen.dart';
import 'package:dresswind/screens/web_side/deleteProdect_screen.dart';
import 'package:dresswind/screens/web_side/updateproduct_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class WebMainScreen extends StatefulWidget {
// const WebMainScreen({Key? key}) : super(key: key);
  static const String id = "webmainscreen";

  @override
  State<WebMainScreen> createState() => _WebMainScreenState();
}

class _WebMainScreenState extends State<WebMainScreen> {
  Widget selectedScreen = DashBoardScreen();

  chooseScreen(item) {
    switch (item.route) {
      case DashBoardScreen.id:
        setState(() {
          selectedScreen = DashBoardScreen();
        });
        break;

      case AddProductScreen.id:
        setState(() {
          selectedScreen = AddProductScreen();
        });
        break;

      case UpdateProductScreen.id:
        setState(() {
          selectedScreen = UpdateProductScreen();
        });
        break;

      case DeleteProductScreen.id:
        setState(() {
          selectedScreen = DeleteProductScreen();
        });
        break;

      case CardProductScreen.id:
        setState(() {
          selectedScreen = CardProductScreen();
        });
        break;

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("ADMIN"),
      ),
      sideBar: SideBar(
          onSelected: (item) {
            chooseScreen(item);
          },
          items: [
            AdminMenuItem(
                title: "DASHBOARD",
                icon: Icons.dashboard_rounded,
                route: DashBoardScreen.id),
            AdminMenuItem(
                title: "ADD PRODUCTS",
                icon: Icons.add_business_sharp,
                route: AddProductScreen.id),
            AdminMenuItem(
                title: "UPDATE PRODUCTS",
                icon: Icons.browser_updated_outlined,
                route: UpdateProductScreen.id),
            AdminMenuItem(
                title: "DELETE PRODUCTS",
                icon: Icons.delete_sweep_sharp,
                route: DeleteProductScreen.id),
            AdminMenuItem(
              title: "CARD PRODUCTS",
              icon: Icons.shopping_cart,
              route: CardProductScreen.id
            ),
          ],
          selectedRoute: WebMainScreen.id),
      body: selectedScreen,
    );
  }
}
