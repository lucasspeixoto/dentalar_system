import 'package:dentalar/models/contact.dart';
import 'package:dentalar/models/contact_list.dart';
import 'package:dentalar/utils/colors_palette.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class ContactItem extends StatelessWidget {
  final int index;
  const ContactItem(
    BuildContext context, {
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late ContactList contactsProvider = Provider.of(context);
    late List<Contact> contacts = contactsProvider.contacts;

    return TappableListTile(
      leading: const CircleAvatar(
        backgroundColor: Palette.secondaryColor,
        child: Icon(FluentIcons.reminder_person, color: Colors.white),
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
        contacts[index].isSelected = !contacts[index].isSelected;
        if (contacts[index].isSelected == true) {
          contactsProvider.addSelectedContacts(
            Contact(
              contacts[index].name,
              contacts[index].phoneNumber,
              true,
            ),
          );
        } else if (contacts[index].isSelected == false) {
          contactsProvider.removeSelectedContact(
            Contact(
              contacts[index].name,
              contacts[index].phoneNumber,
              false,
            ),
          );
        }
      },
    );
  }
}
