class Constants {
  static String baseurl = 'https://oyee.spikepointinfotech.com/api/';
  static String loginurl = baseurl + 'login.php';
  static String imageurl =
      'https://oyee.spikepointinfotech.com/api/verify_user/';
  static String images = 'http://oyee.spikepointinfotech.com/team_img/';
  static String sliderImages =
      'http://oyee.spikepointinfotech.com/home_slider/';
  static String contestlist =
      baseurl + 'contestList.php?userId=$user_id&userToken=$token&matchid=';
  static String kycurl = 'add_verify.php?userId=$user_id&userToken=$token';
  static String addpayment =
      baseurl + 'add_payment.php?userId=$user_id&userToken=$token';
  static String walleturl =
      baseurl + 'wallet.php?userId=$user_id&userToken=$token';
  static String leaderboardapi =
      baseurl + 'leaderboard.php?userId=$user_id&userToken=$token&contestId=';
  static String finalleaderboardapi = baseurl +
      'finalLeaderboard.php?userId=$user_id&userToken=$token&contestId=';
  static String? addamount;
  static String registerurl = baseurl + 'register.php';
  static String battingpointurl =
      baseurl + 'point_table_batsman.php?userId=$user_id&userToken=$token';
  static String bowlingpointurl =
      baseurl + 'point_table_bowler.php?userId=$user_id&userToken=$token';
  static String extrapointurl =
      baseurl + 'point_table_extra.php?userId=$user_id&userToken=$token';
  static String legality =
      baseurl + 'legality.php?id=4&userId=$user_id&userToken=$token';
  static String communityguidelines =
      baseurl + 'community.php?id=5&userId=$user_id&userToken=$token';
  static String privacypolicy =
      baseurl + 'privacypolicy.php?id=3&userId=$user_id&userToken=$token';
  static String aboutus =
      baseurl + 'aboutus.php?id=1&userId=$user_id&userToken=$token';
  static String tnc =
      baseurl + 'termsandcondition.php?id=2&userId=$user_id&userToken=$token';
  static String? faqpage = baseurl + 'faq.php?userId=$user_id&userToken=$token';
  static String kycStatus = baseurl + 'userdata.php?token=$token';
  static String matchlist =
      baseurl + 'matchList.php?userId=$user_id&userToken=$token';
  static String rewaredurl =
      baseurl + 'add_refer.php?userId=$user_id&userToken=$token';
  static String matchid = '0';
  static String contestid = '26';
  static String? mainbalance = '00';
  static String? ammount = '';
  static String? matchstatus;
  static String dedamount = '';
  static String matchkey = '';
  static String withdrawlist = baseurl + '';
  static String addpoints =
      baseurl + 'add_points.php?userId=$user_id&userToken=$token';
  static String apitoken = '';
  static String lb =
      baseurl + 'lb.php?userId=$user_id&userToken=$token&contestId=';
  static String livematches =
      'https://api.sports.roanuz.com/v5/cricket/RS_P_1489535559297798145/featured-matches/';
  static String matchcommentary =
      'https://api.sports.roanuz.com/v5/cricket/RS_P_1489535559297798145/match/';
  static String livematch =
      'https://api.sports.roanuz.com/v5/cricket/RS_P_1489535559297798145/match/';
  static String withdrawurl =
      baseurl + 'add_withdrawal.php?userId=$user_id&userToken=$token';
  static String joincontesturl =
      baseurl + 'join_contest.php?userId=$user_id&userToken=$token';
  static String mymatches =
      baseurl + 'mymatches.php?userId=$user_id&userToken=$token';
  static String matchdetail =
      baseurl + 'matchDetail.php?userId=$user_id&userToken=$token&id=';
  static String contestdetails =
      baseurl + 'contestDetail.php?userId=$user_id&userToken=$token&contestId=';
  static String rankapi = baseurl +
      'contestrankList.php?userId=$user_id&userToken=$token&contestId=';
  static String makepredictionapi =
      baseurl + 'bat-predict.php?userId=$user_id&userToken=$token';
  static String unpredictapi =
      baseurl + 'un_predict.php?userId=$user_id&userToken=$token&predictId=';
  static String predictionlistapi = baseurl +
      'get_bat_predict.php?userId=$user_id&userToken=$token&contestId=';
  static String contestwisepredictionsurl = baseurl +
      'joiningcontestList.php?userId=$user_id&userToken=$token&contestId=';
  static String mywithdraws =
      baseurl + 'withdrawalList.php?userId=$user_id&userToken=$token';
  static String mytransactions =
      baseurl + 'transactionList.php?userId=$user_id&userToken=$token';
  static String userprofile =
      baseurl + 'userdata.php?userId=$user_id&userToken=$token';
  static String mycontests =
      baseurl + 'mycontests.php?userId=$user_id&userToken=$token&matchId=';
  static String mypredictions =
      baseurl + 'mypredictions.php?userId=$user_id&userToken=$token&matchId=';
  static String homeslider =
      baseurl + 'home_slider.php?userId=$user_id&userToken=$token';
  static String forgotpassword = baseurl + 'forgotPassword.php';
  static String changepasswordurl =
      baseurl + 'changePassword.php?userId=$user_id&userToken=$token';
  static String cpvcpapiurl =
      baseurl + 'cap.php?userId=$user_id&userToken=$token';
  static String attemptjoin =
      baseurl + 'jc.php?userId=$user_id&userToken=$token';
  static String contacturl = baseurl + 'api_login_signup.php?apicall=contact';
  static bool? islogedin;
  static String t_id = '10000000000';
  static String order_id = '111111110000';
  static String apimessage = '';
  static String? user_id;
  static String? email;
  static String? isreffered;
  static String? mobilenumber;
  static bool isSubmitted = false;
  static String tokenLimit = '8612341646314076';
  static String? token;
  static int diaplaycounter = 0;
  static String? availablebalance;
  static String iningid = '';
}
