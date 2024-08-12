// ! It's a bad way to implement the SNACKBAR..
// ! Not recommend use 'BuildContext's across async gaps..
// ! But will work for now.. 
// ignore_for_file: use_build_context_synchronously

import 'package:flutter_trabalho4_opta1/commons.dart';

class TipsDao extends ChangeNotifier {
  static const String jsonKeyPreference = 'EXPENSE_LIST';
  List<TipsModel> _tipsList = [];
  List<TipsModel> get tipsList => _tipsList;
  int _idCounter = 0;

  TipsDao() {
    // Initialize empty list, the loading will be done by the context (SCREEN/WIDGET).
  }

  // PERSISTENCE
  Future<void> loadTipss(BuildContext context) async {
    try {
      final preference = await SharedPreferences.getInstance();
      final String? jsonString = preference.getString(jsonKeyPreference);

      if (jsonString != null && jsonString.isNotEmpty) {
        final List<dynamic> jsonList = json.decode(jsonString);
        _tipsList = jsonList.map((jsonItem) => TipsModel.fromJson(jsonItem)).toList();
        _idCounter = _tipsList.length;
        notifyListeners();
      }
    } catch (e) {
      showSnackbar(context: context, label: AppLabels.errorLoading);
    }
  }

  Future<void> saveTipss(BuildContext context) async {
    try {
      final preference = await SharedPreferences.getInstance();
      final String jsonString = jsonEncode(_tipsList.map((e) => e.toJson()).toList());
      await preference.setString(jsonKeyPreference, jsonString);
    } catch (e) {
      showSnackbar(context: context, label: AppLabels.errorSaving);
    }
  }

  // METHODS
  void addTips(BuildContext context, TipsModel tips) {
    tips.id = _idCounter;
    _tipsList.add(tips);
    _idCounter++;
    saveTipss(context);
    notifyListeners();
    showSnackbar(context: context, label: AppLabels.successAdding, isError: false);
  }

  void updateTips(BuildContext context, int id, TipsModel newTips) async {
    try {
      final index = _tipsList.indexWhere((tips) => tips.id == id);
      if (index != -1) {
        newTips.id = id;
        _tipsList[index] = newTips;
        await saveTipss(context);
        notifyListeners();
        showSnackbar(context: context, label: AppLabels.successUpdating, isError: false);
      } else {
        showSnackbar(context: context, label: AppLabels.errorUpdating);
      }
    } catch (e) {
      showSnackbar(context: context, label: AppLabels.errorSaving);
    }
  }

  void deleteTips(BuildContext context, int id) {
    _tipsList.removeWhere((tips) => tips.id == id);
    saveTipss(context);
    notifyListeners();
    showSnackbar(context: context, label: AppLabels.successDeleting, isError: false);
  }

  static void addTipsStatic(BuildContext context, TipsModel tips) {
    final tipsDao = Provider.of<TipsDao>(context, listen: false);
    tipsDao.addTips(context, tips);
  }

  static void updateTipsStatic(BuildContext context, int id, TipsModel newTips) {
    final tipsDao = Provider.of<TipsDao>(context, listen: false);
    tipsDao.updateTips(context, id, newTips);
  }

  static void deleteTipsStatic(BuildContext context, int id) {
    final tipsDao = Provider.of<TipsDao>(context, listen: false);
    tipsDao.deleteTips(context, id);
  }
}
