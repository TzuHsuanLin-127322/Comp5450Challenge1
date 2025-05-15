import 'package:challenge_1_mobile_store_maker/data/services/product_service.dart';
import 'package:challenge_1_mobile_store_maker/model/base/http_service_result.dart';
import 'package:challenge_1_mobile_store_maker/model/product_model.dart';

class ProductRepository {
  final ProductService productService;
  
  ProductRepository({required this.productService});

  Future<HttpServiceResult<List<Product>>> getProducts() async {
    return await productService.getProducts();
  }

  Future<HttpServiceResult<Product>> getProductById(String id) async {
    return await productService.getProductById(id);
  }

  Future<HttpServiceResult<List<Product>>> searchProducts(String query) async {
    return await productService.searchProducts(query);
  }

  Future<HttpServiceResult<bool>> putProduct(Product product) async {
    return await productService.putProduct(product);
  }

  Future<HttpServiceResult<bool>> updateProduct(Product product) async {
    return await productService.updateProduct(product);
  }

  Future<HttpServiceResult<bool>> deleteProduct(String id) async {
    return await productService.deleteProduct(id);
  }

} 