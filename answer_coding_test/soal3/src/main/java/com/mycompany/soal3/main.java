package com.mycompany.soal3;

import java.util.ArrayList;
import java.util.List;
import org.json.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class main {
    public static List<Inventory> consumeJSON() throws ParseException {
        String JSON_DATA = 
                "{" +
                "\"data\": [" +
                "  {\n" +
                "    \"inventory_id\": 9382,\n" +
                "    \"name\": \"Brown Chair\",\n" +
                "    \"type\": \"furniture\",\n" +
                "    \"tags\": [\n" +
                "      \"chair\",\n" +
                "      \"furniture\",\n" +
                "      \"brown\"\n" +
                "    ],\n" +
                "    \"purchased_at\": 1579190471,\n" +
                "    \"placement\": {\n" +
                "      \"room_id\": 3,\n" +
                "      \"name\": \"Meeting Room\"\n" +
                "    }\n" +
                "  },\n" +
                "  {\n" +
                "    \"inventory_id\": 9380,\n" +
                "    \"name\": \"Big Desk\",\n" +
                "    \"type\": \"furniture\",\n" +
                "    \"tags\": [\n" +
                "      \"desk\",\n" +
                "      \"furniture\",\n" +
                "      \"brown\"\n" +
                "    ],\n" +
                "    \"purchased_at\": 1579190642,\n" +
                "    \"placement\": {\n" +
                "      \"room_id\": 3,\n" +
                "      \"name\": \"Meeting Room\"\n" +
                "    }\n" +
                "  },\n" +
                "  {\n" +
                "    \"inventory_id\": 2932,\n" +
                "    \"name\": \"LG Monitor 50 inch\",\n" +
                "    \"type\": \"electronic\",\n" +
                "    \"tags\": [\n" +
                "      \"monitor\"\n" +
                "    ],\n" +
                "    \"purchased_at\": 1579017842,\n" +
                "    \"placement\": {\n" +
                "      \"room_id\": 3,\n" +
                "      \"name\": \"Lavender\"\n" +
                "    }\n" +
                "  },\n" +
                "  {\n" +
                "    \"inventory_id\": 232,\n" +
                "    \"name\": \"Sharp Pendingin Ruangan 2PK\",\n" +
                "    \"type\": \"electronic\",\n" +
                "    \"tags\": [\n" +
                "      \"ac\"\n" +
                "    ],\n" +
                "    \"purchased_at\": 1578931442,\n" +
                "    \"placement\": {\n" +
                "      \"room_id\": 5,\n" +
                "      \"name\": \"Dhanapala\"\n" +
                "    }\n" +
                "  },\n" +
                "  {\n" +
                "    \"inventory_id\": 9382,\n" +
                "    \"name\": \"Alat Makan\",\n" +
                "    \"type\": \"tableware\",\n" +
                "    \"tags\": [\n" +
                "      \"spoon\",\n" +
                "      \"fork\",\n" +
                "      \"tableware\"\n" +
                "    ],\n" +
                "    \"purchased_at\": 1578672242,\n" +
                "    \"placement\": {\n" +
                "      \"room_id\": 10,\n" +
                "      \"name\": \"Rajawali\"\n" +
                "    }\n" +
                "  }\n" +
                "]"+
                "}";
        final JSONObject obj = new JSONObject(JSON_DATA);
        final JSONArray data = obj.getJSONArray("data");
        List<Inventory> invList = new ArrayList<>();
        for (int i = 0; i < data.length(); ++i) {
            List<String> tagList = new ArrayList<>();
            JSONObject invData = data.getJSONObject(i);
            JSONArray tagData = invData.getJSONArray("tags");
            long longDate = invData.getLong("purchased_at");
            Date purchased = new Date(longDate);
            for(int j=0;j<tagData.length();j++) {
                tagList.add(tagData.get(j).toString());
            }
            invList.add(new Inventory(invData.getInt("inventory_id"), invData.getString("name"), invData.getString("type"), tagList, purchased, new Place(invData.getJSONObject("placement").getInt("room_id"), invData.getJSONObject("placement").getString("name"))));
        }
        return invList;
    }
    
    public static void main(String[] args) throws ParseException {
        try{
            for(Inventory i : consumeJSON()) {
                System.out.println(i.name+" ; "+i.type+" ("+i.invId+") Purchased: "+new SimpleDateFormat("dd-MM-yyyy").format(i.purchased));
            }
            for(Inventory i : consumeJSON()) {
                if (i.placement.placeName.equalsIgnoreCase("meeting room")) System.out.println("In Meeting Room:"+i.name+" ; "+i.type+" ("+i.invId+") Purchased: "+new SimpleDateFormat("dd-MM-yyyy").format(i.purchased));
            }
            for(Inventory i : consumeJSON()) {
                if (i.type.equalsIgnoreCase("electronic")) System.out.println("Electronic Devices: "+i.name+" ; "+i.type+" ("+i.invId+") Purchased: "+new SimpleDateFormat("dd-MM-yyyy").format(i.purchased));
            }
            for(Inventory i : consumeJSON()) {
                for(int x=0;x<i.tags.size();x++) {
                    if (i.tags.get(x).equalsIgnoreCase("furniture")) System.out.println("Tagged Furniture: "+i.name+" ; "+i.type+" ("+i.invId+") Purchased: "+new SimpleDateFormat("dd-MM-yyyy").format(i.purchased));
                }
            }
            for(Inventory i : consumeJSON()) {
                if (i.purchased.equals(new SimpleDateFormat( "yyyyMMdd" ).parse("20200116"))) System.out.println("Purchased at 16 Jan 2020: "+i.name+" ; "+i.type+" ("+i.invId+") Purchased: "+new SimpleDateFormat("dd-MM-yyyy").format(i.purchased));
            }
            for(Inventory i : consumeJSON()) {
                for(int x=0;x<i.tags.size();x++) {
                    if (i.tags.get(x).equalsIgnoreCase("brown")) System.out.println("Brown Color: "+i.name+" ; "+i.type+" ("+i.invId+") Purchased: "+new SimpleDateFormat("dd-MM-yyyy").format(i.purchased));
                }
            }
        } catch(ParseException e) {
            throw e;
        }
        
    }
}
