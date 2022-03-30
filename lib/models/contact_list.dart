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

  late List<Contact> _selectedContacts = [];
  List<Contact> get selectedContacts => [..._selectedContacts];
  int get selectedContactsCount {
    return _contacts.length;
  }

  void addSelectedContacts(Contact contact) {
    _selectedContacts.add(contact);
    notifyListeners();
  }

  void removeSelectedContact(Contact contact) {
    int index = _selectedContacts.indexWhere((c) => c.name == contact.name);
    if (index >= 0) {
      _selectedContacts.removeWhere((c) => c.name == contact.name);
      notifyListeners();
    }
  }

  void clearSelectedContact() {
    _selectedContacts = [];
    notifyListeners();
  }

  void addAllContactsToSelectedList() {
    _selectedContacts = _contacts;
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
