import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:bloc_sample_app/constants.dart';
import 'package:bloc_sample_app/presentation/blocs/bloc.dart';
import 'package:bloc_sample_app/presentation/widgets/widgets.dart';

class AddPageAppBarWidget implements SliverPersistentHeaderDelegate {
  AddPageAppBarWidget({
    this.minExtent,
    @required this.maxExtent,
  });
  final double minExtent;
  final double maxExtent;

  bool _show;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    _show = shrinkOffset > maxExtent * .50;
    final PlantBloc plantBloc = BlocProvider.of<PlantBloc>(context);
    final Color primaryColor =
        Theme.of(context).primaryTextTheme.headline6.color;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: Theme.of(context).primaryColor,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 60.0,
            ),
            AnimatedOpacity(
              opacity: _show ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child:
                  BlocBuilder<PlantBloc, PlantState>(builder: (context, state) {
                if (state is PlantStateImageSet &&
                    state.plantsCompanion.image.present)
                  return CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    backgroundImage:
                        Image.memory(state.plantsCompanion.thumbnail.value)
                            .image,
                    radius: 30.0,
                  );
                else
                  return CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    backgroundImage: Image.asset(
                      PLANT_DEFAULT_ICON_PATH,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ).image,
                    radius: 30.0,
                  );
              }),
            ),
          ],
        ),
        AnimatedOpacity(
          opacity: !_show ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: ImageWidget(),
        ),
        Positioned(
          top: 20.0,
          child: IconButton(
            icon: Icon(
              Icons.close,
              color: primaryColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Positioned(
          top: 20.0,
          right: 0.0,
          child: BlocBuilder<PlantBloc, PlantState>(
            //bloc: _plantBloc,
            builder: (context, state) => IconButton(
              icon: Icon(
                Icons.check,
                color: state.plantsCompanion.name.present &&
                        state.plantsCompanion.name.value.isNotEmpty
                    ? primaryColor
                    : null,
              ),
              onPressed: state.plantsCompanion.name.present &&
                      state.plantsCompanion.name.value.isNotEmpty
                  ? () {
                      Navigator.pop(context);
                      plantBloc.add(
                        PlantEventSave(plantsCompanion: state.plantsCompanion),
                      );
                    }
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
