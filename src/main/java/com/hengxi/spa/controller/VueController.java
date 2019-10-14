package com.hengxi.spa.controller;

import com.hengxi.spa.mapper.KB02Mapper;
import com.hengxi.spa.pojo.KB02;
import org.apache.ibatis.annotations.Select;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.print.DocFlavor;
import java.math.BigDecimal;
import java.util.List;

@Controller
public class VueController {
    public final static Logger log = LoggerFactory.getLogger(VueController.class);

    @Autowired
    KB02Mapper kb02Mapper;

    @RequestMapping("vueIndex")
    public String queryKB02(Model m){
        log.warn("+++++++++++进入vue页面+++++++++++");
        try {
        int i = -1/0;
            BigDecimal ui = new BigDecimal("6.444444444");
            String sd =ui.toString();
        }catch (Exception e){
            log.info(e.toString());
        }


        List<KB02> hospital = kb02Mapper.getAllKB02();
        m.addAttribute("hospital",hospital);
        return "vue/vueIndex";
    }
}
