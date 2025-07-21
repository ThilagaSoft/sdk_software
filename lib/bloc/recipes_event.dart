import 'package:code_task/model/recipes_model.dart';

abstract class RecipesEvent {}


class FetchRecipes extends RecipesEvent {}
class SelectRecipesEvent extends RecipesEvent
{
  Recipe selectRecipe;
  SelectRecipesEvent({required this.selectRecipe});
}
