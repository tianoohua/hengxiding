package com.hengxi.spa;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
//就是@Controller+@ResponseBody组合，支持RESTful访问方式，返回结果都是json字符串
public class HelloController {

    @RequestMapping("hello")
    public String hello(){
        String jgi = new String();
        jgi +="jdig";
        return "hello new world!";
    }
}
