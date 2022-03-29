import 'package:dentalar/models/contact.dart';
import 'package:dentalar/models/contact_list.dart';
import 'package:dentalar/utils/colors_palette.dart';
import 'package:dentalar/utils/messages.dart';
import 'package:dentalar/widgets/erro_content_dialog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:provider/provider.dart';

class WhatsappScreen extends StatefulWidget {
  const WhatsappScreen({Key? key}) : super(key: key);

  @override
  State<WhatsappScreen> createState() => _WhatsappScreenState();
}

class _WhatsappScreenState extends State<WhatsappScreen> {
  //late List<Contact> contacts = [];

  //int? totalContacts = 0;

  List<Contact> selectedContacts = [];

  @override
  Widget build(BuildContext context) {
    late ContactList contactsProvider = Provider.of(context);
    late List<Contact> contacts = contactsProvider.contacts;
    int? totalContacts = contactsProvider.contactsCount;

    //late List<Contact> selectedContacts = [];

    return ScaffoldPage(
      header: const PageHeader(
        title: Text(
          'WhatsApp',
          style: TextStyle(fontSize: 32),
        ),
      ),
      content: Container(
        margin: const EdgeInsets.only(
          left: 10,
          top: 10,
          bottom: 30,
        ),
        alignment: Alignment.center,
        width: 300,
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

                    PlatformFile file = result!.files.first;

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
                      setState(() {
                        totalContacts = 0;
                        contacts = [];
                      });
                    } else {
                      for (var table in keys) {
                        setState(
                          () {
                            totalContacts = excel.tables[table]!.maxRows - 1;
                            for (var row in excel.tables[table]!.rows) {
                              final Data? nameRow = row[0];
                              final Data? numberRow = row[1];

                              if (nameRow!.cellIndex.rowIndex == 0) {
                                continue;
                              }

                              /*  contacts.add(
                                Contact(row[0]?.value, numberRow?.value, false),
                              ); */
                              contactsProvider.addContact(Contact(
                                  row[0]?.value, numberRow?.value, false));
                            }
                          },
                        );
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
                          List<Contact> selectedContactsRef = [];
                          setState(
                            () {
                              if (selectedContactsRef.length <
                                  contacts.length) {
                                for (var index = 0;
                                    index < contacts.length;
                                    index++) {
                                  contacts[index].isSelected = true;
                                  selectedContactsRef.add(
                                    Contact(
                                      contacts[index].name,
                                      contacts[index].phoneNumber,
                                      true,
                                    ),
                                  );
                                }
                              }
                              selectedContacts = selectedContactsRef;
                            },
                          );
                        },
                        child: const Text(
                          'Selecionar Todos',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )
                    : Container(),
                const Spacer(),
                totalContacts! > 0
                    ? Button(
                        onPressed: () {
                          setState(() {
                            if (selectedContacts.isNotEmpty) {
                              for (var index = 0;
                                  index < contacts.length;
                                  index++) {
                                contacts[index].isSelected = false;
                                selectedContacts.removeWhere((element) =>
                                    element.name == contacts[index].name);
                              }
                            }
                          });
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
                  return TappableListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Palette.secondaryColor,
                      child: Icon(FluentIcons.reminder_person,
                          color: Colors.white),
                    ),
                    title: Text(
                      contacts[index].name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(contacts[index].phoneNumber),
                    trailing: contacts[index].isSelected
                        ? const Icon(
                            FluentIcons.checkbox_composite_reversed,
                            color: Palette.secondaryColor,
                          )
                        : const Icon(
                            FluentIcons.checkbox_composite,
                            color: Colors.grey,
                          ),
                    onTap: () {
                      setState(
                        () {
                          contacts[index].isSelected =
                              !contacts[index].isSelected;
                          if (contacts[index].isSelected == true) {
                            selectedContacts.add(
                              Contact(
                                contacts[index].name,
                                contacts[index].phoneNumber,
                                true,
                              ),
                            );
                          } else if (contacts[index].isSelected == false) {
                            selectedContacts.removeWhere(
                              (element) => element.name == contacts[index].name,
                            );
                          }
                        },
                      );
                    },
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
                          for (var start = 0;
                              start < selectedContacts.length;
                              start++) {
                            debugPrint('Nome: ${selectedContacts[start].name}');
                          }
                        },
                        child: Text(
                          'Enviar (${selectedContacts.length})',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ContactItem(
      String name, String phoneNumber, bool isSelected, int index) {
    return TappableListTile(
      leading: const CircleAvatar(
        backgroundColor: Palette.secondaryColor,
        child: Icon(FluentIcons.reminder_person, color: Colors.white),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(phoneNumber),
      trailing: isSelected
          ? const Icon(
              FluentIcons.checkbox_composite_reversed,
              color: Palette.secondaryColor,
            )
          : const Icon(
              FluentIcons.checkbox_composite,
              color: Colors.grey,
            ),
      onTap: () {
        /* setState(
          () {
            contacts[index].isSelected = !contacts[index].isSelected;
            if (contacts[index].isSelected == true) {
              selectedContacts.add(
                Contact(
                  name,
                  phoneNumber,
                  true,
                ),
              );
            } else if (contacts[index].isSelected == false) {
              selectedContacts.removeWhere(
                (element) => element.name == contacts[index].name,
              );
            }
          },
        ); */
      },
    );
  }
}
