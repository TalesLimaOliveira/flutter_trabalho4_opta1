import 'package:flutter_trabalho4_opta1/commons.dart';

class TipsForm extends StatefulWidget {
  final TipsModel? existingTips;

  const TipsForm({super.key, this.existingTips});

  @override
  TipsFormState createState() => TipsFormState();
}

class TipsFormState extends State<TipsForm> {
  // Vars
  static const double _formPadding = 8.0;

  // Controllers
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _type = AppLabels.typesList[0];
  String _language = AppLabels.languagesList[0];

  @override
  void initState() {
    super.initState();
    if (widget.existingTips != null) {
      _titleController.text = widget.existingTips!.title;
      _descriptionController.text = widget.existingTips!.description;
      _type = widget.existingTips!.type;
      _language = widget.existingTips!.language;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingTips == null
            ? AppLabels.appBarAdd
            : AppLabels.appBarEdit
        ),
      ),

// SCREEN STYLE
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.containerBG,
                borderRadius: BorderRadius.circular(16),
              ),
            
            // FORMS
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
// LINE 1: Title
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: _formPadding),
                        child: createTextFormField(
                          label: AppLabels.title,
                          controller: _titleController,
                          textInputType: TextInputType.text,
                          maxLength: 40,
                          validator: validateEmpty,
                        ),
                      ),

// LINE 2: Description
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: _formPadding),
                        child: createTextFormField(
                          label: AppLabels.description,
                          controller: _descriptionController,
                          textInputType: TextInputType.text,
                          maxLength: 500,
                          maxLines: 6,
                          validator: validateEmpty,
                        ),
                      ),

// LINE 3: TYPE & LANGUAGE              
                      Row(
                        children: [

// TYPE
                          Flexible(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: _formPadding),
                              child: createDropdownButtonFormField(
                                value: _type,
                                label: AppLabels.type,
                                items: AppLabels.typesList,
                                onChanged: (value) {
                                  setState((){
                                    _type = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          
// LANGUAGE
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: _formPadding),
                              child: createDropdownButtonFormField(
                                value: _language,
                                label: AppLabels.language,
                                items: AppLabels.languagesList,
                                onChanged: (value) {
                                  setState(() {
                                    _language = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ), 


// SAVE BUTTON
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final newTips = TipsModel(
                              title: _titleController.text,
                              description: _descriptionController.text,
                              type: _type,
                              language: _language,
                            );

                            if (widget.existingTips != null) {
                              newTips.id = widget.existingTips!.id;// Preserve ID for update
                              TipsDao.updateTipsStatic(
                                context, newTips.id, newTips);
                            }
                            
                            else {
                              TipsDao.addTipsStatic(context, newTips);
                            }
                            Navigator.pop(context);
                          }
                        },

                        child: Text(
                          widget.existingTips == null
                            ? AppLabels.addTips
                            : AppLabels.updateTips
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
