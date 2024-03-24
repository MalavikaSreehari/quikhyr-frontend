import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr/common/constants/app_asset_links.dart';
import 'package:quikhyr/common/constants/app_colors.dart';
import 'package:quikhyr/common/constants/app_sizing.dart';
import 'package:quikhyr/common/widgets/clickable_svg_icon.dart';
import 'package:quikhyr/common/widgets/gradient_separator.dart';
import 'package:quikhyr/common/widgets/quik_search_bar.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: AppBar(
            titleSpacing: 24,
            automaticallyImplyLeading: false, // Remove back button
            backgroundColor: Colors.transparent,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Q',
                        style: TextStyle(
                            fontFamily: 'Moonhouse', fontSize: 32),
                      ),
                      TextSpan(
                        text: 'uik',
                        style: TextStyle(
                            fontFamily: 'Moonhouse', fontSize: 24),
                      ),
                      TextSpan(
                        text: 'Settings',
                        style: TextStyle(
                            fontFamily: 'Trap',
                            fontSize: 24,
                            letterSpacing: -1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              ClickableSvgIcon(
                  svgAsset: AppAssetLinks.bellNotificationActiveSvg,
                  onTap: () {
                    //HANDLE GO TO NOTIFICATIONS
                  }),
              AppSizing.hS10(),
              ClickableSvgIcon(
                  svgAsset: AppAssetLinks.logoutSvg,
                  onTap: () {
                    // context.read<SignInBloc>().add(const SignOutRequired());
                  }),
              AppSizing.hS24(),
            ],
          ),
    
        ),
      ),
      body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ QuikSearchBar(onChanged: (String onChanged) {}, hintText: 'Search for services..', onMicPressed: (){}, onSearch: (String value){}, controller: TextEditingController()),
            const SizedBox(height: 24,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('PROFILE',style: Theme.of(context).textTheme.titleMedium,)),
              const SizedBox(height: 24,),
               Row(
                
                children: [
                  const CircleAvatar(radius: 32,
                  backgroundImage: AssetImage(AppAssetLinks.placeholderImage),
                  ),
                  const SizedBox(width: 16,),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Noah Johny',style: TextStyle(
  color: Color(0xFFFAFFFF), 
  fontFamily: 'Trap', 
  fontSize: 20, 
  fontStyle: FontStyle.normal, 
  fontWeight: FontWeight.w700, 
  height: 1.0, 
),),
SizedBox(height: 12,),
                      Text('MEMBER',
                      style: TextStyle(
  color: Color(0xFF3399CC), 
  fontFamily: 'Trap', 
  fontSize: 14, 
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500, 
  height: 1.0, 
),),],),
const SizedBox(width: 12,),
OutlinedButton.icon(onPressed: (){}, icon: const Icon(Icons.edit,color: secondary,), label: const Text('Edit',style: TextStyle(color: secondary,),), style: OutlinedButton.styleFrom(side: const BorderSide(color: secondary)),)
                ],
              ),
              const SizedBox(height: 24,),

              const GradientSeparator(),
              const SizedBox(height: 24,),
              Text('SETTINGS',style: Theme.of(context).textTheme.titleMedium,),
              const SizedBox(height: 24,),
              ListView(
                shrinkWrap: true,
                
                children: [
                  ListTile(
                    leading: const Icon(Icons.person, color: labelColor,),
                    title: Text('Manage Account',style: Theme.of(context).textTheme.bodyMedium,),
                  ),
                  ListTile(
                    leading: const Icon(Icons.mark_unread_chat_alt, color: labelColor,),
                    title: Text('Manage Notifications',style: Theme.of(context).textTheme.bodyMedium,),
                  ),
                  ListTile(
                    leading: const Icon(Icons.block_rounded, color: labelColor,),
                    title: Text('Block/Unblock Workers',style: Theme.of(context).textTheme.bodyMedium,),
                  ),
                  
                ],
              ),
              Text('SUPPORT',style: Theme.of(context).textTheme.titleMedium,),
              const SizedBox(height: 24,),
              ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    leading: const Icon(Icons.help, color: labelColor,),
                    title: Text('Explore FAQs',style: Theme.of(context).textTheme.bodyMedium,),
                  ),
                  ListTile(
                    leading: const Icon(Icons.bug_report_rounded, color: labelColor,),
                    title: Text('Report Bugs',style: Theme.of(context).textTheme.bodyMedium,),
                  ),
                  
                ],
              ),
               Text('ABOUT',style: Theme.of(context).textTheme.titleMedium,),
               
              const SizedBox(height: 24,),
              ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    leading: const Icon(Icons.help, color: labelColor,),
                    title: Text('Terms and Conditions',style: Theme.of(context).textTheme.bodyMedium,),
                  ),
                  ListTile(
                    leading: const Icon(Icons.star, color: labelColor,),
                    title: Text('Report Bugs',style: Theme.of(context).textTheme.bodyMedium,),
                  ),
                  
                ],
              )
              
            ],
          ),
        ),
      ),
    );
  }
}
