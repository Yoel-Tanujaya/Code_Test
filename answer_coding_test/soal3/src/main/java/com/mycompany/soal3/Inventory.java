package com.mycompany.soal3;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Inventory {
    int invId;
    String name;
    String type;
    List<String> tags = new ArrayList<>();
    Date purchased;
    Place placement;
    
    Inventory(int i, String n, String t, List<String> lst, Date p, Place pl) {
        this.invId = i;
        this.name = n;
        this.type = t;
        this.tags = lst;
        this.purchased = p;
        this.placement = pl;
    }
}
