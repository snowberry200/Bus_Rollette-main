import 'package:bus_rullette/bloc/search_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RowWidget extends StatefulWidget {
  const RowWidget({super.key});

  @override
  State<RowWidget> createState() => RowWidgetState();

  static Future<void> _pickDate(BuildContext context) async {
    final rowBloc = context.read<SearchBloc>();
    final currentDate = rowBloc.state.departureDate ?? DateTime.now();

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      rowBloc.add(DateChangeEvent(departureDate: selectedDate));
      if (kDebugMode) {
        debugPrint('Selected date: $selectedDate');
      }
    }
  }
}

class RowWidgetState extends State<RowWidget> {
  DateTime? departureDate;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => RowWidget._pickDate(context),
              child: const Text(
                "Select Date:",
                style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Text(
              state.departureDate != null
                  ? DateFormat('dd/MM/yyyy').format(state.departureDate!)
                  : "Please select a date",
              style: TextStyle(
                color: state.departureDate != null ? Colors.amber : Colors.grey,
                fontSize: 15,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        );
      },
    );
  }
}
