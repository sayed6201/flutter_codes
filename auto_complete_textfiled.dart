TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                            controller: this._typeAheadController,
                            decoration: InputDecoration(
                                labelText: 'City'
                            )
                        ),
                        suggestionsCallback: (pattern) {
                          return [
                            'london',
                            'usa',
                            'chna'
                          ];
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        transitionBuilder: (context, suggestionsBox, controller) {
                          return suggestionsBox;
                        },
                        onSuggestionSelected: (suggestion) {
                          this._typeAheadController.text = suggestion;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please select a city';
                          }else return null;
                        },
                        onSaved: (value) => this._selectedCity = value,
                      ),