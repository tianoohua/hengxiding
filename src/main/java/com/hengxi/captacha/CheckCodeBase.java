package com.hengxi.captacha;

/**
 * @Author:tianhua
 * @Description:
 * @Date:Created in 17:33 2019/4/1
 * @Modified by:
 */

import nl.captcha.Captcha;
import nl.captcha.Captcha.Builder;
import nl.captcha.backgrounds.BackgroundProducer;
import nl.captcha.backgrounds.FlatColorBackgroundProducer;
import nl.captcha.backgrounds.GradiatedBackgroundProducer;
import nl.captcha.backgrounds.SquigglesBackgroundProducer;
import nl.captcha.servlet.CaptchaServletUtil;
import nl.captcha.text.producer.DefaultTextProducer;
import nl.captcha.text.renderer.DefaultWordRenderer;
import nl.captcha.text.renderer.WordRenderer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@WebServlet(
        urlPatterns = "/CaptchaImg",
        name = "CheckCodeBase"
)
public  class CheckCodeBase extends HttpServlet {
        private static final long serialVersionUID = 1L;
        private static final int width = 150;
        private static final int height = 50;
    private static final String elements = "23456789abcdefgjkmxyzpqr";

    public CheckCodeBase() {
    }

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        System.out.println("sssssssssssssss");
        Integer checkCode = null;

        try {
            checkCode = Integer.parseInt("1");
        } catch (NumberFormatException var14) {
            checkCode = Integer.valueOf(1);
        }

        Builder builder = new Builder(150, 50);
        List<Font> fontList = new ArrayList();
        fontList.add(new Font("Microsoft YaHei UI", 1, 40));
        fontList.add(new Font("Arial", 2, 40));
        Random random = new Random();
        int r = random.nextInt(255);
        int g = random.nextInt(255);
        int b = random.nextInt(255);
        WordRenderer wr = new DefaultWordRenderer(new Color(r, g, b), fontList);
        char[] chars = "23456789".toCharArray();
        Object bp;
        switch(checkCode.intValue()) {
            case 2:
                bp = new GradiatedBackgroundProducer();
                builder.addNoise();
                break;
            case 3:
                chars = "23456789abcdefgjkmxyzpqr".toCharArray();
                bp = new GradiatedBackgroundProducer();
                break;
            case 4:
                chars = "23456789abcdefgjkmxyzpqr".toCharArray();
                builder.addNoise();
                bp = new GradiatedBackgroundProducer();
                ((GradiatedBackgroundProducer)bp).setFromColor(Color.black);
                ((GradiatedBackgroundProducer)bp).setToColor(Color.white);
                break;
            case 5:
                chars = "23456789abcdefgjkmxyzpqr".toCharArray();
                bp = new SquigglesBackgroundProducer();
                break;
            case 6:
                builder.addNoise();
                chars = "23456789abcdefgjkmxyzpqr".toCharArray();
                bp = new SquigglesBackgroundProducer();
                break;
            default:
                bp = new FlatColorBackgroundProducer(Color.white);
        }

        BackgroundProducer bpp = this.createCodeBackground((BackgroundProducer)bp);
        builder.addText(new DefaultTextProducer(checkCode.intValue() / 2 + 3, chars), wr);
        builder.addBackground(bpp);
        this.createCodeImgStyle(builder);
        Captcha captcha = builder.build();
        req.getSession().setAttribute("simpleCaptcha", captcha.getAnswer());
        CaptchaServletUtil.writeImage(resp, captcha.getImage());
    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }

    public  BackgroundProducer createCodeBackground(BackgroundProducer var1){
        return new BackgroundProducer() {
            @Override
            public BufferedImage addBackground(BufferedImage bufferedImage) {
                return null;
            }

            @Override
            public BufferedImage getBackground(int i, int i1) {
                return null;
            }
        };
    };

    public  void createCodeImgStyle(Builder var1){};
}
