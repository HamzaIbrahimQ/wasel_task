part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

class GetProductsLoading extends ProductsState {}

class GetProductsSuccess extends ProductsState {}

class GetProductsError extends ProductsState {
  final String? error;

  GetProductsError({this.error});
}

class GetProductsFailed extends ProductsState {}
