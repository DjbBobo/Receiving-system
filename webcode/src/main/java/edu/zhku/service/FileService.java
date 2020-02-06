package edu.zhku.service;

import edu.zhku.domain.File;
import edu.zhku.domain.Folder;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public interface FileService {
    public Folder findPage(String route)throws Exception;

    public Boolean upload(CommonsMultipartFile file, HttpServletRequest request,int pid,int uid, String... name) throws Exception;

    public List<File> findAll(String pid)throws Exception;

    public void downloadFile(String fid, HttpServletResponse response)throws Exception;

    public void removeFile(String fid,String pid)throws Exception;

    public boolean getZip(String[] fids, String title,HttpServletResponse response)throws Exception;
}
