import 'package:tela/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tela/services/tv_service.dart';

class TvSportViewModel extends BaseViewModel{

  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final TVService tvService = locator<TVService>();


  TvSportViewModel(){
    tvService.pausePub();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tvService.playPub();

  }


}