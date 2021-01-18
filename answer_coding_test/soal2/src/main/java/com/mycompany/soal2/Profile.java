package com.mycompany.soal2;

import java.util.Date;
import java.util.List;

public class Profile {
    int userId;
    String fullName;
    Date birthday;
    List<String> phones;
    
    Profile(int id, String n, Date b, List<String> p) {
        this.userId = id;
        this.fullName = n;
        this.birthday = b;
        this.phones = p;
    }
}
