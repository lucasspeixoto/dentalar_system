import 'package:fluent_ui/fluent_ui.dart';
import 'contact.dart';

class ContactList with ChangeNotifier {
  late final List<Contact> _contacts = [];
  List<Contact> get contacts => [..._contacts];
  int get contactsCount {
    return _contacts.length;
  }

  late final List<Contact> _selectedContacts = [];
  List<Contact> get selectedContacts => [..._selectedContacts];

  int get selectedContactsCount {
    return _selectedContacts.length;
  }

  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void addSelectedContacts(Contact contact) {
    _selectedContacts.add(contact);
    notifyListeners();
  }

  void removeSelectedContact(Contact contact) {
    _selectedContacts.removeWhere((c) => c.name == contact.name);
    notifyListeners();
  }

  void makeAllContactsAsSelected() {
    if (_selectedContacts.length < _contacts.length) {
      for (var index = 0; index < _contacts.length; index++) {
        if (_contacts[index].isSelected == false) {
          _contacts[index].isSelected = true;
          addSelectedContacts(
            Contact(
              _contacts[index].name,
              _contacts[index].phoneNumber,
              true,
            ),
          );
        }
      }
      notifyListeners();
    }
  }

  void makeAllContactsAsUnselected() {
    if (_selectedContacts.isNotEmpty) {
      for (var index = 0; index < _contacts.length; index++) {
        if (_contacts[index].isSelected == true) {
          _contacts[index].isSelected = false;
          removeSelectedContact(
            Contact(
              _contacts[index].name,
              _contacts[index].phoneNumber,
              false,
            ),
          );
        }
      }
      notifyListeners();
    }
  }

  void changeSelectItemStatus(int index) {
    bool tappedContactStatus = _contacts[index].isSelected;
    _contacts[index].isSelected = !tappedContactStatus;
    if (!tappedContactStatus) {
      addSelectedContacts(
        Contact(
          _contacts[index].name,
          _contacts[index].phoneNumber,
          true,
        ),
      );
    } else {
      removeSelectedContact(
        Contact(
          _contacts[index].name,
          _contacts[index].phoneNumber,
          false,
        ),
      );
    }
    notifyListeners();
  }
}
