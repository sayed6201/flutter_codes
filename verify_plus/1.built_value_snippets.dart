-------------------------------------------------------------
Updating Object
-------------------------------------------------------------
widget.staffInfo?.rebuild((staffInfo) => staffInfo
                    ..surName = _surNameController.text
                    ..firstName = _firstNameController.text
                    ..phoneNumber = _phoneNumberController.text
                    ..emailAddress = _emailController.text == ''
                        ? null
                        : _emailController.text
                    ..password = _passwordController.text == ''
                        ? null
                        : _passwordController.text);


-------------------------------------------------------------
Creating object
-------------------------------------------------------------
StaffInfo((staffInfo) => staffInfo
                    ..surName = _surNameController.text
                    ..firstName = _firstNameController.text
                    ..phoneNumber = _phoneNumberController.text
                    ..emailAddress = _emailController.text == ''
                        ? null
                        : _emailController.text
                    ..password = _passwordController.text == ''
                        ? null
                        : _passwordController.text)