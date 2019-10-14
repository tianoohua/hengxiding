package com.hengxi.spa;

import com.hengxi.captacha.CheckCodeBase;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
//就是@SpringBootConfiguration+@EnableAutoConfiguration+@ComponentScan等组合在一下，非常简单，使用也方便
@ServletComponentScan
//在springboot启动时会扫描@WebServlet，并将该类实例化
public class SpaApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpaApplication.class, args);
    }

    @Bean
    public ServletRegistrationBean getservletRegistrationBean(){
        ServletRegistrationBean bean=new ServletRegistrationBean(new CheckCodeBase());
        bean.addUrlMappings("/CaptchaImg");
        return bean;
    }

    @Bean
    public ServletRegistrationBean getservletRegistrationBeanAliyunApi(){
        ServletRegistrationBean bean=new ServletRegistrationBean(new CheckCodeBase());
        bean.addUrlMappings("/CaptchaImg");
        return bean;
    }

}
