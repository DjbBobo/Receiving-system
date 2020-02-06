package edu.zhku.service;

import edu.zhku.domain.Folder;

import java.util.List;

public interface FolderService {
    public String[] createFolder(String obj)throws Exception;

    public List<Folder> findList(int parseInt,int page,int size)throws Exception;

    public void stop(String pid)throws Exception;

    public void changeTime(String pid, String deadline)throws Exception;

    public void stopReason(String pid, String reason)throws Exception;

    public void restart(String pid)throws Exception;

    public Folder editPage(String pid)throws Exception;

    public String[] updateFolder(String obj)throws Exception;

    public void deleteFolder(String pid,String uid)throws Exception;

    public List<Folder> selectByTime(String uid,String arr,int page,int size)throws Exception;


    public List<Folder> findListByModel(String model, String uid, Integer page, Integer size)throws Exception;

    public List<Folder> searchFolder(String uid, String text, Integer page, Integer size)throws Exception;

}
