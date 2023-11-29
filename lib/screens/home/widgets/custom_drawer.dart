part of '../home_screen.dart';

class _CustomDrawer extends StatelessWidget {
  const _CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width * 0.835,
      height: height,
      child: Material(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Space.y1!,
                const DrawerAppName(),
                Space.y1!,
                ...DrawerUtils.items.map(
                  (e) => Card(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(e['title']),
                      leading: Icon(e['icon']),
                      onTap: () => Navigator.pushNamed(
                        context,
                        '${e['route']}',
                        arguments: {
                          'route': 'drawer',
                        },
                      ),
                    ),
                  ),
                ),
                Space.ym!,
                const AppVersion(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
