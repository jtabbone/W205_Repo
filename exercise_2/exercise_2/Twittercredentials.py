import tweepy

consumer_key = "PrgcSD1HDT04yr5QBd1JJoOFQ";
#eg: consumer_key = "YisfFjiodKtojtUvW4MSEcPm";


consumer_secret = "JWsU6BJ2TvpoFBaaJXyVu058HYky1oDirSDeSycEEaIHblEgrd";
#eg: consumer_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token = "899342827523584000-CESoiVylupiNl0EG74AAAJJCJOGbsBZ";
#eg: access_token = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token_secret = "mKtQtvkOajmRDod97fG1F5JmIHJbUT9B39CQTRQc0yRAM";
#eg: access_token_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";


auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)



