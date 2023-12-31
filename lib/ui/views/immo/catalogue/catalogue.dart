import 'package:flutter/material.dart';
import 'package:mobile/models/place.dart';
import 'package:mobile/ui/views/immo/catalogue/catalogueViewModel.dart';
import 'package:mobile/ui/widget/place_card.dart';
import 'package:stacked/stacked.dart';

class Catalogue extends StatefulWidget {
  const Catalogue({super.key, required this.places});
  /// this list should come from a call done in the model remmove  it when implemented
  final List<TelaPlace> places;

  @override
  State<Catalogue> createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQuery = MediaQuery.of(context);
    return ViewModelBuilder<CatalogueViewModel>.reactive(
      viewModelBuilder: () => CatalogueViewModel(),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Mon catalogue', style: TextStyle(color: Colors.white)),
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () => model.navigateToNewplace(),
                    child: const Icon(Icons.add_outlined, size: 32, color: Colors.white,)),
              )
            ],
            elevation: 5,
          ),
          backgroundColor: Colors.white,
          body:  ListView(
            scrollDirection: Axis.vertical,
            children: widget.places.map((e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () => model.navigateToVisite(e),
                  child: PlaceCard(place: e, image: 'assets/images/p4.webp')
              ),
            )).toList(),
          ),
        bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1),
          child: ElevatedButton(
            onPressed: () => model.navigateToNewplace(),
            style: ElevatedButton.styleFrom(
              alignment: Alignment.center,
                backgroundColor: Theme.of(context).colorScheme.primary,
                fixedSize: Size(_mediaQuery.size.width-8, 40),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: Text(
                'Ajouter',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
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
