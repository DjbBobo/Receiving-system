package edu.zhku.web;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageInfo;
import edu.zhku.domain.Folder;
import edu.zhku.service.FolderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/folder")
public class FolderController {
    @Autowired
    FolderService folderService;

    @RequestMapping(value = "/createFolder.do",method = RequestMethod.POST)
    @ResponseBody
    public String createFolder(@RequestParam(name = "obj",required = true) String obj)throws Exception{
        String[] arr = folderService.createFolder(obj);

        Map<String,String> map = new HashMap<>();
        map.put("time", arr[0]);
        map.put("route",arr[1]);
        ObjectMapper mapper = new ObjectMapper();

        return mapper.writeValueAsString(map);
    }

    @RequestMapping(value = "/updateFolder.do",method = RequestMethod.POST)
    @ResponseBody
    public String updateFolder(@RequestParam(name = "obj",required = true) String obj)throws Exception{
        String[] arr = folderService.updateFolder(obj);

        Map<String,String> map = new HashMap<>();
        map.put("time", arr[0]);
        map.put("route",arr[1]);
        ObjectMapper mapper = new ObjectMapper();

        return mapper.writeValueAsString(map);
    }

    @RequestMapping("/createSucccess.do")
    public ModelAndView createSucccess(@RequestParam(name = "time",required = true)String time
                                        ,@RequestParam(name = "route",required = true)String route
                                        ,@RequestParam(name = "uid",required = true)String uid)throws Exception{
        ModelAndView mv = new ModelAndView();
        mv.addObject("deadline",time);
        mv.addObject("route",route);
        mv.addObject("uid",uid);
        mv.setViewName("diysuccess");
        return mv;
    }

    @RequestMapping("/findList.do")
    public ModelAndView findList(@RequestParam(name = "uid",required = true)String uid
                                ,@RequestParam(name = "page",required = true,defaultValue = "1")Integer page
                                ,@RequestParam(name = "size",required = true,defaultValue = "8")Integer size)throws Exception{
        ModelAndView mv = new ModelAndView();

        List<Folder> folders = folderService.findList(Integer.parseInt(uid),page,size);
        PageInfo pageInfo = new PageInfo(folders);
        mv.addObject("uid",uid);
        mv.addObject("pageInfo",pageInfo);
        mv.setViewName("folder-list");

        return mv;
    }

    @RequestMapping("/findListByModel.do")
    public ModelAndView findListByModel(@RequestParam(name = "model",required = true)String model,
                                        @RequestParam(name = "uid",required = true)String uid,
                                        @RequestParam(name = "page",required = true,defaultValue = "1")Integer page,
                                        @RequestParam(name = "size",required = true,defaultValue = "8")Integer size)throws Exception{
        ModelAndView mv = new ModelAndView();
        model = new String(model.getBytes("ISO8859-1"),"UTF-8");
        List<Folder> folders = folderService.findListByModel(model,uid,page,size);
        PageInfo pageInfo = new PageInfo(folders);
        mv.addObject("pageInfo",pageInfo);
        mv.addObject("uid",uid);
        mv.addObject("model",model);
        mv.setViewName("folder-list");

        return mv;
    }

    @RequestMapping("/searchFolder.do")
    public ModelAndView searchFolder(@RequestParam(name = "text",required = true)String text,
                                     @RequestParam(name = "uid",required = true)String uid,
                                     @RequestParam(name = "page",required = true,defaultValue = "1")Integer page,
                                     @RequestParam(name = "size",required = true,defaultValue = "8")Integer size)throws Exception{
        System.out.println(text);
        ModelAndView mv = new ModelAndView();

        List<Folder> folders = folderService.searchFolder(uid,text,page,size);
        PageInfo pageInfo = new PageInfo(folders);
        mv.addObject("pageInfo",pageInfo);
        mv.addObject("uid",uid);
        mv.setViewName("folder-list");
        return mv;
    }

    @RequestMapping("/findListByStatus.do")
    public ModelAndView findListByNotStop(@RequestParam(name = "uid",required = true)String uid,
                                          @RequestParam(name = "status",required = true)String status,
                                          @RequestParam(name = "page",required = true,defaultValue = "1")Integer page,
                                          @RequestParam(name = "size",required = true,defaultValue = "8")Integer size)throws Exception{
        ModelAndView mv = new ModelAndView();

        List<Folder> folders = folderService.findList(Integer.parseInt(uid), page, size);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(new Date());
        System.out.println(date);
        long now = sdf.parse(date).getTime();
        System.out.println(now);
        System.out.println(folders.size());
        Iterator<Folder> iterator = folders.iterator();
       while(iterator.hasNext()){
            Folder folder = iterator.next();
            String deadline = folder.getDeadline();
            System.out.println(deadline);
            long end = sdf.parse(deadline).getTime();
            System.out.println(end);
            if("0".equals(status)){
                if (end < now || folder.getStatus() == 1){
                    iterator.remove();
                }
            }else{
                if (end >= now && folder.getStatus() == 0){
                    iterator.remove();
                }
            }
        }
        PageInfo pageInfo = new PageInfo(folders);
        mv.addObject("pageInfo",pageInfo);
        mv.addObject("uid",uid);
        if (status.equals("0")){
            mv.addObject("status","未停止收件");
        }else{
            mv.addObject("status","已停止收件");
        }
        mv.setViewName("folder-list");
        return mv;
    }


    @RequestMapping("/diy.do")
    public ModelAndView gotoDiy(@RequestParam(name = "uid",required = true)String uid){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("diy");
        mv.addObject("uid",uid);
        return mv;
    }
    @RequestMapping("/edit.do")
    public ModelAndView edit(@RequestParam(name = "pid",required = true)String pid)throws Exception{
        Folder folder = folderService.editPage(pid);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("diy");
        mv.addObject("folder",folder);
        mv.addObject("uid",folder.getUid());
        return mv;
    }

    @RequestMapping("/selectByTime.do")
    public ModelAndView selectByTime(@RequestParam(name = "uid",required = true)String uid,@RequestParam(name = "arr",required = true)String arr,@RequestParam(name = "page",required = true,defaultValue = "1")Integer page
            ,@RequestParam(name = "size",required = true,defaultValue = "8")Integer size)throws Exception{
        ModelAndView mv = new ModelAndView();
        List<Folder> folders = folderService.selectByTime(uid,arr,page,size);
        PageInfo pageInfo = new PageInfo(folders);
        mv.addObject("uid",uid);
        mv.addObject("pageInfo",pageInfo);
        if(arr.equals("desc")){
            arr = "asc";
        }else{
            arr = "desc";
        }
        mv.addObject("arr",arr);
        mv.setViewName("folder-list");
        return mv;
    }


    @RequestMapping("/changeTime.do")
    @ResponseBody
    public Map<String ,Object> changeTime(@RequestParam(name = "deadline",required = true)String deadline,
                                          @RequestParam(name = "pid",required = true)String pid)throws Exception{
        System.out.println(deadline);

        folderService.changeTime(pid,deadline);
        Date date = new Date();
        SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd");
        String today = ft.format(date);
        long date1 = ft.parse(today).getTime();
        long date2 = ft.parse(deadline).getTime();
        if (date1 > date2){
            folderService.stop(pid);
        }else{
            folderService.restart(pid);
        }

        Map<String ,Object> map = new HashMap<>();
        map.put("msg","设置成功!");
        map.put("ftime",deadline);
        return map;
    }

    @RequestMapping("/stopReason.do")
    @ResponseBody
    public Map<String,Object> stopReason(@RequestParam(name = "pid",required = true)String pid,
                                         @RequestParam(name = "reason",required = true)String reason)throws Exception{
        System.out.println(reason);
        folderService.stopReason(pid,reason);
        Map<String,Object> map = new HashMap<>();
        map.put("msg","已停止收件!");
        return map;
    }

    @RequestMapping("/stop.do")
    @ResponseBody
    public Map<String,Object> stop(@RequestParam(name = "pid",required = true)String pid)throws Exception{
        folderService.stop(pid);
        Map<String,Object> map = new HashMap<>();
        map.put("msg","已停止收件!");
        return map;
    }

    @RequestMapping("/restart.do")
    @ResponseBody
    public Map<String,Object> restart(@RequestParam(name = "pid",required = true)String pid )throws Exception{
        System.out.println(pid);
        folderService.restart(pid);
        Map<String,Object> map = new HashMap<>();
        map.put("msg","收件开启!");
        return map;
    }

    @RequestMapping("/deleteFolder.do")
    @ResponseBody
    public Map<String,Object> deleteFolder(@RequestParam(name = "pid",required = true)String pid,
                                           @RequestParam(name = "uid",required = true)String uid)throws Exception{
        folderService.deleteFolder(pid,uid);
        Map<String,Object> map = new HashMap<>();
        map.put("msg","删除成功!");
        return map;
    }


}
