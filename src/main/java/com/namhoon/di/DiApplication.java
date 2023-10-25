package com.namhoon.di;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.ComponentScan;

@EnableCaching
@SpringBootApplication
@MapperScan("com.namhoon.di.mapper")
public class DiApplication {

    public static void main(String[] args) {
        SpringApplication.run(DiApplication.class, args);
    }

}
