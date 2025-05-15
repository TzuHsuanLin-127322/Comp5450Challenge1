import 'package:challenge_1_mobile_store_maker/model/base/http_service_result.dart';
import 'package:challenge_1_mobile_store_maker/model/fakeData/fake_product_model.dart';
import 'package:challenge_1_mobile_store_maker/model/product_model.dart';
import 'package:challenge_1_mobile_store_maker/data/services/product_service.dart';

class MockProductService extends ProductService {
  final Duration latency;

  MockProductService({this.latency = const Duration(seconds: 2)});

  final List<Product> _products = fakeProductList;

  @override
  Future<HttpServiceResult<List<Product>>> getProducts() async {
    await Future.delayed(latency);
    return HttpServiceResult(
      data: _products,
      statusCode: 200,
      message: 'Success',
    );
  }

  @override
  Future<HttpServiceResult<Product>> getProductById(String id) async {
    return HttpServiceResult(
      data: _products.firstWhere((product) => product.id == id),
      statusCode: 200,
      message: 'Success',
    );
  }

  @override
  Future<HttpServiceResult<List<Product>>> searchProducts(String query) async {
    return HttpServiceResult(
      data: _products.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList(),
      statusCode: 200,
      message: 'Success',
    );
  }

  @override
  Future<HttpServiceResult<bool>> putProduct(Product product) async {
    _products.add(product);
    return HttpServiceResult(
      data: true,
      statusCode: 200,
      message: 'Success',
    );
  } 

  @override
  Future<HttpServiceResult<bool>> updateProduct(Product product) async {
    _products.add(product);
    return HttpServiceResult(
      data: true,
      statusCode: 200,
      message: 'Success',
    );
  }

  @override
  Future<HttpServiceResult<bool>> deleteProduct(String id) async {
    _products.removeWhere((product) => product.id == id);
    return HttpServiceResult(data: true, statusCode: 200, message: 'Success');
  }

}
