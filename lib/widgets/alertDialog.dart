import 'package:flutter/material.dart';
import 'package:movies_app_assignment_1828194/models/movieModel.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({Key? key, this.moviesList, required this.onClick})
      : super(key: key);

  final Movies? moviesList;
  final Function(String name, String director, String url) onClick;

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final directorNameController = TextEditingController();
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.moviesList != null) {
      final movies = widget.moviesList!;

      nameController.text = movies.name;
      directorNameController.text = movies.director;
      urlController.text = movies.posterUrl;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    directorNameController.dispose();
    urlController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.moviesList != null;
    final title = isEditing ? 'Edit Movie' : 'Add Movie';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildName(),
              SizedBox(height: 8),
              buildDirector(),
              SizedBox(height: 8),
              buildUrl(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildName() => TextFormField(
        controller: nameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Movie Name',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildDirector() => TextFormField(
      controller: directorNameController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter Director Name',
      ),
      validator: (name) =>
          name != null && name.isEmpty ? 'Enter a name' : null);
  Widget buildUrl() => TextFormField(
      controller: urlController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter Poster Url',
      ),
      validator: (name) =>
          name != null && name.isEmpty ? 'Enter a name' : null);

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final name = nameController.text;
          final dir = directorNameController.text;
          final img = urlController.text;
          widget.onClick(name,dir,img);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
