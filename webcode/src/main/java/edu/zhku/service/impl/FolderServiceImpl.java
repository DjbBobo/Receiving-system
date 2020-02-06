package edu.zhku.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageHelper;
import edu.zhku.dao.FileDao;
import edu.zhku.dao.FolderDao;
import edu.zhku.domain.Folder;
import edu.zhku.service.FolderService;
import edu.zhku.uitl.StringUtil;
import edu.zhku.uitl.UUIDGenerator;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.util.List;

@Service
@Transactional
public class FolderServiceImpl implements FolderService {
    @Autowired
    FolderDao folderDao;
    @Autowired
    FileDao fileDao;

    @Override
    public String[] createFolder(String obj) throws Exception {
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode node = objectMapper.readTree(obj);
        String uid = StringUtil.operate(String.valueOf(node.get("uid")));
        String deadline = StringUtil.operate(String.valueOf(node.get("deadline")));
        String title = StringUtil.operate(String.valueOf(node.get("title")));
        String content = StringUtil.operate(String.valueOf(node.get("content")));
        String filename = StringUtil.operate(String.valueOf(node.get("filename")));
        String model = StringUtil.operate(String.valueOf(node.get("model")));
        String route = UUIDGenerator.getUUID().substring(0,11);
        Folder folder = new Folder();
        JSONArray array = JSONArray.parseArray(String.valueOf(node.get("arr")));
        if(array.size() != 0){
            folder.setFinput(String.valueOf(array.get(0)));
            if(array.size() > 1)
                folder.setSinput(String.valueOf(array.get(1)));
        }

        folder.setUid(Integer.parseInt(uid));
        folder.setContent(content);
        folder.setTitle(title);
        folder.setDeadline(deadline);
        folder.setRoute(route);
        folder.setTinput(filename);
        folder.setModel(model);
        System.out.println(folder.toString());

        folderDao.createFolder(folder);

        String[] arr = new String[2];
        arr[0] = deadline;
        arr[1] = route;

        return arr;

    }

    @Override
    public String[] updateFolder(String obj) throws Exception {
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode node = objectMapper.readTree(obj);
        String uid = StringUtil.operate(String.valueOf(node.get("uid")));
        String deadline = StringUtil.operate(String.valueOf(node.get("deadline")));
        String title = StringUtil.operate(String.valueOf(node.get("title")));
        String content = StringUtil.operate(String.valueOf(node.get("content")));
        String filename = StringUtil.operate(String.valueOf(node.get("filename")));
        String route = StringUtil.operate(String.valueOf(node.get("route")));
        String model = StringUtil.operate(String.valueOf(node.get("model")));
        Folder folder = new Folder();
        JSONArray array = JSONArray.parseArray(String.valueOf(node.get("arr")));
        if(array.size() != 0){
            folder.setFinput(String.valueOf(array.get(0)));
            if(array.size() > 1)
                folder.setSinput(String.valueOf(array.get(1)));
        }

        folder.setUid(Integer.parseInt(uid));
        folder.setContent(content);
        folder.setTitle(title);
        folder.setDeadline(deadline);
        folder.setRoute(route);
        folder.setTinput(filename);
        folder.setModel(model);
        System.out.println(folder.toString());

        folderDao.updateFolder(folder);

        String[] arr = new String[2];
        arr[0] = deadline;
        arr[1] = route;

        return arr;

    }

    @Override
    public void deleteFolder(String pid,String uid) throws Exception {
        fileDao.deleteFileByPid(pid);
        folderDao.deleteFolder(pid);
        String path = "C:/upload/"+uid+"/"+pid;
        File file = new File(path);
        if (!file.isDirectory())
                return;
        FileUtils.deleteDirectory(file);
    }

    @Override
    public List<Folder> selectByTime(String uid,String arr,int page,int size) throws Exception {
        PageHelper.startPage(page, size);
        if(arr.equals("desc")){
            return folderDao.selectByTimeAsc(uid);
        }
        return folderDao.selectByTimeDesc(uid);

    }

    @Override
    public List<Folder> findListByModel(String model, String uid, Integer page, Integer size) throws Exception {
        PageHelper.startPage(page, size);
        return folderDao.findListByModel(model,uid);
    }

    @Override
    public List<Folder> searchFolder(String uid, String text, Integer page, Integer size) throws Exception {
        PageHelper.startPage(page,size);
        return folderDao.searchFolder(uid,text);
    }


    @Override
    public List<Folder> findList(int uid,int page,int size) throws Exception {
        PageHelper.startPage(page, size);
        return folderDao.findList(uid);
    }

    @Override
    public void stop(String pid) throws Exception {
        folderDao.stop(pid);
    }


    @Override
    public void changeTime(String pid, String deadline) throws Exception {
        folderDao.changeTime(pid,deadline);
    }

    @Override
    public void stopReason(String pid, String reason) throws Exception {
        folderDao.stopReason(pid,reason);
    }

    @Override
    public void restart(String pid) throws Exception {
        folderDao.restart(pid);
    }

    @Override
    public Folder editPage(String pid) throws Exception {
        return folderDao.editPage(pid);
    }




}
