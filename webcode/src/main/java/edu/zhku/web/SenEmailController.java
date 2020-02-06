package edu.zhku.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/email")
public class SenEmailController {

    @Autowired
    private JavaMailSender javaMailSender;

    @RequestMapping("/send.do")
    public Map<String,Object> senMsg(@RequestParam(name = "email",required = true)String toEmail){
        System.out.println("发邮箱啦");
        SimpleMailMessage message = new SimpleMailMessage();
        //发件人的邮箱地址
        message.setFrom("981745815@qq.com");
        //收件人的邮箱地址
        message.setTo(toEmail);
        //邮件主题
        message.setSubject("spring email test!!!!");
        //邮件内容
        message.setText("log4j:WARN No appenders could be found for logger (org.springframework.web.context.ContextLoader).一月 08, 2020 11:55:26 下午 org.apache.catalina.deploy.WebXml setVe[2020-01-08 11:55:26,302] Artifact WebProject:war exploded: Artifact is being deployed, please wait...rsion");
        //发送邮件
        Map<String,Object> map = new HashMap<>();
        try{
            javaMailSender.send(message);
            map.put("code",0);
            map.put("msg","邮件发送成功");
        }catch (Exception e){
            e.printStackTrace();
            map.put("code",1);
            map.put("msg","邮箱发送失败");
        }



        return map;
    }
}
