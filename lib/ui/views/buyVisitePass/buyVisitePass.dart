
import 'package:flutter/material.dart';
import 'package:mobile/models/abonnement.dart';
import 'package:mobile/models/abonnementType.dart';
import 'package:mobile/ui/views/buyVisitePass/buyVisitePassViewModel.dart';
import 'package:stacked/stacked.dart';

class BuyVisitePass extends StatefulWidget {

  final bool isVisite;

  BuyVisitePass({super.key, required this.isVisite});

  @override
  State<BuyVisitePass> createState() => _BuyVisitePassState();
}

class _BuyVisitePassState extends State<BuyVisitePass> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mq =MediaQuery.of(context);
    return ViewModelBuilder<BuyVisitePassViewModel>.reactive(
      viewModelBuilder: () => BuyVisitePassViewModel(isVisite: widget.isVisite),
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            centerTitle: true,
            title: const Text('Pass',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.3,
                  color: Colors.white
              ),
            ),
            elevation: 5,
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Scrollbar(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Nos pass expire après une semaine! pensez avous réabonnez',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.1
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: model.passes.map(
                            (e) => Card(
                            elevation: 8,
                            color: Theme.of(context).colorScheme.primary,
                            child: InkWell(
                              onTap: () => model.navigateToBuyView(e),
                              child: Container(
                                height: mq.size.height/4,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [Color(0xFF5cdee5), Color(0xFF0451b0)])
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text('${e.price} FCFA',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2
                                      ),
                                    ),
                                    Text('${e.name}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 36,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2
                                      ),
                                    ),
                                    Text('Pass ${e.isVisite? 'Visite' : 'TV'}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                    ).toList(),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
