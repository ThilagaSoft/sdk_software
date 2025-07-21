import 'package:code_task/bloc/recipes_bloc.dart';
import 'package:code_task/bloc/recipes_event.dart';
import 'package:code_task/bloc/recipes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipes Screen"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children:
        [
          BlocBuilder<RecipesBloc, RecipesState>(
            buildWhen: (previous, current) => current is RecipeLoaded || current is RecipeLoading,
            builder: (context, state)
            {
              if (state is RecipeLoading)
              {
                return SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (ctx, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 200,
                                width: 200,
                                color: Colors.grey.shade300,
                              ),
                              const SizedBox(width: 8),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 16,
                                      color: Colors.grey.shade300,
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      width: 80,
                                      height: 12,
                                      color: Colors.grey.shade300,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              else if (state is RecipeLoaded)
              {
                return SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.recipes.length,
                    itemBuilder: (ctx, index) {
                      final recipe = state.recipes[index];
                      return InkWell(
                        onTap: () {
                          context
                              .read<RecipesBloc>()
                              .add(SelectRecipesEvent(selectRecipe: recipe));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  recipe.image,
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  recipe.name,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              else
              {
                return const SizedBox(
                  height: 220,
                  child: Center(child: Text("No Data")),
                );
              }
            },
          ),
          BlocBuilder<RecipesBloc, RecipesState>(
            buildWhen: (prev,current)=>current is SelectRecipes,

            builder: (context, state)
            {
              if (state is SelectRecipes)
              {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        state.selectRecipe.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Image.network(
                        state.selectRecipe.image,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                );
              }
              return Container();

            },
          ),
        ],
      ),
    );
  }
}
