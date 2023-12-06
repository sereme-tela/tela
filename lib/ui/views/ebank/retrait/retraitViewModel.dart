import 'package:mobile/app/app.locator.dart';
import 'package:mobile/app/app.router.dart';
import 'package:mobile/services/auth_service.dart';
import 'package:mobile/services/transaction_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RetraitViewModel extends BaseViewModel{

  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  AuthService authService = locator<AuthService>();
  TransactionService _transactionService = locator<TransactionService>();

  double montant = 0;
  RetraitViewModel();

  void navigateToProfile() async{
    await _navigationService.navigateTo(Routes.acceuil);
  }
  void navigateToBank() async{
    await _navigationService.navigateToBank(hasEpargne: authService.bankProfile?.hasEpargne??false);
  }
  void retrait() async{
    // await _transactionService.postRetrait(transaction: transaction);
  }


}