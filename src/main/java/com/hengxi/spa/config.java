package com.hengxi.spa;

import com.hengxi.spa.dao.Person;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;


@Configuration
public class config {

    @Bean
    public Person myPerson(){
        return new Person();
    }
}
