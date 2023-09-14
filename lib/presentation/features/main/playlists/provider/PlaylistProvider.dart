import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menuboss/data/models/playlist/ResponsePlaylistModel.dart';
import 'package:menuboss/domain/usecases/remote/playlist/GetPlaylistsUseCase.dart';
import 'package:menuboss/presentation/features/main/playlists/model/PlaylistModel.dart';
import 'package:menuboss/presentation/features/main/playlists/widget/PlaylistItem.dart';
import 'package:menuboss/presentation/model/UiState.dart';

final PlayListProvider = StateNotifierProvider<PlayListNotifier, UIState<List<ResponsePlaylistModel>>>(
  (ref) => PlayListNotifier(),
);

class PlayListNotifier extends StateNotifier<UIState<List<ResponsePlaylistModel>>> {
  PlayListNotifier() : super(Idle());

  final GetPlaylistsUseCase _getPlaylistsUseCase = GetIt.instance<GetPlaylistsUseCase>();


  void requestGetPlaylists() {
    state = Loading();
    _getPlaylistsUseCase.call().then((response) {
      if (response.status == 200) {
        state = Success(response.list?.toList() ?? []);
      } else {
        state = Failure(response.message);
      }
    });
  }

  void addItem(PlaylistModel item, {GlobalKey<AnimatedListState>? listKey}) {
    // listKey?.currentState?.insertItem(0, duration: const Duration(milliseconds: 300));
    // state = [item, ...state];
  }

  void removeItem(PlaylistModel item, GlobalKey<AnimatedListState>? listKey) {
    // final index = state.indexOf(item);
    // if (index != -1) {
    //   listKey?.currentState?.removeItem(index, (context, animation) {
    //     return _animatedItemBuilder(item, animation, listKey);
    //   }, duration: const Duration(milliseconds: 300));
    //   Future.delayed(const Duration(milliseconds: 300), () {
    //     state = [...state]..remove(item);
    //   });
    // }
  }

  Widget _animatedItemBuilder(
    PlaylistModel item,
    Animation<double> animation,
    GlobalKey<AnimatedListState> listKey,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-0.6, 0),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(
        opacity: animation,
        // child: PlayListItem(item: item, listKey: listKey),
      ),
    );
  }
}
