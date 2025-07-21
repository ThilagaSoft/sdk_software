import 'package:code_task/bloc/recipes_event.dart';
import 'package:code_task/bloc/recipes_state.dart';
import 'package:code_task/repository/receipes_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState>
{
  final RecipeRepository recipeRepository;

  RecipesBloc(this.recipeRepository) : super(RecipeInitial()) {
    on<FetchRecipes>((event, emit) async {
      emit(RecipeLoading());
      try {
        final recipes = await recipeRepository.fetchRecipes();
        emit(RecipeLoaded(recipes));
      } catch (e) {
        emit(RecipeError(e.toString()));
      }
    });
    on<SelectRecipesEvent>((event, emit)
    {
     emit(SelectRecipes(selectRecipe: event.selectRecipe));
    });
  }
}
