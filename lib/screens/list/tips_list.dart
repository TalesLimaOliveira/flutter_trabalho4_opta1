import 'package:flutter_trabalho4_opta1/commons.dart';

class TipsList extends StatefulWidget {
  const TipsList({super.key});

  @override
  State<TipsList> createState() => _TipsListState();
}

class _TipsListState extends State<TipsList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TipsDao>(context, listen: false).loadTipss(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppLabels.appBarList),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),

//SCREEN STYLE
      body: Consumer<TipsDao>(
        builder: (context, controller, child) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: AppColors.containerBG,
              borderRadius: BorderRadius.circular(16),
            ),

//LIST BUILDER INDEX
            child: ListView.builder(
              itemCount: controller.tipsList.length,
              itemBuilder: (context, index) {
                final tipsList = controller.tipsList[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  color: AppColors.cardBG,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                
                //TIP: TITLE - SUBTITLE
                        ListTile(
                          title: Text(tipsList.toTitle()),
                          subtitle: Text(tipsList.toSubtitle()),
                
                //ICONS: EDIT - DELETE
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TipsForm(existingTips: tipsList),
                                    ),
                                  );
                                },
                              ),
                
                              IconButton(
                                icon: const Icon(Icons.delete),
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  controller.deleteTips(context, tipsList.id);
                                },
                              ),
                            ],
                          ),
                        ),
                
                //DESCRIPTION 
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              tipsList.toDescription(),
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),

//ADD BUTTON    
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TipsForm(),
            ),
          );
        },
      ),
    );
  }
}
