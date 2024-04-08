import 'package:get/get.dart';

class CoreProvider extends GetConnect {

  final BASE_URL = 'https://c-moinscher.ci/api/shop';

  @override
  void onInit() {
    httpClient.baseUrl = 'https://c-moinscher.ci/api/shop';
  }

  Future<Response<dynamic>> getCategories() async => await get("https://c-moinscher.ci/api/shop/categories");

  Future<Response<dynamic>> getroducts({Map<String, dynamic>? filters, int? categorie, String? search, String? barcode}) async {
    String url = "https://c-moinscher.ci/api/shop/produits/";
    if(categorie != null){
      url = "$url?categorie=$categorie";
    }

    if(search != null && search.isNotEmpty){
      url = "$url&search=$search";
    }

    if(barcode != null && barcode.isNotEmpty){
      url = "$url?barcode=$barcode";
    }

    return await get(url);
  }

  Future<Response<dynamic>> getVilles() async => await get("https://c-moinscher.ci/api/shop/villes");

  Future<Response<dynamic>> getPropositions(int product_id) async => await get("https://c-moinscher.ci/api/shop/produits/$product_id/propositions");

  Future<Response<dynamic>> getProductByBarCode(String barcode) async => await get("https://c-moinscher.ci/api/shop/produits/?code_barre=$barcode");

  Future <Response<dynamic>> getresume(Map<String, dynamic> body) async {
    final response = await this.httpClient.post(
      "$BASE_URL/resume",
      body: body,
      headers: {
        "Accept":"application/json"
      }
    );
    return response;
  }
}
