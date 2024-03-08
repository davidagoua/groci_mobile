import 'package:get/get.dart';

class CoreProvider extends GetConnect {

  final BASE_URL = 'https://c-moinscher.ci/api/shop';

  @override
  void onInit() {
    httpClient.baseUrl = 'https://c-moinscher.ci/api/shop';
  }

  Future<Response<dynamic>> getCategories() async => await get("https://c-moinscher.ci/api/shop/categories");

  Future<Response<dynamic>> getroducts({Map<String, dynamic>? filters, int? categorie, String? search}) async {
    String url = "https://c-moinscher.ci/api/shop/produits/";
    if(categorie != null){
      print(categorie);
      url = "$url?categorie=$categorie";
    }

    if(search != null && search.isNotEmpty){
      url = "$url?search=$search";
    }

    return await get(url);
  }

  Future<Response<dynamic>> getVilles() async => await get("https://c-moinscher.ci/api/shop/villes");

  Future<Response<dynamic>> getPropositions(int product_id) async => await get("https://c-moinscher.ci/api/shop/produits/$product_id/propositions");

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
