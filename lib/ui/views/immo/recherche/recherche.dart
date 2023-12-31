import 'package:flutter/material.dart';
import 'package:mobile/models/commune.dart';
import 'package:mobile/ui/views/immo/recherche/rechercheViewModel.dart';
import 'package:stacked/stacked.dart';

class Recherche extends StatefulWidget {
  late bool isBureau;
  Recherche({super.key, required this.isBureau});

  @override
  State<Recherche> createState() => _RechercheState();
}

class _RechercheState extends State<Recherche> {

  int type = 1;
  String code = '';
  @override
  Widget build(BuildContext context) {
    MediaQueryData mq =MediaQuery.of(context);
    return ViewModelBuilder<RechercheViewModel>.reactive(
      viewModelBuilder: () => RechercheViewModel(),
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            centerTitle: true,
            title: const Text('Recherche',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.3,
                  color: Colors.white
              ),
            ),
            elevation: 5,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () { Scaffold.of(context).openDrawer(); },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ),
          drawer: Drawer(
            elevation: 5,
            child: SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DrawerHeader(child: Center(
                      child: Image.asset('assets/images/logo.png'),
                    )),
                    TextButton(
                        onPressed: (){
                          model.navigateToAcceuil();
                        },
                        child: Text('Acceuil')
                    ),
                    TextButton(
                        onPressed: (){
                          model.navigateToProfile();
                        },
                        child: Text('profile')
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: widget.isBureau? Colors.white : Theme.of(context).colorScheme.primary,

                        ),
                        onPressed: (){
                          model.navigateToRechercheLogement();
                        },
                        child: Text('Trouver un logement',
                          style: TextStyle(
                              color: !widget.isBureau? Colors.white : Theme.of(context).colorScheme.primary,
                          ),)
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: !widget.isBureau? Colors.white : Theme.of(context).colorScheme.primary,

                        ),
                        onPressed: (){
                          model.navigateToRechercheBureau();
                        },
                        child: Text('Trouver un Bureau',
                          style: TextStyle(
                            color: widget.isBureau? Colors.white : Theme.of(context).colorScheme.primary,
                          ),)
                    ),
                    TextButton(
                        onPressed: (){
                          model.navigateToTV();
                        },
                        child: Text('Tela TV')
                    ),
                    TextButton(
                        onPressed: (){
                          model.navigateToEbank();
                        },
                        child: Text('Tela Finance')
                    ),
                  ]),
            ),
          ),
          body: Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            widget.isBureau = !widget.isBureau;
                          });
                        },
                        style: TextButton.styleFrom(
                          fixedSize: Size.fromWidth(mq.size.width * 0.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: Colors.white,
                          elevation: 8,
                        ),
                        child: Text(
                          widget.isBureau ? 'Bureau' : 'Logement',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2
                          ),
                        ),
                      ),
                    ),

                    Divider(),
                    const Text('Commune',
                      style: TextStyle(
                          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),),
                    Divider(),
                    /// Commune
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PopupMenuButton(
                          color: Colors.white,
                          onSelected: (commm){
                            setState(() {
                              model.commune = commm;
                            });
                          },
                          offset: const Offset(100, 0),
                          itemBuilder: (BuildContext context) => model.communes.map((commune) => PopupMenuItem(
                            value: commune,
                            child: Text(commune.name,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500),

                            ),
                          )).toList(),
                          child: Text(model.commune.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary, fontSize: 24, fontWeight: FontWeight.w600),)
                      ),
                    ),

                    ///TYPE
                    Divider(),
                    const Text('Type de Bien',
                        style: TextStyle(
                        color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),),
                    Divider(),

                    /// IS APPARTEMENT
                    ListTile(
                      title: Text("Appartement",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      leading: Radio(
                        value: 1,
                        groupValue: type,
                        onChanged: (value) {
                          setState(() {
                            type = 1;
                            model.isAppart = true;
                            model.isDuplex = false;
                            model.isMaisonBasse = false;
                          });
                        },
                          fillColor: MaterialStateProperty.all(Colors.black),
                          activeColor: Theme.of(context).colorScheme.primary
                      ),
                    ),
                    ListTile(
                      title: Text("Maison basse",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      leading: Radio(
                        value: 2,
                        groupValue: type,
                        onChanged: (value) {
                          setState(() {
                            type = 2;
                            model.isAppart = false;
                            model.isDuplex = false;
                            model.isMaisonBasse = true;
                          });
                        },
                          fillColor: MaterialStateProperty.all(Colors.black),
                          activeColor: Theme.of(context).colorScheme.primary
                      ),
                    ),
                    ListTile(
                      title: Text("Duplex",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      leading: Radio(
                        value: 3,
                        groupValue: type,
                        onChanged: (value) {
                          setState(() {
                            type = 3;
                            model.isAppart = false;
                            model.isDuplex = true;
                            model.isMaisonBasse = false;
                          });
                        },
                          fillColor: MaterialStateProperty.all(Colors.black),
                          activeColor: Theme.of(context).colorScheme.primary
                      ),
                    ),

                    /// IS Haut standing avec piscine
                    CheckboxListTile(
                        value: model.isHautStandingPicine,
                      onChanged: (r) {
                        setState(() {
                          model.isHautStandingPicine = r!;
                        });
                      },
                      title: Text(
                        "Haut standing avec piscine",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                        checkColor: Colors.white,
                        activeColor: Theme.of(context).colorScheme.primary
                    ),
                    /// IS Haut standing sans piscine
                    CheckboxListTile(
                        value: model.isHautStanding,
                      onChanged: (r) {
                        setState(() {
                          model.isHautStanding = r!;
                        });
                      },
                      title: Text(
                        "Haut standing sans piscine",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                        checkColor: Colors.white,
                        activeColor: Theme.of(context).colorScheme.primary
                    ),
                    /// NOMBRE DE PIECE
                    Divider(),
                    const Text('Nombre de pièces',
                      style: TextStyle(
                          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: (){
                          setState(() {
                            if (model.nombreDePieces>1) {
                              model.nombreDePieces--;
                            }
                          });
                        },
                            icon: Icon(Icons.remove)
                        ),
                        Text('${model.nombreDePieces}',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                        IconButton(onPressed: (){
                          setState(() {
                            if (model.nombreDePieces<40) {
                              model.nombreDePieces++;
                            }
                          });
                        },
                            icon: Icon(Icons.add)
                        ),
                      ],
                    ),

                    /// NOMBRE DE PIECE d'eau
                    Divider(),
                    const Text('Nombre de sales d\'eau',
                      style: TextStyle(
                          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: (){
                          setState(() {
                            if (model.nombreDeSalleDeau>1) {
                              model.nombreDeSalleDeau--;
                            }
                          });
                        },
                            icon: Icon(Icons.remove)
                        ),
                        Text('${model.nombreDeSalleDeau}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                        IconButton(onPressed: (){
                          setState(() {
                            if (model.nombreDeSalleDeau<40) {
                              model.nombreDeSalleDeau++;
                            }
                          });
                        },
                            icon: Icon(Icons.add)
                        ),
                      ],
                    ),

                    ///TYPE
                    Divider(),
                    const Text('Commoditées additionnelles',
                      style: TextStyle(
                          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),),
                    Divider(),
                    /// IS Cours avant
                    CheckboxListTile(
                        value: model.hasCoursAvant,
                      onChanged: (r) {
                        setState(() {
                          model.hasCoursAvant = r!;
                        });
                      },
                      title: Text(
                        "Cours Avant",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                        checkColor: Colors.white,
                        activeColor: Theme.of(context).colorScheme.primary
                    ),
                    /// IS Cours Arriere
                    CheckboxListTile(
                        value: model.hasCoursArriere,
                      onChanged: (r) {
                        setState(() {
                          model.hasCoursArriere = r!;
                        });
                      },
                      title: Text(
                        "Cours Arriere",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                        checkColor: Colors.white,
                        activeColor: Theme.of(context).colorScheme.primary
                    ),
                    /// IS balcon avant
                    CheckboxListTile(
                        value: model.hasBalconAvant,
                      onChanged: (r) {
                        setState(() {
                          model.hasBalconAvant = r!;
                        });
                      },
                      title: Text(
                        "Balcon Avant",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                        checkColor: Colors.white,
                        activeColor: Theme.of(context).colorScheme.primary
                    ),
                    /// IS Balcon Arriere
                    CheckboxListTile(
                        value: model.hasBalconArriere,
                      onChanged: (r) {
                        setState(() {
                          model.hasBalconArriere = r!;
                        });
                      },
                      title: Text(
                        "Balcon Arriere",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                        checkColor: Colors.white,
                        activeColor: Theme.of(context).colorScheme.primary
                    ),
                    /// IS Piscine
                    // CheckboxListTile(
                    //     value: model.hasPiscine,
                    //   onChanged: (r) {
                    //     setState(() {
                    //       model.hasPiscine = r!;
                    //     });
                    //   },
                    //   title: Text(
                    //     "Piscine",
                    //     style: TextStyle(
                    //         color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500),
                    //   ),
                    //     checkColor: Colors.white,
                    //     activeColor: Theme.of(context).colorScheme.primary
                    // ),
                    /// IS GARAGE
                    CheckboxListTile(
                        value: model.hasGarage,
                      onChanged: (r) {
                        setState(() {
                          model.hasGarage = r!;
                        });
                      },
                      title: Text(
                        "Garage",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                        checkColor: Colors.white,
                        activeColor: Theme.of(context).colorScheme.primary
                    ),
                    /// has Gardien
                    CheckboxListTile(
                        value: model.hasGardien,
                      onChanged: (r) {
                        setState(() {
                          model.hasGardien = r!;
                        });
                      },
                      title: Text(
                        "Gardien",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                        checkColor: Colors.white,
                        activeColor: Theme.of(context).colorScheme.primary
                    ),

                    ///Search
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          model.havePass? model.search() : showDialog(context: context, builder: (buildContext) => Dialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
                                  child: Text('Entrez le code de votre pass visite si dessous pour vérification',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.1
                                    ),
                                  ),
                                ),
                                 Padding(
                                  padding: EdgeInsets.all(24.0),
                                  child: SizedBox(
                                    width: mq.size.width*0.7,
                                    child: TextFormField(
                                      autofocus: true,
                                      keyboardType: const TextInputType.numberWithOptions(signed: true,),
                                      maxLength: 8,
                                      minLines: 1,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          Icons.credit_card,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                        suffix: InkWell(
                                          onTap: () => model.search(),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width/5,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context).colorScheme.primary,
                                                borderRadius: BorderRadius.circular(30)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('vérifier',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 1.1
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        labelText: 'Pass visites',
                                        labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                                        enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                                        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                                        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                                      ),
                                      onChanged: (value) {
                                        code = value;
                                      },
                                      // validator: (value) {
                                      //
                                      // },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                      onPressed: () => model.navigateToVisiteAbonnement(true),
                                      child: Text('Acheter un pass',
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.primary,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600
                                        ),
                                      )
                                  ),
                                )

                              ],
                            ),

                          ));
                          },
                        style: TextButton.styleFrom(
                          fixedSize: Size.fromWidth(mq.size.width * 0.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          elevation: 8,
                        ),
                        child: const Text('Rechercher',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
