// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:providerlearn/app/dependacyinjection.dart';
import 'package:providerlearn/domaine/models/Models.dart';
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
    return Scaffold(
      body: StreamBuilder<FlowState>(
          stream: _viewmodel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(
                    context: context,
                    contentScreenWidget: _getContentWidget(),
                    retryActionFunction: () {
                      _viewmodel.start();
                    }) ??
                Container();
          }),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<StoreDetails>(
        stream: _viewmodel.outputStoreDetails,
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child:_getItems(snapshot.data), 
           );
        }
    );
  }

  _getItems(data){
    return Column(
      children: [
        Text(data.name),
        Text(data.address),
        Text(data.phone),
        Text(data.email),
        Text(data.website),
        Text(data.description),
        Text(data.openingHours),
        Text(data.closingHours),
        Text(data.latitude),
        Text(data.longitude),
        Text(data.image),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _viewmodel.dispose();
  }
}
