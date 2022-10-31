// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:providerlearn/app/dependacyinjection.dart';
import 'package:providerlearn/presentation/StoreDetails/StoreDetails_ViewModel.dart';
import 'package:providerlearn/presentation/common/state_renderer/state_renderer_impl.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({super.key});

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _viewmodel = instance<StoreDetailsViewModel>();

  _bind() {
    _viewmodel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
        stream: _viewmodel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                  context: context,
                  contentScreenWidget: _getContentWidget(),
                  retryActionFunction: () {
                    _viewmodel.start();
                  }) ??
              _getContentWidget();
        });
  }

  Widget _getContentWidget() {
    return Scaffold(
      
    );
  }

  @override
  void dispose() {
    super.dispose();
    _viewmodel.dispose();
  }
}
