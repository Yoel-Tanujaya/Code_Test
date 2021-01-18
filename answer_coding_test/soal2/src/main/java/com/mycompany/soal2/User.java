package com.mycompany.soal2;

import java.util.List;

public class User {
    int userId;
    String username;
    Profile profile;
    List<Article> articles;
    
    User(int id, String u, Profile p, List<Article> a) {
        this.userId = id;
        this.username = u;
        this.profile = p;
        this.articles = a;
    }
}
