package helpers;

import java.util.Date;

import com.github.javafaker.Faker;
import java.text.SimpleDateFormat;

public class DataGenerator {
    
    public static String getRandomEmail(){
        Faker faker = new Faker();
        String email = faker.internet().emailAddress();
        return email;
    }

    public static String getRandomIataOrigin(){
        Faker faker = new Faker();
        String iataOrigin = faker.regexify("([A-Z]{3})");
        return iataOrigin;
    }

    public static String getRandomIataDestination(){
        Faker faker = new Faker();
        String iataDestination = faker.regexify("([A-Z]{3})");
        return iataDestination;
    }

    public static String getRandomDate(){
        Faker faker = new Faker();
        Date date = faker.date().birthday();

        SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
        return simpleDate.format(date);
    }

    public static String getRandomName(){
        Faker faker = new Faker();
        String name = faker.name().firstName();
        return name;
    }

    public static String getRandomSurname(){
        Faker faker = new Faker();
        String surname = faker.name().lastName();
        return surname;
    }
}