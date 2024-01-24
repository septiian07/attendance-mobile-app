import 'package:resident_app/src/app/app.locator.dart';
import 'package:resident_app/src/enum/dialog_type.dart';
import 'package:resident_app/src/ui/widgets/confirmation_dialog.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialog() {
  var dialogService = locator<DialogService>();

  final builders = {
    DialogType.confirmation: (context, sheetRequest, completer) =>
        ConfirmationDialog(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
