import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_sample_app/constants.dart';
import 'package:bloc_sample_app/utils/global_translations.dart';
import 'package:bloc_sample_app/presentation/blocs/bloc.dart';
import 'pages.dart';
import 'package:bloc_sample_app/repositories/repositories.dart';
import 'package:bloc_sample_app/local_data_sources/local_data_sources.dart';

class HomePage extends StatelessWidget {
  bool _languageChangedCondition(
          TranslationState previous, TranslationState current) =>
      current is TranslationStateSuccess;

  StreamBuilder<List<Plant>> _buildPlantsList(BuildContext context) {
    final PlantsDao plantsDao =
        RepositoryProvider.of<AppDatabase>(context).plantsDao;
    return StreamBuilder<List<Plant>>(
      stream: plantsDao.watchAll(),
      builder: (BuildContext context, AsyncSnapshot<List<Plant>> snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        final plants = snapshot.data;
        const int preferableBannerIndex = 6;
        int bannerIndex = plants.length > preferableBannerIndex
            ? preferableBannerIndex
            : plants.length;
        return ListView.builder(
          itemCount: plants.length,
          itemBuilder: (_, index) => _buildListItem(plants[index], plantsDao),
        );
      },
    );
  }

  Widget _buildListItem(Plant plant, PlantsDao plantsDao) {
    return ListTile(
      leading: plant.thumbnail == null
          ? CircleAvatar(
              backgroundImage: Image.asset(
                PLANT_DEFAULT_ICON_PATH,
                width: 30.0,
              ).image,
            )
          : CircleAvatar(
              backgroundImage: Image.memory(plant.thumbnail).image,
            ),
      title: Text(plant.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<TranslationBloc, TranslationState>(
          condition: _languageChangedCondition,
          builder: (BuildContext context, TranslationState state) => Text(
            allTranslations.text('app_title'),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            BlocBuilder<TranslationBloc, TranslationState>(
              builder: (BuildContext context, TranslationState state) {
                if (state is TranslationStateSuccess) {
                  return Expanded(child: _buildPlantsList(context));
                }
                if (state is TranslationStateLoadInProgress) {
                  return CircularProgressIndicator();
                }
                return Container();
              },
            ),
            /*
            adMobRepository.showBanner(
              context,
              AdmobBannerSize.LARGE_BANNER,
            ),

             */
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<TranslationBloc, TranslationState>(
        condition: _languageChangedCondition,
        builder: (BuildContext context, TranslationState state) =>
            FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddPlantPage()),
          ),
          tooltip: allTranslations.text('add_plant'),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
