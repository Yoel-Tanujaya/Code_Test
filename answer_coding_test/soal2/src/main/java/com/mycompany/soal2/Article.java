package com.mycompany.soal2;

import java.util.Date;

public class Article {
    int userId;
    int artId;
    String title;
    Date published;
    
    Article(int uid, int aid, String t, Date p) {
        this.userId = uid;
        this.artId = aid;
        this.title = t;
        this.published = p;
    }
}
