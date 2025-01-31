import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Categorie {
  final int? id, parentId, generation;
  final String? nom, slug, image;
  final bool? hasChild;

  const Categorie({
    this.id,
    this.parentId,
    this.generation,
    this.nom,
    this.slug,
    this.image,
    this.hasChild = false,
  });

  factory Categorie.fromJson(Map<String, dynamic> json) {
    return Categorie(
      id: json['id'] as int?,
      parentId: json['parent_id'] as int?,
      generation: json['generation'] as int?,
      nom: json['nom'] as String,
      slug: json['slug'] as String,
      image: json['image'] as String,
      hasChild: json['has_child'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'parent_id': parentId,
        'generation': generation,
        'nom': nom,
        'slug': slug,
        'image': image,
        'has_child': hasChild,
      };

  @override
  String toString() =>
      'Categorie(id: $id, nom: $nom, slug: $slug, generation: $generation)';
}

final prefs = Get.find<SharedPreferences>(tag: 'prefs');

class CoreProvider extends GetConnect {
  final Logger _logger = Logger();
  String? ville;

  @override
  void onInit() async {
    httpClient.baseUrl = baseUrl;
    this.ville = await prefs.getString('ville');
    _logger.i(ville!);
  }

  Future<List<Categorie>> getAllCategories() async {
    try {
      final response =
          await get('https://c-moinscher.ci/api/shop/all-categories');

      if (response.statusCode == 200) {
        final data = response.body as Map<String, dynamic>;

        if (data.containsKey('categories')) {
          final categories = data['categories'] as List;
          _logger.d('Fetched Categories: $categories');
          return categories
              .map((element) => Categorie.fromJson(element))
              .toList();
        } else {
          throw Exception(
              "The 'categories' key is not present in the response");
        }
      } else {
        throw Exception(
            "Failed to retrieve categories: ${response.statusCode}");
      }
    } catch (e) {
      _logger.e('Error fetching categories');
      rethrow;
    }
  }

  Future<Response> getCategories() async =>
      await get("https://c-moinscher.ci/api/shop/categories");

  Future<Response> getProductsAlt({
    Map<String, dynamic>? filters,
    int? categoryId,
    String? search,
    String? barcode,
  }) async {
    this.ville = await prefs.getString('ville');
    String url = "https://c-moinscher.ci/api/shop/produits/?ville=${this.ville}";
    final queryParams = <String, dynamic>{};

    if (categoryId != null) queryParams['categorie'] = categoryId;
    if (search != null && search.isNotEmpty) queryParams['search'] = search;
    if (barcode != null && barcode.isNotEmpty) queryParams['barcode'] = barcode;

    return await get(url, query: queryParams);
  }

  Future<Response> getVilles() async =>
      await get("https://c-moinscher.ci/api/shop/villes");

  Future<Response> getPropositions(int productId) async => await get(
      "https://c-moinscher.ci/api/shop/produits/$productId/propositions?ville=${await prefs.getString('ville')}");

  Future<Response> getProductByBarCode({String? barcode}) async =>
      await get("https://c-moinscher.ci/api/shop/produits",
          query: {'code_barre': barcode});

  Future<Response> getResume(Map<String, dynamic> body) async {
    return await httpClient.post(
      "https://c-moinscher.ci/api/shop/resume",
      body: body,
      headers: {"Accept": "application/json"},
    );
  }

  Future<Response> getCategorieChildren(int id) async {
    return await httpClient.get(
      "https://c-moinscher.ci/api/shop/categorie/$id/children/",
      headers: {"Accept": "application/json"},
    );
  }

  Future<Response<dynamic>> getProducts(
      {Map<String, dynamic>? filters,
      int? categorie = null,
      String? search,
      String? barcode,
      int? sous_sous_categorie_id = null
  }) async {
    String url = "https://c-moinscher.ci/api/shop/produits/";

    if (sous_sous_categorie_id != null) {
      url = "$url?sous_sous_categorie_id=$sous_sous_categorie_id";
    }

    if (categorie != null && sous_sous_categorie_id == null) {
      url = "$url?categorie=$categorie";
    }

    if(categorie == null && sous_sous_categorie_id == null){
      url = "${url}?";
    }

    if (search != null && search.isNotEmpty) {
      url = "$url&search=$search";
    }

    if (barcode != null && barcode.isNotEmpty) {
      url = "$url?barcode=$barcode";
    }
    Logger().d(url);
    return await get(url);
  }

  Future<Response<dynamic>> getProductsFromParentCategorie(
      int categorie_id) async {
    return await get(
        "https://c-moinscher.ci/api/shop/categorie-parent/$categorie_id/produits");
  }
}
