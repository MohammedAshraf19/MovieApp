import 'package:flutter/material.dart';
import 'package:my_movie_app/modules/genres/genre_movie.dart';

import '../../models/genre_model.dart';
import '../../shared/style/color_manager.dart';
import '../../shared/style/values_manager.dart';

class GenresList extends StatefulWidget {
  final GenreModel genres;
  const GenresList({Key? key,required this.genres}) : super(key: key);

  @override
  State<GenresList> createState() => _GenresListState(genres);
}

class _GenresListState extends State<GenresList> with SingleTickerProviderStateMixin{
  final GenreModel genreModel;
  _GenresListState(this.genreModel);
  TabController? _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length:genreModel.genres!.length , vsync: this);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _tabController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: DefaultTabController(
        length: genreModel.genres!.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: ColorManager.grey,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: ColorManager.white,
                isScrollable: true,
                labelStyle: const TextStyle(
                  color: ColorManager.white
                ),
                physics: const BouncingScrollPhysics(),
                labelColor: ColorManager.white,
                tabs: genreModel.genres!.map((e) {
                  return Container(
                    padding: const EdgeInsets.only(bottom: AppSize.s16,top: AppSize.s12),
                    child: Text(
                      e.name!,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorManager.lightGrey),
                    ),
                  );
                }).toList(),
              ),
            ),

          ),
          body: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: genreModel.genres!.map((e) {
              return GenreMovie(genreId: e.id!,);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
