import 'package:lostfoundapp/mics/packages.dart';

final TextEditingController usernamecon = TextEditingController();
final TextEditingController schoolIDcon = TextEditingController();
final TextEditingController userAddcon = TextEditingController();
final TextEditingController useremailcon = TextEditingController();
final TextEditingController userpasscon = TextEditingController();
final TextEditingController confirmpasscon = TextEditingController();

bool _textobscure = true;

final fname = TextFormField(
  controller: usernamecon,
  textCapitalization: TextCapitalization.values.first,
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    prefixIcon: const Icon(Icons.person),
    labelText: 'Full name',
    labelStyle: GoogleFonts.montserrat(fontSize: 14, color: colorgrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
);

//userschoolID
final schlID = TextFormField(
  controller: schoolIDcon,
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    prefixIcon: const Icon(Icons.description),
    labelText: 'School ID',
    labelStyle: GoogleFonts.montserrat(fontSize: 14, color: colorgrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
);
//user Address
final usradd = TextFormField(
  controller: userAddcon,
  textCapitalization: TextCapitalization.values.first,
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    prefixIcon: const Icon(Icons.location_on),
    labelText: 'Complete address',
    labelStyle: GoogleFonts.montserrat(fontSize: 14, color: colorgrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
);

//useremail
final usremail = TextFormField(
  controller: useremailcon,
  keyboardType: TextInputType.emailAddress,
  textInputAction: TextInputAction.next,
  decoration: InputDecoration(
    prefixIcon: const Icon(Icons.email),
    labelText: 'Email',
    labelStyle: GoogleFonts.montserrat(fontSize: 14, color: colorgrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
);
//userpassword
final usrpsswrd = TextFormField(
  controller: userpasscon,
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  obscureText: _textobscure,
  decoration: InputDecoration(
    prefixIcon: const Icon(Icons.key),
    labelText: 'password',
    labelStyle: GoogleFonts.montserrat(fontSize: 14, color: colorgrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
);
//userpassword
final cnfpsswrd = TextFormField(
  controller: confirmpasscon,
  keyboardType: TextInputType.name,
  textInputAction: TextInputAction.next,
  obscureText: _textobscure,
  decoration: InputDecoration(
    prefixIcon: const Icon(Icons.key),
    labelText: 'confirm',
    labelStyle: GoogleFonts.montserrat(fontSize: 14, color: colorgrey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
  ),
);
