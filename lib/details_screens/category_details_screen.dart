import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movies_app/bloc/cubit.dart';
import 'package:movies_app/bloc/states.dart';
import 'package:movies_app/main.dart';
import 'package:movies_app/models/category_model.dart';
import 'package:movies_app/repo/home_local_ds_impl.dart';
import 'package:movies_app/repo/home_remote_ds_impl.dart';
import '../colors_and_theme/app_colors.dart';
import '../movie_item.dart';

class CategoryDetailsScreen extends StatelessWidget {
  static const String routeName = "categoryScreen";
  const CategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)?.settings.arguments as CategoryModel;

    return Scaffold(
        appBar: AppBar(
          title: Text("${model.label} Category",
              style: GoogleFonts.inter(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w400)),
          iconTheme: IconThemeData(size: 30),
        ),
        body: BlocProvider(
            create: (context) =>
                HomeCubit(isConnected ? HomeRemoteDSImpl() : HomeLocalDSImpl())
                  ..categoryMovies(model.id),
            child: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is HomeGetCategoryLoadingState) {
                  Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: AppColors.colorYellow, size: 50),
                  );
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                            color: Color(0xff707070),
                            indent: 20,
                            endIndent: 20,
                          ),
                      itemBuilder: (context, index) => MovieItem(
                            results: HomeCubit.get(context)
                                    .categoryResponse
                                    ?.results ??
                                [],
                            index: index,
                          ),
                      itemCount: HomeCubit.get(context)
                              .categoryResponse
                              ?.results
                              ?.length ??
                          0),
                );
              },
            )));
  }
}
