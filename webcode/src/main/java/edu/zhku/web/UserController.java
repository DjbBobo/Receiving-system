package edu.zhku.web;

import com.github.pagehelper.PageInfo;
import edu.zhku.domain.Folder;
import edu.zhku.domain.User;
import edu.zhku.service.UserService;
import edu.zhku.uitl.getCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    UserService userService;

    @RequestMapping("/sendEmail.do")
    @ResponseBody
    public Map<String,Object> sendEmail(@RequestParam(name = "email",required = true)String email)throws Exception{
        Map<String,Object> map = new HashMap<>();
        boolean isexist = userService.findEmail(email);
        if(isexist){
            map.put("code",1);
            map.put("msg","邮箱尚未注册!");
        }else{
            userService.sendEmail(email);
            map.put("code",0);
            map.put("msg","发送成功!");
        }

        return map;
    }

    @RequestMapping("/add.do")
    @ResponseBody
    public Map<String,Object> addUser(@RequestParam(name = "email",required = true)String email, @RequestParam(name = "name",required = true)String name
            , @RequestParam(name = "pwd",required = true)String pwd, @RequestParam(name = "pwd2",required = true)String pwd2)throws Exception{
        boolean flag = userService.findEmail(email);
        Map<String,Object> map = new HashMap<>();
        if(flag){
            //允许注册
            userService.addUser(email,name,pwd,pwd2);
            map.put("msg","注册成功!");
            map.put("code",0);
        }else{
            map.put("msg","当前邮箱已注册!");
            map.put("code",1);
        }
        return map;
    }
//    @RequestMapping("/add.do")
//    @ResponseBody
//    public ModelAndView addUser(@RequestParam(name = "email",required = true)String email, @RequestParam(name = "name",required = true)String name
//                        , @RequestParam(name = "pwd",required = true)String pwd, @RequestParam(name = "pwd2",required = true)String pwd2)throws Exception{
//        boolean flag = userService.findEmail(email);
//        ModelAndView mv = new ModelAndView();
//        if(flag){
//            //允许注册
//            userService.addUser(email,name,pwd,pwd2);
//            mv.addObject("msg","注册成功!");
//        }else{
//            mv.addObject("msg","当前邮箱已注册!");
//        }
//        mv.setViewName("main");
//        return mv;
//    }

    @RequestMapping("/login.do")
    public ModelAndView login(@RequestParam(name = "email",required = true)String account,@RequestParam(name = "pwd",required = true)String pwd
                                ,@RequestParam(name = "page",required = true,defaultValue = "1")Integer page
                                 ,@RequestParam(name = "size",required = true,defaultValue = "8")Integer size)throws Exception{
        ModelAndView mv = new ModelAndView();
        String uid = userService.login(account,pwd);
        System.out.println(uid);
        if (uid != null){
            List<Folder> folders = userService.findMyPage(uid,page,size);
            PageInfo pageInfo = new PageInfo(folders);
            mv.addObject("uid",uid);
            mv.addObject("pageInfo",pageInfo);
            mv.setViewName("folder-list");
        }else{
            mv.setViewName("main");
        }
        return mv;
    }

    @RequestMapping("/findUser.do")
    public ModelAndView findUser(@RequestParam(name = "uid",required = true)String uid)throws Exception{
        ModelAndView mv = new ModelAndView();
        User user = userService.findUser(uid);
        mv.addObject("user",user);
        mv.setViewName("userinfo");
        return mv;
    }

    @RequestMapping("/getVerifyCode")
    public void generate(HttpServletResponse response, HttpSession session) {
        // 禁止缓存
        response.setHeader("Cache-Control", "no-cache");
        //设置过期时间为立即过期
        response.setDateHeader("Expires", 0);
        ByteArrayOutputStream output = new ByteArrayOutputStream();
        String verifyCodeValue = new getCode().drawImg(output);
        // 将校验码保存到session中
        session.setAttribute("verifyCodeValue", verifyCodeValue);
        System.out.println(verifyCodeValue);
        try {
            ServletOutputStream out = response.getOutputStream();
            output.writeTo(out);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/changePwd.do")
    @ResponseBody
    public Map<String ,Object> changePwd(@RequestParam(name = "uid",required = true)String uid,
                                         @RequestParam(name = "oldpwd",required = true)String oldpwd,
                                         @RequestParam(name = "newpwd",required = true)String newpwd,
                                         @RequestParam(name = "code",required = true)String code,
                                         HttpServletRequest request)throws Exception{
        Map<String ,Object> map = new HashMap<>();
        if(code.toLowerCase().equals(request.getSession().getAttribute("verifyCodeValue").toString().toLowerCase())){
            boolean flag = userService.findOldPwd(uid,oldpwd);
            if(!flag){
                map.put("code",1);
                map.put("msg","原始密码错误");
                return map;
            }
            userService.changePwd(uid,newpwd);
                map.put("code",0);
                map.put("msg","密码修改成功");
                return map;
        }else{
            map.put("code",1);
            map.put("msg","验证码错误");
            return map;
        }


    }
}
