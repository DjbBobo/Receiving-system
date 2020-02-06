package edu.zhku.service.impl;

import edu.zhku.dao.FileDao;
import edu.zhku.dao.FolderDao;
import edu.zhku.domain.Folder;
import edu.zhku.service.FileService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@Service
@Transactional
public class FileServiceImpl implements FileService {
    @Autowired
    FileDao fileDao;
    @Autowired
    FolderDao folderDao;

    @Override
    public Folder findPage(String route) throws Exception {
        return fileDao.findPage(route);
    }

    @Override
    public Boolean upload(CommonsMultipartFile file, HttpServletRequest request, int pid, int uid, String... name) throws Exception {
        String newname = "";
        if (name[0] != null && name[1] != null) {
            newname = name[0] + "_" + name[1];
        } else if (name[0] != null) {
            newname = name[0];
        } else if (name[1] != null) {
            newname = name[1];
        }
        String flag = fileDao.addFileName(pid);
        String filename = file.getOriginalFilename();//初始文件名
        String tname = filename.substring(0, filename.lastIndexOf("."));
        System.out.println("tname" + tname);
        System.out.println(tname);
        if ("1".equals(flag)) {
            newname = newname + "_" + tname;
        } else {

        }
        System.out.println(newname);

        InputStream inputStream = null;
        try {
//            String path = request.getServletContext().getRealPath("/WEB-INF/upload/");
            String path = "C:/upload/" + uid + "/" + pid;
            System.out.println(path);
            File fdir = new File(path);
            if (!fdir.exists())
                fdir.mkdirs();
            inputStream = file.getInputStream();
            String newfilename = filename.replaceAll(filename.substring(0, filename.lastIndexOf(".")), newname);
            System.out.println(newfilename);
            File newfile = new File(fdir, newfilename);

            for (int i = 1; ;i++) {
                if (newfile.exists()) {
                    newfilename = newfilename.replace(newfilename.substring(0, newfilename.lastIndexOf(".")), newname + "(" + i + ")");
                    System.out.println(newfilename);
                    newfile = new File(fdir, newfilename);
                }else{
                    break;
                }
            }
            FileUtils.copyInputStreamToFile(inputStream, new File(fdir, newfilename));
            Date date = new Date();
            DateFormat df = DateFormat.getDateTimeInstance();
            System.out.println(df.format(date));
            String fileSize = String.format("%.2f", file.getSize() / 1024.0 / 1024) + "MB";
            fileDao.upload(pid, newfilename, fileSize, df.format(date), path + "/" + newfilename);
            folderDao.updateData(pid, df.format(date));
            if (inputStream != null) {
                inputStream.close();
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }

    @Override
    public List<edu.zhku.domain.File> findAll(String pid) throws Exception {
        return fileDao.findAll(pid);
    }

    @Override
    public void downloadFile(String fid, HttpServletResponse response) throws Exception {
        String path = fileDao.findPath(fid);
        File file = new File(path);
        System.out.println(file.getName());
        String name = URLEncoder.encode(file.getName(), "UTF-8");
        response.addHeader("content-disposition", "attachment;filename=" + name);
        FileUtils.copyFile(file, response.getOutputStream());

    }

    @Override
    public void removeFile(String fid, String pid) throws Exception {
        String path = fileDao.findPath(fid);
        File file = new File(path);
        file.delete();
        fileDao.removeFile(fid);
        folderDao.minusNum(pid);
    }

    @Override
    public boolean getZip(String[] fids, String title, HttpServletResponse response) throws Exception {
        List<String> paths = fileDao.findPaths(fids);
        System.out.println(paths.size());
        File zipFile = new File(title + ".zip");
        if (!zipFile.exists()) {
            zipFile.createNewFile();
        }
        String zipName = zipFile.getName();
        //title乱码
        zipName = new String(zipName.getBytes("ISO8859-1"), "UTF-8");
        System.out.println(zipName);
        response.addHeader("Content-disposition", "attachment;filename=" + zipName);
        ZipOutputStream zip = new ZipOutputStream(new FileOutputStream(zipFile));
        BufferedInputStream in = null;
        File file = null;
        for (int i = 0; i < paths.size(); i++) {
            System.out.println("文件路径:" + paths.get(i));
            file = new File(paths.get(i));
            String name = file.getName();
            System.out.println("文件的名字：" + name);
            ZipEntry zipEntry = new ZipEntry(name);
            zip.putNextEntry(zipEntry);
            in = new BufferedInputStream(new FileInputStream(file));
            int len = 0;
            byte[] btyes = new byte[1024 * 4];
            while ((len = in.read(btyes)) != -1) {
                zip.write(btyes, 0, len);
            }
        }
        zip.flush();
        zip.close();
        in.close();
        FileUtils.copyFile(zipFile, response.getOutputStream());
        if (zipFile.exists()) {
            if (zipFile.delete()) {
                System.out.println("压缩包删成功！！");
            } else {
                System.out.println("压缩包产出失败！！");
            }

        }
        return true;
    }

}
