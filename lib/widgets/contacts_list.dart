import 'package:fluent_ui/fluent_ui.dart';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dentalar/widgets/contact_item.dart';
import 'package:dentalar/widgets/erro_content_dialog.dart';
import 'package:dentalar/models/contact.dart';
import 'package:dentalar/models/contact_list.dart';
import 'package:dentalar/utils/messages.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late ContactList contactsProvider = Provider.of(context);

    late List<Contact> contacts = contactsProvider.contacts;
    int? totalContacts = contactsProvider.contactsCount;

    late List<Contact> selectedContacts = contactsProvider.selectedContacts;

    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        top: 10,
        bottom: 30,
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            'Lista de Contatos - ($totalContacts)',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 8,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Button(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result == null) {
                    return;
                  }

                  PlatformFile file = result.files.first;

                  var bytes = File('${file.path}').readAsBytesSync();
                  var excel = Excel.decodeBytes(bytes);

                  final Iterable<String> keys = excel.tables.keys;
                  final totalColumns = excel.tables[keys.first]!.maxCols;

                  if (totalColumns != 2) {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return const ErrorContentDialog(
                          Messages.excelLoadingTitle,
                          Messages.excelLoadingContent,
                          Messages.excelLoadingButtonText,
                        );
                      },
                    );
                  } else {
                    for (var table in keys) {
                      totalContacts = excel.tables[table]!.maxRows - 1;
                      for (var row in excel.tables[table]!.rows) {
                        final Data? nameRow = row[0];
                        final Data? numberRow = row[1];
                        if (nameRow!.cellIndex.rowIndex == 0) {
                          continue;
                        }
                        contactsProvider.addContact(
                          Contact(
                            row[0]?.value,
                            (numberRow?.value).toString(),
                            false,
                          ),
                        );
                      }
                    }
                  }
                },
                child: const Text(
                  'Selecionar Contatos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              totalContacts! > 0
                  ? Button(
                      onPressed: () {
                        if (selectedContacts.length < contacts.length) {
                          for (var index = 0;
                              index < contacts.length;
                              index++) {
                            if (contacts[index].isSelected == false) {
                              contactsProvider.addSelectedContacts(
                                Contact(
                                  contacts[index].name,
                                  contacts[index].phoneNumber,
                                  true,
                                ),
                              );
                              contacts[index].isSelected = true;
                            }
                          }
                        }
                      },
                      child: const Text(
                        'Selecionar Todos',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : Container(),
              const Spacer(),
              totalContacts! > 0
                  ? Button(
                      onPressed: () {
                        if (selectedContacts.isNotEmpty) {
                          for (var index = 0;
                              index < contacts.length;
                              index++) {
                            contactsProvider.removeSelectedContact(
                              Contact(
                                contacts[index].name,
                                contacts[index].phoneNumber,
                                false,
                              ),
                            );
                            contacts[index].isSelected = false;
                          }
                        }
                      },
                      child: const Text(
                        'Remover Todos',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  : Container(),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    ContactItem(context, index: index),
                    const Divider()
                  ],
                );
              },
            ),
          ),
          selectedContacts.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Button(
                      onPressed: () {
                        for (var index = 0;
                            index < selectedContacts.length;
                            index++) {
                          debugPrint('Nome: ${selectedContacts[index].name}');
                        }
                      },
                      child: Text(
                        'Enviar (${selectedContacts.length})',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
