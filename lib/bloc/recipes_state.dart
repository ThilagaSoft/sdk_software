import 'package:code_task/model/recipes_model.dart';

abstract class RecipesState {}

class RecipeInitial extends RecipesState {}

class RecipeLoading extends RecipesState {}

class RecipeLoaded extends RecipesState
{
  final List<Recipe> recipes;
  RecipeLoaded(this.recipes);
}

class RecipeError extends RecipesState
{
  final String message;
  RecipeError(this.message);
}
class SelectRecipes extends RecipesState
{
  Recipe selectRecipe;
  SelectRecipes({required this.selectRecipe});
}
