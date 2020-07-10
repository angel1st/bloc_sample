import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moor/moor.dart' as moor;
import 'package:bloc_sample_app/presentation/blocs/bloc.dart';
import 'package:bloc_sample_app/constants.dart';

class ImageWidget extends StatefulWidget {
  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _getImage(ImageSource imageSource) async {
    final PickedFile pickedFile = await picker.getImage(source: imageSource);
    BlocProvider.of<PlantBloc>(context)
        .add(PlantEventNewImage(fileName: pickedFile.path));
  }

  Widget _buildImage(moor.Uint8List byteImage) {
    if (null != byteImage) {
      Image img = Image.memory(
        byteImage,
        width: double.infinity,
        fit: BoxFit.cover,
      );
      return img;
    } else {
      return Image.asset(
        PLANT_DEFAULT_ICON_PATH,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }

  Widget _buildImagePicker(moor.Uint8List byteImage) {
    final Color primaryColor =
        Theme.of(context).primaryTextTheme.headline6.color;
    final double bottomMargin = 10.0;
    final double horizontalMargin = 20.0;
    return Stack(
      children: <Widget>[
        _buildImage(byteImage),
        Positioned(
          bottom: bottomMargin,
          left: horizontalMargin,
          child: IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: primaryColor,
            ),
            onPressed: () => _getImage(ImageSource.camera),
          ),
        ),
        Positioned(
          bottom: bottomMargin,
          right: horizontalMargin,
          child: IconButton(
            icon: Icon(
              Icons.photo_library,
              color: primaryColor,
            ),
            onPressed: () => _getImage(ImageSource.gallery),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantBloc, PlantState>(
      condition: (PlantState prev, PlantState curr) =>
          curr is PlantStateImageSet || curr is PlantStateImageIsLoading,
      builder: (BuildContext context, PlantState state) {
        if (state is PlantStateImageSet) {
          return _buildImagePicker(state.plantsCompanion.image.present
              ? state.plantsCompanion.image.value
              : null);
        }
        if (state is PlantStateImageIsLoading)
          return Center(
            child: Container(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ),
          );
        return _buildImagePicker(null);
      },
    );
  }
}
