package com.hengxi.spa;

import com.hengxi.spa.dao.Person;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class SpaApplicationTests {

    @Autowired
    Person person;

    @Autowired
    Person myPerson;

    @Autowired
    ApplicationContext applicationContext;

    @Test
    public void contextLoads() {



        Boolean b = applicationContext.containsBean("person");
        b.equals(true);

        System.out.println(b);
        System.out.println(person.toString());



        System.out.println(applicationContext.getApplicationName());
        System.out.println(myPerson);
    }

}
