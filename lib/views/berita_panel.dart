import 'package:flutter/material.dart';
import 'package:nako2/providers/berita_panel_provider.dart';
import 'package:provider/provider.dart';

class BeritaPanel extends StatelessWidget {
  const BeritaPanel({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BeritaPanelProvider>().muatdata();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Berita Terkini'),
        elevation: 0,
      ),
      // body: Text('Berita'),
      body: Consumer<BeritaPanelProvider>(
        builder: (context, prov, w) {
          return ListView(
            children: [
              for(final data in prov.data)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${data['title']}'),
                    Image.network(
                      data['image'] ?? '',
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/logo.png');
                      }
                    ),
                    Text('${data['description']}')
                  ],
                )
            ],
          );
        }
      ),
    );
  }
}
