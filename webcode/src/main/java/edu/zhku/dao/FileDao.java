package edu.zhku.dao;

import edu.zhku.domain.File;
import edu.zhku.domain.Folder;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface FileDao {

    @Select("select * from folder where route=#{route}")
    public Folder findPage(@Param("route") String route)throws Exception;
    @Insert("insert into file(pid,fname,fsize,ftime,path) values(#{pid},#{fname},#{fsize},#{ftime},#{path})")
    public void upload(@Param("pid") int pid, @Param("fname")String newfilename, @Param("fsize")String size, @Param("ftime")String time, @Param("path")String path);

    @Select("select * from file where pid=#{pid}")
    public List<File> findAll(@Param("pid") String pid)throws Exception;

    @Select("select path from file where fid=#{fid}")
    public String findPath(@Param("fid") String fid)throws Exception;

    @Delete("delete from file where fid=#{fid}")
    public void removeFile(@Param("fid") String fid)throws Exception;

    @Select({
            "<script>",
            "select",
            "path",
            "from file",
            "where fid in",
            "<foreach collection='fids' item='fid' open='(' separator=',' close=')'>",
            "#{fid}",
            "</foreach>",
            "</script>"
    })
    public List<String> findPaths(@Param("fids") String[] fids)throws Exception;

    @Delete("delete from file where pid=#{pid}")
    public void deleteFileByPid(String pid)throws Exception;

    @Select("select tinput from folder where pid=#{pid}")
    public String addFileName(@Param("pid") int pid)throws Exception;
}
