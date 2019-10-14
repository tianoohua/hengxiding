package com.hengxi.spa;

import com.hengxi.spa.mapper.KB02Mapper;
import com.hengxi.spa.pojo.KB02;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class KB02Controller {
    public final static Logger log = LoggerFactory.getLogger(KB02Controller.class);

    @Autowired
    KB02Mapper kb02Mapper;

    @RequestMapping("")
    @ResponseBody
    public String initPage(){
        return "vueinit";
    }

    @RequestMapping("hospital")
    public String queryKB02(Model m){
        log.warn("+++++++++++启动中+++++++++++");
        try {
        int i = -1/0;
        }catch (Exception e){
            log.info(e.toString());
        }


        List<KB02> hospital = kb02Mapper.getAllKB02();
        m.addAttribute("hospital",hospital);
        return "hospital";
    }
}
