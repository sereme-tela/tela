import 'package:mobile/app/app.locator.dart';
import 'package:mobile/app/app.router.dart';
import 'package:mobile/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AcceuilViewModel extends BaseViewModel{

  NavigationService _navigationService = locator<NavigationService>();
  AuthService _authService = locator<AuthService>();
  DialogService _dialogService = locator<DialogService>();
  SnackbarService _snackbarService = locator<SnackbarService>();


  AcceuilViewModel(){
    _authService.saveCommune();
    _authService.saveAbonnementType();
    _authService.savePassType();
  }


  void navigateToEbank() async{
    await _navigationService.navigateTo(Routes.bank);
  }
  void navigateToProfile() async{
    await _navigationService.navigateTo(Routes.profile);
  }
  void navigateToTV() async{
    await _navigationService.navigateTo(Routes.chanelTv);
  }
  void navigateToprogTV() async{
    await _navigationService.navigateTo(Routes.programmeTv);
  }
  void navigateToRechercheBureau() async{
    await _navigationService.navigateToRecherche(isBureau: true);
  }
  void navigateToRechercheLogement() async{
    await _navigationService.navigateToRecherche(isBureau: false);
  }
  void navigateToGalery() async{
    await _navigationService.navigateTo(Routes.catalogue);
  }
  void navigateToAcceuil() async{
    await _navigationService.navigateTo(Routes.acceuil);
  }


}