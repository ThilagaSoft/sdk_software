import 'package:code_task/model/recipes_model.dart';

import 'api_client.dart';

class RecipeRepository {
  final ApiClient apiClient;

  RecipeRepository({required this.apiClient});

  Future<List<Recipe>> fetchRecipes() async {
    try {
      final data = await apiClient.get('https://dummyjson.com/recipes');
      final response = RecipeResponse.fromJson(data);
      return response.recipes;
    } on ApiException catch (e) {
      throw FetchDataException('API Error: ${e.message}');
    } catch (e) {
      throw FetchDataException('Unknown Error: $e');
    }
  }
}

class FetchDataException implements Exception {
  final String message;
  FetchDataException(this.message);

  @override
  String toString() => 'FetchDataException: $message';
}
