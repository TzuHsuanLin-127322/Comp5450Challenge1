import 'package:challenge_1_mobile_store_maker/model/base/http_service_result.dart';
import 'package:challenge_1_mobile_store_maker/model/product_model.dart';

abstract class ProductService {
  Future<HttpServiceResult<List<Product>>> getProducts();
  Future<HttpServiceResult<Product>> getProductById(String id);
  Future<HttpServiceResult<List<Product>>> searchProducts(String query);
  Future<HttpServiceResult<bool>> putProduct(Product product);
  Future<HttpServiceResult<bool>> updateProduct(Product product);
  Future<HttpServiceResult<bool>> deleteProduct(String id);
}
