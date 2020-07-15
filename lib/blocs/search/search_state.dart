import 'package:listar_flutter/models/model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchState {}

class SearchEmpty extends SearchState {}

class Searching extends SearchState {}

class Success extends SearchState {
  final List<ProductModel> list;
  Success(this.list);
}
