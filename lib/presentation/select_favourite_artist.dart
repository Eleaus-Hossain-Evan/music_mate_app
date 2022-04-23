import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:music_mates_app/core/constants.dart';
import 'package:music_mates_app/data/data_export.dart';
import 'package:music_mates_app/presentation/query_document_provider.dart';
import 'package:music_mates_app/presentation/widgets/item_select_artist.dart';

import '../data/model/error.dart';
import '../main.dart';
import 'widgets/loading_spinner.dart';
import 'widgets/query_wrapper.dart';

class SelectFavouriteArtist extends StatefulWidget {
  const SelectFavouriteArtist({Key? key}) : super(key: key);

  @override
  _SelectFavouriteArtistState createState() => _SelectFavouriteArtistState();
}

class _SelectFavouriteArtistState extends State<SelectFavouriteArtist> {
  List<int> selectedArtist = [];

  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    final list = List.generate(9, (_) => ArtistModel.dummy(id_: _));

    return Mutation(
      options: MutationOptions(
        document: gql(context.queries.updateUser()),
        onCompleted: (_) => Navigator.popAndPushNamed(context, Routes.home),
      ),
      builder: (RunMutation runMutation, QueryResult? result) {
        if (result!.isLoading) return const LoadingSpinner();

        if (result.hasException) {
          context.showError(ErrorModel.fromString(result.exception.toString()));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: TextButton(
            style: ButtonStyle(
              enableFeedback: isEnabled,
              backgroundColor: MaterialStateProperty.all(
                Colors.grey[300],
              ),
            ),
            onPressed: () => _onButtonPressed(isEnabled, runMutation, context),
            child: SizedBox(
              width: double.infinity,
              child: Center(
                child: Opacity(
                  opacity: isEnabled ? 1 : 0.2,
                  child: const Text(
                    "DONE",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onButtonPressed(
      bool isEnabled, RunMutation<dynamic> runMutation, BuildContext context) {
    if (isEnabled) {
      runMutation(
        {
          'googleId': context.retrieveGoogleId,
          'favouriteArtists': selectedArtist,
        },
      );
    } else {
      context.showError(
        ErrorModel.fromString("Please select your favorite artist"),
      );
    }
  }

  void onTap(int artistId) {
    if (selectedArtist.contains(artistId)) {
      selectedArtist.remove(artistId);
    } else {
      selectedArtist.add(artistId);
    }

    setState(() {});
  }
}

class _DoneButton extends StatelessWidget {
  const _DoneButton({
    Key? key,
    required this.selectedArtist,
  }) : super(key: key);

  final List<int> selectedArtist;

  @override
  Widget build(BuildContext context) {
    final isEnabled = selectedArtist.length >= 2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: TextButton(
        style: ButtonStyle(
          enableFeedback: isEnabled,
          backgroundColor: MaterialStateProperty.all(
            Colors.grey[300],
          ),
        ),
        onPressed: () =>
            isEnabled ? Navigator.pop(context, selectedArtist) : null,
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Opacity(
              opacity: isEnabled ? 1 : 0.2,
              child: const Text(
                "DONE",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
