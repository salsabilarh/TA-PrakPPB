import 'dart:async'; //menggunakan fitur-fitur yang berkaitan dengan asynchronous programming seperti Future, Stream, dll.

import 'package:dio/dio.dart'; // merupakan HTTP client untuk melakukan permintaan jaringan (HTTP requests).
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart'; //untuk mempermudah pembandingan objek.
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; //untuk manajemen state
import 'package:quranpulse/models/chapter/chapter.dart';

part 'data_provider.dart';
part 'repository.dart';
part 'state.dart';

class ChapterCubit extends Cubit<ChapterState> {
  static ChapterCubit cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<ChapterCubit>(context, listen: listen);

  ChapterCubit() : super(ChapterDefault());

  final repo = ChapterRepository();

  Future<void> fetch({bool? api = false}) async {
    emit(const ChapterFetchLoading());
    try {
      List<Chapter?>? cached;

      if (api!) {
        cached = await repo.chapterApi();
      } else {
        cached = await repo.chapterHive();
      }

      if (cached == null) {
        List<Chapter?>? data = await repo.chapterApi();
        emit(ChapterFetchSuccess(data: data));
      } else {
        emit(ChapterFetchSuccess(data: cached));
      }
    } catch (e) {
      emit(ChapterFetchFailed(message: e.toString()));
    }
  }
}
