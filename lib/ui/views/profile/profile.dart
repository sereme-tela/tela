import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/ui/views/profile/profileViewModel.dart';
import 'package:mobile/ui/widget/profilCliper.dart';
import 'package:stacked/stacked.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String code = '';

  @override
  Widget build(BuildContext context) {
    // MediaQueryData mq =MediaQuery.of(context);
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            centerTitle: true,
            title: const Text('Tela',
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
                        child: const Text('Acceuil')
                    ),
                    TextButton(
                        onPressed: (){
                          model.navigateToProfile();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,

                        ),
                        child: const Text('profile',
                          style: TextStyle(
                              color: Colors.white
                          ),)
                    ),
                    TextButton(
                        onPressed: (){
                          model.navigateToRechercheLogement();
                        },
                        child: const Text('Trouver un logement')
                    ),
                    TextButton(
                        onPressed: (){
                          model.navigateToRechercheBureau();
                        },
                        child: const Text('Trouver un Bureau')
                    ),
                    TextButton(
                        onPressed: (){
                          model.navigateToTV();
                        },
                        child: const Text('Tela TV')
                    ),
                    TextButton(
                        onPressed: (){
                          model.navigateToEbank();
                        },
                        child: const Text('Tela Finance')
                    ),
                  ]),
            ),
          ),
          body: SingleChildScrollView(
            child: Scrollbar(
              child: StreamBuilder<bool>(
                stream: model.isAuth,
                builder: (context, snapshot) {
                  switch(snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.active:
                      return snapshot.data!?Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          /// info personnelles
                          ClipPath(
                            clipper: ProfileClipper(),
                            child: Container(
                              height: 250,
                              color: Theme.of(context).colorScheme.primary,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  /// noms + phone
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('${model.user!.nom} ${model.user!.prenom}',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(model.user!.phone,
                                          textAlign:TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: !model.user!.isValidated,
                                    /// solde
                                    replacement: const Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Text('Solde',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Text('000000000',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextButton(
                                        onPressed: () => model.navigateToIdentification(),
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(50)
                                          )
                                        ),
                                        child: const Column(
                                          children: [
                                            Icon(Icons.warning_amber, size: 32, color: Colors.deepOrange,),
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 32),
                                              child: Text('Votre profil n\'est pas complet. Cliquez ici pour le compléter',
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  color: Colors.deepOrange,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                ),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  /// Catalogue
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                                      child: TextButton(
                                          onPressed: () => model.navigateToGalery(),
                                          style: TextButton.styleFrom(
                                            alignment: Alignment.centerLeft,
                                            backgroundColor: Colors.white,
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4),
                                            child: Text('Mon Catalogue',style: TextStyle(
                                                color: Theme.of(context).colorScheme.primary,
                                                fontSize:18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 40,),
                          /// Pass visite
                          Visibility(
                            visible: model.passVisite != null,
                            replacement:Column(
                              children: [
                                const Text('Entrez le code de votre pass visite si dessous et confirmer',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.1
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    autofocus: false,
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
                                        onTap: () => model.chechPass(),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width/5,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.primary,
                                              borderRadius: BorderRadius.circular(30)
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () => model.navigateToVisitePass(),
                                    child: Card(
                                        elevation: 8,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(45)
                                        ),
                                        color: Theme.of(context).colorScheme.primary,
                                        child: const Padding(
                                          padding: EdgeInsets.all(24.0),
                                          child: Text('Achetez votre pass pour accéder aux détails de notre catalogue!',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1.2
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 1),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Pass visites',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2,
                                          color: model.passVisite != null? Colors.deepOrange : Colors.grey,
                                        ),),
                                      Text(model.passVisite != null? model.passVisite!.isExpired ? 'Expiré' : 'inactif': 'inactif',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2,
                                          color: model.passVisite != null? Colors.deepOrange : Colors.grey,
                                        ),),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black,
                                  thickness: 0.7,
                                  indent: 35,
                                  endIndent: 35,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 1),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(model.strd,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2,
                                          color: model.passVisite != null? Colors.deepOrange : Colors.grey,
                                        ),),
                                      Text(model.endd,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2,
                                          color: model.passVisite != null? Colors.deepOrange : Colors.grey,
                                        ),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20,),
                          /// abonnement
                          Column(
                            children: [
                              /// is actif?
                               Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Abonnement Démarcheur',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.2,
                                        color: model.abonnement != null? Colors.deepOrange : Colors.grey,
                                      ),
                                    ),
                                    Text(model.abonnement != null? 'Actif' : 'inactif',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.2,
                                        color: model.abonnement != null? Colors.deepOrange : Colors.grey  ,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: model.abonnement != null,
                                child: const Divider(
                                  color: Colors.black,
                                  thickness: 0.7,
                                  indent: 35,
                                  endIndent: 35,
                                ),
                              ),
                              Visibility(
                                visible: model.abonnement != null,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 1),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(model.abonnement != null? model.abonnement!.startSTR() :'Du',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2,
                                          color: model.abonnement != null? Colors.deepOrange : Colors.grey,
                                        ),),
                                      Text(model.enda,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2,
                                          color: model.abonnement != null? Colors.deepOrange : Colors.grey,
                                        ),),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: model.abonnement == null,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(45)
                                      ),
                                      color: Theme.of(context).colorScheme.primary,
                                      child: InkWell(
                                        onTap: () => model.navigateToAbonnement(),
                                        child: const Padding(
                                          padding: EdgeInsets.all(24.0),
                                          child: Text('Réactiver votre abonnement',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1.2
                                            ),
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                      :
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [

                            /// auth
                            ClipPath(
                              clipper: ProfileClipper(),
                              child: Container(
                                height: 180,
                                width: double.infinity,
                                color: Theme.of(context).colorScheme.primary,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    /// is connected
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Vous n\'êtes pas connecté!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    /// auth
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton(
                                            onPressed: () => model.navigateToSignIn(),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Theme.of(context).colorScheme.primary,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                                            ),
                                            child: const Text('Créer un profile',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),)),
                                        TextButton(
                                            onPressed: () => model.navigateToLogIn(),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Theme.of(context).colorScheme.primary,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                                            ),
                                            child: const Text('Se connecter',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),)),
                                      ],
                                    ),

                                    const SizedBox(height: 20,)
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 40,),

                            /// pass visite
                            Column(
                              children: [
                                const Text('Entrez le code de votre pass visite si dessous et confirmer',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.1
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    autofocus: false,
                                    keyboardType: const TextInputType.numberWithOptions(signed: true,),
                                    maxLength: 8,
                                    minLines: 1,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.credit_card,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                      suffix: InkWell(
                                        onTap: () => model.chechPass(),
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () => model.navigateToVisitePass(),
                                    child: Card(
                                        elevation: 8,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(45)
                                        ),
                                        color: Theme.of(context).colorScheme.primary,
                                        child: const Padding(
                                          padding: EdgeInsets.all(24.0),
                                          child: Text('Achetez votre pass pour accéder aux détails de notre catalogue!',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1.2
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),

                            /// sign in
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () => model.navigateToSignIn(),
                                child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45)
                                  ),
                                  color: Theme.of(context).colorScheme.primary,
                                    child: const Padding(
                                      padding: EdgeInsets.all(24.0),
                                      child: Text('Devenir démarcheur c\'est simple avec Tela! \n Créez votre profil',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.2
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                      );
                    case ConnectionState.done:
                      return snapshot.data!?Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipPath(
                            clipper: ProfileClipper(),
                            child: Container(
                              height: 180,
                              color: Theme.of(context).colorScheme.primary,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('${model.user!.nom} ${model.user!.prenom}',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(model.user!.phone,
                                          textAlign:TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  const Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Solde',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('000000000',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextButton(
                                          onPressed: () => model.navigateToGalery(),
                                          style: TextButton.styleFrom(
                                              alignment: Alignment.centerLeft,
                                              backgroundColor: Colors.white,
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4),
                                            child: Text('Mon Catalogue',style: TextStyle(
                                              color: Theme.of(context).colorScheme.primary,
                                              fontSize:18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            ),
                                          )
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 40,),
                          /// Pass visite
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Pass visites',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.2,
                                        color: model.passVisite != null? Colors.deepOrange : Colors.grey,
                                      ),),
                                    Text(model.passVisite != null? 'Actif' : 'inactif',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.2,
                                        color: model.passVisite != null? Colors.deepOrange : Colors.grey,
                                      ),),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.black,
                                thickness: 0.7,
                                indent: 35,
                                endIndent: 35,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(model.strd,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.2,
                                        color: model.passVisite != null? Colors.deepOrange : Colors.grey,
                                      ),),
                                    Text(model.endd,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.2,
                                        color: model.passVisite != null? Colors.deepOrange : Colors.grey,
                                      ),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40,),
                          /// abonnement
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Abonnement Démarcheur',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.2,
                                        color: model.abonnement != null? Colors.deepOrange : Colors.grey,
                                      ),
                                    ),
                                    Text(model.abonnement != null? 'Actif' : 'inactif',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.2,
                                        color: model.abonnement != null? Colors.deepOrange : Colors.grey  ,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.black,
                                thickness: 0.7,
                                indent: 35,
                                endIndent: 35,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(model.abonnement != null? model.abonnement!.startSTR() :'Du',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.2,
                                        color: model.abonnement != null? Colors.deepOrange : Colors.grey,
                                      ),),
                                    Text(model.enda,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.2,
                                        color: model.abonnement != null? Colors.deepOrange : Colors.grey,
                                      ),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    elevation: 8,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(45)
                                    ),
                                    color: Theme.of(context).colorScheme.primary,
                                    child: InkWell(
                                      onTap: () => model.navigateToVisitePass(),
                                      child: const Padding(
                                        padding: EdgeInsets.all(24.0),
                                        child: Text('Accédez a notre catalogue de bien immobilier. \n '
                                            'Pour vos besoins en logement et bureaux',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      )
                          :
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipPath(
                            clipper: ProfileClipper(),
                            child: Container(
                              height: 180,
                              width: double.infinity,
                              color: Theme.of(context).colorScheme.primary,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Vous n\'êtes pas connecté!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      TextButton(
                                          onPressed: () => model.navigateToSignIn(),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Theme.of(context).colorScheme.primary,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                                          ),
                                          child: const Text('Créer un profile',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),)),
                                      TextButton(
                                          onPressed: () => model.navigateToLogIn(),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Theme.of(context).colorScheme.primary,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                                          ),
                                          child: const Text('Se connecter',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),)),
                                    ],
                                  ),

                                  const SizedBox(height: 20,)
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 40,),
                          const Text('Entrez le code de votre pass visite si dessous et confirmer',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.1
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              autofocus: false,
                              keyboardType: const TextInputType.numberWithOptions(signed: true,),
                              maxLength: 8,
                              minLines: 1,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.credit_card,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                suffix: InkWell(
                                  onTap: () => model.chechPass(),
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
                          const SizedBox(height: 40,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () => model.navigateToVisitePass(),
                              child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(45)
                                  ),
                                  color: Theme.of(context).colorScheme.primary,
                                  child: const Padding(
                                    padding: EdgeInsets.all(24.0),
                                    child: Text('Achetez votre pass pour accéder aux détails de notre catalogue!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () => model.navigateToSignIn(),
                              child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(45)
                                  ),
                                  color: Theme.of(context).colorScheme.primary,
                                  child: const Padding(
                                    padding: EdgeInsets.all(24.0),
                                    child: Text('Devenir démarcheur c\'est simple avec Tela! \n Créez votre profil',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      );
                  }

                }
              ),
            ),
          )
      ),
    );
  }
}
