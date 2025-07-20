import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wasel_task/cubits/products/products_repo.dart';
import 'package:wasel_task/models/products/product_model.dart';
import 'package:wasel_task/utils/utility_mixin.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> with Utility {
  final ProductRepo _repo = ProductRepo();
  List<ProductModel>? products;

  ProductsCubit() : super(ProductsInitial());

  Future<void> getProducts() async {
    final _isConnected = await checkInternetConnection();
    if (_isConnected) {
      emit(GetProductsLoading());

      try {
        final response = await _repo.getProducts();
        products = response;
        emit(GetProductsSuccess());
      } catch (e) {
        emit(GetProductsError(error: e.toString()));
      }
    } else {
      /// Not internet connection
      emit(GetProductsFailed());
    }
  }

  Future<void> signOut() async {
    await _repo.signOut();
  }
}
