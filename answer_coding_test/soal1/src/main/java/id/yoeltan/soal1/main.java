package id.yoeltan.soal1;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import org.apache.commons.lang3.StringUtils;

public class main {
    public static void main(String[] args) throws Exception {
        Date dateRec;
        List<Food> foodList = new ArrayList<>();
        int total = 0;
        String line = new String(new char[30]).replace('\0', '=');
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");  
        Scanner sc= new Scanner(System.in);
        System.out.println("Nama Resto: ");
        String restoInput = sc.nextLine();
        System.out.println("Tanggal: ");
        String dateIn = sc.nextLine();
        try {
            dateRec = dateFormat.parse(dateIn);
        } catch(ParseException e) {
            throw e;
        }
        System.out.println("Nama Kasir: ");
        String cashierInput = sc.nextLine();
        System.out.println("Input Menu dan Harga (ex. Nas1 10000) (ketik stop untuk mengakhiri) : ");
        while(sc.hasNextLine()&&!sc.hasNext("stop")) {
            String menuInput = sc.nextLine();
            String menu[] = menuInput.split(" ");
            foodList.add(new Food(menu[0], menu[1]));
        }
        System.out.printf("%n%n%s%n%n",StringUtils.center(restoInput,30));
        System.out.printf("%1$-15s","Tanggal: ");
        System.out.printf("%1$15s%n",dateFormat.format(dateRec));
        System.out.printf("%1$-15s","Nama Kasir: ");
        System.out.printf("%1$15s%n",cashierInput);
        System.out.println(line);
        for (Food f : foodList) {
            System.out.printf("%s",String.format("%-22s", f.foodName).replace(' ', '.'));
            System.out.printf("Rp%,d%n",Integer.parseInt(f.price));
            total+=Integer.parseInt(f.price);
        }
        System.out.printf("%n%s",String.format("%-22s", "Total").replace(' ', '.'));
        System.out.printf("Rp%,d",total);
    }
}
