import 'package:flutter/material.dart';

class UtilIcon {
  static IconData getIconData(String name) {
    switch (name) {

      ///GROCERY
      case 'fas fa-shopping-cart':
      case 'shopping_cart':
        return Icons.shopping_cart;

      ///HOME
      case 'fas fa-home':
      case 'home':
        return Icons.home;

      ///ELECTRONICS
      case 'fas fa-mobile-alt':
      case 'laptop':
        return Icons.laptop;

      ///FASHION
      case 'fas fa-tshirt':
      case 'people':
        return Icons.people;

      ///GIFT PERFUMERIE
      case 'fas fa-shopping-bag':
      case 'card_giftcard':
        return Icons.card_giftcard;

      ///PETS
      case 'fas fa-paw':
      case 'pets':
        return Icons.pets;

      ///KIDS
      case 'fas fa-baby':
      case 'accessibility':
        return Icons.accessibility;

      case 'fas fa-shopping-bag':
      case 'shopping_basket':
        return Icons.shopping_basket;
      case 'fas fa-coffee':
      case 'local_drink':
        return Icons.local_drink;
      case 'fas fa-star':
      case 'event_available':
        return Icons.event_available;
      case 'fas fa-handshake':
      case 'all_inclusive':
        return Icons.all_inclusive;
      case 'fas fa-briefcase':
      case 'card_travel':
        return Icons.card_travel;
      case 'fas fa-utensil':
      case 'restaurant':
        return Icons.restaurant;
      case 'fas fa-car':
      case 'directions_car':
        return Icons.directions_car;
      case 'more_horiz':
        return Icons.more_horiz;
      case 'wifi':
        return Icons.wifi;
      case 'whatshot':
        return Icons.whatshot;
      case 'directions_bus':
        return Icons.directions_bus;
      case 'shopping_cart':
        return Icons.shopping_cart;
      case 'pets':
        return Icons.pets;
      case 'access_time':
        return Icons.access_time;
      case 'sort':
        return Icons.sort;
      case "swap_vert":
        return Icons.swap_vert;
      default:
        return Icons.help;
    }
  }

  ///Singleton factory
  static final UtilIcon _instance = UtilIcon._internal();

  factory UtilIcon() {
    return _instance;
  }

  UtilIcon._internal();
}
