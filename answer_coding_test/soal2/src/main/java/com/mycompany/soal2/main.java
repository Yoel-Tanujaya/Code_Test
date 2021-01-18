package com.mycompany.soal2;

import java.util.ArrayList;
import java.util.List;
import org.json.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class main {
    public static List<User> consumeJSON() throws ParseException{
        String JSON_DATA = 
                "{" +
                "\"data\": [" +
                "{" +
                "    \"id\": 323,\n" +
                "    \"username\": \"rinood30\",\n" +
                "    \"profile\": {\n" +
                "      \"full_name\": \"Shabrina Fauzan\",\n" +
                "      \"birthday\": \"1988-10-30\",\n" +
                "      \"phones\": [\n" +
                "        \"08133473821\",\n" +
                "        \"082539163912\"\n" +
                "      ]\n" +
                "    },\n" +
                "    \"articles:\": [\n" +
                "      {\n" +
                "        \"id\": 3,\n" +
                "        \"title\": \"Tips Berbagi Makanan\",\n" +
                "        \"published_at\": \"2019-01-03T16:00:00\"\n" +
                "      },\n" +
                "      {\n" +
                "        \"id\": 7,\n" +
                "        \"title\": \"Cara Membakar Ikan\",\n" +
                "        \"published_at\": \"2019-01-07T14:00:00\"\n" +
                "      }\n" +
                "    ]\n" +
                "  },\n" +
                "  {\n" +
                "    \"id\": 201,\n" +
                "    \"username\": \"norisa\",\n" +
                "    \"profile\": {\n" +
                "      \"full_name\": \"Noor Annisa\",\n" +
                "      \"birthday\": \"1986-08-14\",\n" +
                "      \"phones\": []\n" +
                "    },\n" +
                "    \"articles:\": [\n" +
                "      {\n" +
                "        \"id\": 82,\n" +
                "        \"title\": \"Cara Membuat Kue Kering\",\n" +
                "        \"published_at\": \"2019-10-08T11:00:00\"\n" +
                "      },\n" +
                "      {\n" +
                "        \"id\": 91,\n" +
                "        \"title\": \"Cara Membuat Brownies\",\n" +
                "        \"published_at\": \"2019-11-11T13:00:00\"\n" +
                "      },\n" +
                "      {\n" +
                "        \"id\": 31,\n" +
                "        \"title\": \"Cara Membuat Brownies\",\n" +
                "        \"published_at\": \"2019-11-11T13:00:00\"\n" +
                "      }\n" +
                "    ]\n" +
                "  },\n" +
                "  {\n" +
                "    \"id\": 42,\n" +
                "    \"username\": \"karina\",\n" +
                "    \"profile\": {\n" +
                "      \"full_name\": \"Karina Triandini\",\n" +
                "      \"birthday\": \"1986-04-14\",\n" +
                "      \"phones\": [\n" +
                "        \"06133929341\"\n" +
                "      ]\n" +
                "    },\n" +
                "    \"articles:\": []\n" +
                "  },\n" +
                "  {\n" +
                "    \"id\": 201,\n" +
                "    \"username\": \"icha\",\n" +
                "    \"profile\": {\n" +
                "      \"full_name\": \"Annisa Rachmawaty\",\n" +
                "      \"birthday\": \"1987-12-30\",\n" +
                "      \"phones\": []\n" +
                "    },\n" +
                "    \"articles:\": [\n" +
                "      {\n" +
                "        \"id\": 39,\n" +
                "        \"title\": \"Tips Berbelanja Bulan Tua\",\n" +
                "        \"published_at\": \"2019-04-06T07:00:00\"\n" +
                "      },\n" +
                "      {\n" +
                "        \"id\": 43,\n" +
                "        \"title\": \"Cara Memilih Permainan di Steam\",\n" +
                "        \"published_at\": \"2019-06-11T05:00:00\"\n" +
                "      },\n" +
                "      {\n" +
                "        \"id\": 58,\n" +
                "        \"title\": \"Cara Membuat Brownies\",\n" +
                "        \"published_at\": \"2019-09-12T04:00:00\"\n" +
                "      }\n" +
                "    ]\n" +
                "  }" +
                "]" +
                "}"; 
        final JSONObject obj = new JSONObject(JSON_DATA);
        final JSONArray data = obj.getJSONArray("data");
        List<User> userList = new ArrayList<>();
        for (int i = 0; i < data.length(); ++i) {
            List<String> phoneList = new ArrayList<>();
            List<Article> articleList = new ArrayList<>();
            JSONObject userData = data.getJSONObject(i);
            JSONObject userProf = userData.getJSONObject("profile");
            JSONArray phoneArray = userProf.getJSONArray("phones");
            JSONArray artArray = userData.getJSONArray("articles:");
            Date birthday, artPublished;
            try {
              birthday = new SimpleDateFormat("yyyy-MM-dd").parse(userProf.getString("birthday"));
            } catch(ParseException e) {
              throw e;
            }
            for(int x=0;x<phoneArray.length();x++) {
                phoneList.add(phoneArray.getString(x));
            }
            for(int j = 0; j < artArray.length(); j++) {
                try {
                  artPublished = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(artArray.getJSONObject(j).getString("published_at"));
                } catch(ParseException e) {
                  throw e;
                }
                articleList.add(new Article(userData.getInt("id"), artArray.getJSONObject(j).getInt("id"), artArray.getJSONObject(j).getString("title"), artPublished));
            }
            Profile p = new Profile(userData.getInt("id"), userProf.getString("full_name"), birthday, phoneList);
            User u = new User(userData.getInt("id"),userData.getString("username"), p, articleList);
            userList.add(u);
        }
        return userList;
    }
    
    public static void main(String[] args) throws ParseException {
        try{
            for(User u : consumeJSON()) {
                if (u.profile.phones.isEmpty()) System.out.println("No Phones: "+u.username+" ("+u.userId+")");
            }
            for(User u : consumeJSON()) {
                if (u.articles.size()>0) System.out.println("Have articles: "+u.username+" ("+u.userId+")");
            }
            for(User u : consumeJSON()) {
                if (u.profile.fullName.toLowerCase().contains("annis")) System.out.println("Has name 'annis': "+u.username+" ("+u.userId+")");
            }
            for(User u : consumeJSON()) {
                if (u.articles.isEmpty()) {
                    continue;
                } else {
                    for (Article a: u.articles) {
                        if (a.published.after(new SimpleDateFormat( "yyyyMMdd" ).parse("20191231"))) System.out.println("Article published on 2020: "+u.username+" ("+u.userId+")");
                    }
                }
            }
            for(User u : consumeJSON()) {
                if (u.profile.birthday.after(new SimpleDateFormat( "yyyy" ).parse("1984"))) System.out.println("Born in 1984: "+u.username+" ("+u.userId+")");
            }
            for(User u : consumeJSON()) {
                for (int z=0;z<u.articles.size();z++) {
                    if (u.articles.get(z).title.toLowerCase().contains("tips")) System.out.println("Article title containing 'tips': "+u.username+" ("+u.userId+")");
                }
            }
            for(User u : consumeJSON()) {
                for (Article a: u.articles) {
                    if (a.published.before(new SimpleDateFormat( "yyyyMM" ).parse("201908"))) System.out.println("Article published before August 2019: "+u.username+" ("+u.userId+")");
                }
            }
        } catch(ParseException e) {
            throw e;
        }
        
    }
}
