import 'package:mobile/app/app.locator.dart';
import 'package:mobile/app/app.router.dart';
import 'package:mobile/services/auth_service.dart';
import 'package:mobile/services/transaction_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CompteViewModel extends BaseViewModel{

  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  AuthService authService = locator<AuthService>();
  TransactionService transactionService = locator<TransactionService>();


  CompteViewModel();

  void navigateToProfile() async{
    await _navigationService.navigateTo(Routes.acceuil);
  }
  void retrait() async{
    await _navigationService.navigateToRetrait();
  }
  void depot() async{
    await _navigationService.navigateToDepot();
  }
  void renewAbonnement() async{
    await _navigationService.navigateToBuyAbonnementEbank();
  }
  void epargner() async{
    await _navigationService.navigateToVersement();
  }

  createEpargne() {}


}