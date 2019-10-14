package com.hengxi.spa.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class ModuleController {
    private final static Logger logger = LoggerFactory.getLogger(ModuleController.class);

    @RequestMapping("module")
    public String module(Model m){
        logger.info("++++++++++进入module+++++++++++");
        return "vue/moduleDataShowForCounty";
    }

}
