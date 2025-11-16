import 'package:bus_rullette/models/bus_route.dart';
import 'package:flutter/material.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final BusRoute route = args['route'];
    final DateTime departureDate = args['departureDate'];

    return Scaffold(
      appBar: AppBar(title: Text('Search Results')),

      body: ListView(
        children: [
          Text(
            'Showing results for ${route.cityFrom} to ${route.cityTo} on $departureDate',
          ),
        ],
      ),
    );
  }
}
