package edu.zhku.web;

import edu.zhku.domain.File;
import edu.zhku.domain.Folder;
import edu.zhku.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/file")
public class FileController {
    @Autowired
    FileService fileService;

    @RequestMapping("/getZip.do")
    public void getZip(@RequestParam(name = "fids",required = true)String fidsStr,
                       @RequestParam(name = "title",required = true)String title,HttpServletResponse response)throws Exception{
        String[] fids = fidsStr.split(",");
        System.out.println(fids.toString());
        boolean flag = fileService.getZip(fids,title,response);
    }

    @RequestMapping("/removeFile.do")
    @ResponseBody
    public Map<String,Object> removeFile(@RequestParam(name = "fid",required = true)String fid
                                    ,@RequestParam(name = "pid",required = true)String pid)throws Exception{
        Map<String,Object> map = new HashMap<>();
        fileService.removeFile(fid,pid);
        map.put("code",0);
        map.put("msg","删除成功");
        return map;
    }

    @RequestMapping("/downloadFile.do")
    public void downloadFile(@RequestParam(name = "fid",required = true)String fid, HttpServletResponse response)throws Exception{
        fileService.downloadFile(fid,response);
    }

    @RequestMapping("/findAll.do")
    public ModelAndView findAll(@RequestParam(name = "pid",required = true)String pid,
                                @RequestParam(name = "title",required = true)String title,
                                @RequestParam(name = "uid",required = true)String uid) throws Exception {
        ModelAndView mv = new ModelAndView();

        List<File> fileList =  fileService.findAll(pid);

        mv.addObject("fileList",fileList);
        mv.addObject("pid",pid);
        mv.addObject("title",title);
        mv.addObject("uid",uid);
        mv.setViewName("file-list");
        return mv;
    }

    @RequestMapping("/findPage.do")
    public ModelAndView findPage(@RequestParam(name = "route",required = true)String route)throws Exception{
        ModelAndView mv = new ModelAndView();

        Folder folder = fileService.findPage(route);
        if(folder != null){
            mv.addObject("folder",folder);
            mv.setViewName("upload");
        }else{
            mv.setViewName("fail");
        }
        return mv;
    }

    @RequestMapping("/upload.do")
    @ResponseBody
    public Map<String,Object> upload(@RequestParam(name = "file",required = true) CommonsMultipartFile file, HttpServletRequest request)throws Exception{
        String[] name = new String[2];
        name[0] = request.getParameter("first");
        name[1] = request.getParameter("second");
        int pid = Integer.parseInt(request.getParameter("pid"));
        int uid = Integer.parseInt(request.getParameter("uid"));
        boolean flag = fileService.upload(file,request,pid,uid,name);
        Map<String,Object> map = new HashMap<>();
        map.put("msg","上传成功!");
        return map;

    }
}
