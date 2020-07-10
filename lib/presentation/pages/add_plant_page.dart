import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_sample_app/presentation/blocs/bloc.dart';
import 'package:bloc_sample_app/repositories/repositories.dart';
import 'package:bloc_sample_app/utils/global_translations.dart';
import 'package:bloc_sample_app/local_data_sources/local_data_sources.dart';
import 'package:bloc_sample_app/presentation/widgets/widgets.dart';

class AddPlantPage extends StatefulWidget {
  @override
  _AddPlantPageState createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  PlantBloc _plantBloc;
  @override
  void initState() {
    super.initState();
    if (mounted)
      _plantBloc = PlantBloc(
        plantRepository: PlantRepository(
          plantsDao: RepositoryProvider.of<AppDatabase>(context).plantsDao,
        ),
      );
  }

  @override
  void dispose() {
    _plantBloc.close();
    super.dispose();
  }

  /*
  @override
  Widget _build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          allTranslations.text('add_plant'),
        ),
        actions: <Widget>[
          BlocBuilder<PlantBloc, PlantState>(
            bloc: _plantBloc,
            builder: (context, state) => IconButton(
              icon: Icon(Icons.check),
              onPressed: state.plantsCompanion.name.present &&
                      state.plantsCompanion.name.value.isNotEmpty
                  ? () {
                      _plantBloc.plantRepository.plantsDao
                          .insertPlant(state.plantsCompanion);
                      Navigator.pop(context);
                    }
                  : null,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: BlocProvider.value(
          value: _plantBloc,
          child: ListView(
            children: <Widget>[
              ImageWidget(),
              NameWidget(name: ''),
            ],
          ),
        ),
      ),
    );
  }

   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          BlocProvider.value(
            value: _plantBloc,
            child: SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: AddPageAppBarWidget(
                minExtent: 90.0,
                maxExtent: 300.0,
              ),
            ),
          ),
          /*
          SliverAppBar(
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              //stretchModes: [StretchMode.blurBackground],
              background: BlocProvider.value(
                value: _plantBloc,
                child: ImageWidget(),
              ),
            ),
            pinned: true,
            floating: true,
            snap: true,
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              allTranslations.text('add_plant'),
            ),
            actions: <Widget>[
              BlocBuilder<PlantBloc, PlantState>(
                bloc: _plantBloc,
                builder: (context, state) => IconButton(
                  icon: Icon(Icons.check),
                  onPressed: state.plantsCompanion.name.present &&
                          state.plantsCompanion.name.value.isNotEmpty
                      ? () {
                          _plantBloc.plantRepository.plantsDao
                              .insertPlant(state.plantsCompanion);
                          Navigator.pop(context);
                        }
                      : null,
                ),
              ),
            ],
          ),

            */

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int item) {
                if (item == 0)
                  return BlocProvider.value(
                    value: _plantBloc,
                    child: NameWidget(name: ''),
                  );
                else
                  return Container(
                    height: 100.0,
                    child: Text('item'),
                  );
              },
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
