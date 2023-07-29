import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pp/models/search_model.dart';
import 'package:shop_pp/modules/search/cubit/states.dart';
import 'package:shop_pp/shared/components/constants.dart';
import 'package:shop_pp/shared/network/endpoints.dart';
import 'package:shop_pp/shared/network/remote/dio_helper.dart';


class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;


  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value?.data);

      if (model?.data?.data?.isEmpty ?? true) { // Check if the list of data items is empty or if model is null
        emit(SearchEmptyState()); // Emit the SearchEmptyState when no results found
      } else {
        emit(SearchSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }

}