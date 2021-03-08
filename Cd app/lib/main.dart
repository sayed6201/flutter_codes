//import 'package:crowdv/api_url.dart';
import 'package:crowdv/screens/about_us.dart';
import 'package:crowdv/screens/auth_screens/password_recovery_screen.dart';
import 'package:crowdv/screens/certificate_screen.dart';
import 'package:crowdv/screens/chat_screen.dart';
import 'package:crowdv/screens/faq_screen.dart';
import 'package:crowdv/screens/home/home_history_page.dart';
import 'package:crowdv/screens/home/home_profile_screen.dart';
import 'package:crowdv/screens/opportunity_list.dart';
import 'package:crowdv/screens/picture_upload.dart';
import 'package:crowdv/screens/privacy_policy.dart';
import 'package:crowdv/screens/quiz_option_screen.dart';
import 'package:crowdv/screens/quiz_screen.dart';
import 'package:crowdv/screens/recruiter_approval_list.dart';
import 'package:crowdv/screens/recruiter_opportunity_pending_list.dart';
import 'package:crowdv/screens/reruiter_profile_view.dart';
import 'package:crowdv/screens/review_screen.dart';
import 'package:crowdv/screens/recruiter_view_opportunity.dart';
import 'package:crowdv/screens/tutorial_screen.dart';
import 'package:crowdv/screens/verify_email.dart';
import 'package:crowdv/screens/vol_profile_setup.dart';
import 'package:crowdv/screens/vol_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:crowdv/provider/auth_provider.dart';
import 'package:crowdv/provider/guest_provider.dart';
import 'package:crowdv/screens/auth_screens/login_screen.dart';
import 'package:crowdv/screens/auth_screens/sign_up.dart';
import 'package:crowdv/screens/auth_screens/user_choosing_screen.dart';
import 'package:crowdv/screens/booking_screen.dart';
import 'package:crowdv/screens/catagory_screen.dart';
import 'package:crowdv/screens/vol_list_screen.dart';
import 'package:crowdv/screens/expert_medicine_post.dart';
import 'package:crowdv/screens/recruiter_profile_setup.dart';
import 'package:crowdv/screens/expert_suggestion_screen.dart';
import 'package:crowdv/screens/home/home_notification.dart';
import 'package:crowdv/screens/home/home_screen.dart';
import 'package:crowdv/screens/medicine_screen.dart';
import 'package:crowdv/screens/notification_view.dart';
import 'package:crowdv/screens/payment_screen.dart';
import 'package:crowdv/screens/profile_setup.dart';
import 'package:crowdv/screens/recruiter_create_opportunity.dart';
import 'package:crowdv/screens/splash_screen.dart';
import 'package:crowdv/screens/suggestion_view_screen.dart';
import 'package:provider/provider.dart';
import 'color_file.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    LoginScreen.tag: (context) => LoginScreen(),
    SignUpScreen.tag: (context) => SignUpScreen(),
    HomeScreen.tag: (context) => HomeScreen(),
    CatagoryScreen.tag: (context) => CatagoryScreen(),
    VolListScreen.tag : (context) => VolListScreen(),
    VolProfileSetup.tag : (context) => VolProfileSetup(),
    UserChooseScreen.tag : (context) => UserChooseScreen(),
    ProfileSetup.tag : (context) => ProfileSetup(),
    SuggestionViewScreen.tag : (context) => SuggestionViewScreen(),
    MedicineViewScreen.tag : (context) => MedicineViewScreen(),
    BookingScreen.tag : (context) => BookingScreen(),
    ExpertSuggestionPostScreen.tag : (context) => ExpertSuggestionPostScreen(),
    ExpertMedicinePostScreen.tag : (context) => ExpertMedicinePostScreen(),
    RecruiterProfileSetup.tag : (context) => RecruiterProfileSetup(),
    ReqruiterOpprtunityCreate.tag : (context) => ReqruiterOpprtunityCreate(),
    PaymentScreen.tag :  (context) => PaymentScreen(),
    NotificationSceen.tag : (context) => NotificationSceen(),
    NotificationViewScreen.tag : (context) => NotificationViewScreen(),
    RecruiterProfileView.tag: (context) => RecruiterProfileView(),
    ReviewScreen.tag : (context) => ReviewScreen(),
    ViewOpprtunityByRec.tag:(context) => ViewOpprtunityByRec(),
    OpportunityListScreen.tag:(context) => OpportunityListScreen(),
    RecruiterOpportunityPendingList.tag :(context) => RecruiterOpportunityPendingList(),
    ApprovalScreen.tag : (context) => ApprovalScreen(),
    ChatScreen.tag : (context) => ChatScreen(),
    CertificatePage.tag : (context) => CertificatePage(),
    VolunteerProfileView.tag :(context) => VolunteerProfileView(),
    PictureUploadScreen.tag : (context) => PictureUploadScreen(),
    AboutUsScreen.tag : (context) => AboutUsScreen(),
    QuizOPtionScreen.tag : (context) => QuizOPtionScreen(),
    QuizScreen.tag : (context) => QuizScreen(),
    ProfileScreen.tag :  (context) => ProfileScreen(),
    TutorialScreen.tag : (context) => TutorialScreen(),
    HistoryScreen.tag : (context) => HistoryScreen(),
    PasswordRecoveryScreen.tag : (context) => PasswordRecoveryScreen(),
    PrivacyScreen.tag : (context) => PrivacyScreen(),
    FAQScreen.tag : (context) => FAQScreen(),
    VerifyEmail.tag : (context) => VerifyEmail()
  };

  @override
  Widget build(BuildContext context) {
    // change the status bar color to material color [green-400]
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProvider.value(value: GuestProvider()),
      ],
      child: MaterialApp(
        title: 'CrowdV App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: primaryColor,
          fontFamily: 'Nunito',
        ),
        home: SplashScreen(),
        routes: routes,
      ),
    );
  }
}
