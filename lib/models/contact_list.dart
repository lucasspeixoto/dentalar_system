import 'package:fluent_ui/fluent_ui.dart';

import 'contact.dart';

class ContactList with ChangeNotifier {
  late final List<Contact> _contacts = [];

  List<Contact> get contacts => [..._contacts];

  int get contactsCount {
    return _contacts.length;
  }

  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void updateIsSelectedItem(Contact contact) {
    int index = _contacts.indexWhere((c) => c.name == contact.name);
    if (index >= 0) {
      _contacts[index] = contact;
      notifyListeners();
    }
  }
}
