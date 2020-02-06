package edu.zhku.dao;

import edu.zhku.domain.Folder;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface FolderDao {
    @Insert("insert into folder(uid,route,title,content,finput,sinput,tinput,deadline,model) values(#{uid},#{route},#{title},#{content},#{finput},#{sinput},#{tinput},#{deadline},#{model})")
    public void createFolder(Folder folder)throws Exception;

    @Select("select * from folder where uid=#{uid}")
    public List<Folder> findList(@Param("uid") int uid);

    @Update("update folder set pnum=pnum+1,time=#{time} where pid=#{pid}")
    public void updateData(@Param("pid") int pid,@Param("time")String time);

    @Update("update folder set pnum=pnum-1 where pid=#{pid}")
    public void minusNum(@Param("pid")String pid)throws Exception;

    @Update("update folder set deadline=#{deadline} where pid=#{pid}")
    public void changeTime(@Param("pid") String pid, @Param("deadline") String deadline)throws Exception;

    @Update("update folder set status=1,stopreason=#{reason} where pid=#{pid}")
    public void stopReason(@Param("pid") String pid, @Param("reason") String reason)throws Exception;

    @Update("update folder set status=0 where pid=#{pid}")
    public void restart(@Param("pid") String pid)throws Exception;

    @Select("select * from folder where pid=#{pid}")
    public Folder editPage(@Param("pid") String pid)throws Exception;

    @Update("update folder set title=#{title},content=#{content},finput=#{finput},sinput=#{sinput},tinput=#{tinput},deadline=#{deadline},model=#{model} where route=#{route}")
    public void updateFolder(Folder folder)throws Exception;

    @Delete("delete from folder where pid=#{pid}")
    public void deleteFolder(@Param("pid") String pid)throws Exception;

    @Update("update folder set status=1 where pid=#{pid}")
    public void stop(@Param("pid") String pid)throws Exception;

    @Select("select * from folder where uid=#{uid} order by deadline desc")
    public List<Folder> selectByTimeDesc(@Param("uid") String uid)throws Exception;

    @Select("select * from folder where uid=#{uid} order by deadline asc")
    public List<Folder> selectByTimeAsc(String uid)throws Exception;

    @Select("select * from folder where uid=#{uid} and model=#{model}")
    public List<Folder> findListByModel(@Param("model") String model, @Param("uid") String uid)throws Exception;

    @Select("select * from folder where uid=#{uid} and title like CONCAT('%',#{text},'%')")
    public List<Folder> searchFolder(@Param("uid") String uid, @Param("text") String text)throws Exception;
}
