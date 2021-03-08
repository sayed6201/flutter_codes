-------------------------------------------------------------------------
						MaskedTextField
-------------------------------------------------------------------------
https://pub.dev/packages/masked_text#-readme-tab-

new MaskedTextField
(
    maskedTextFieldController: _textCPFController,
    mask: "xxx.xxx.xxx-xx",
    maxLength: 14,
    keyboardType: TextInputType.number,
    inputDecoration: new InputDecoration(
    hintText: "Write you Document here", labelText: "CPF"),
);