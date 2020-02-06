package edu.zhku.dao;

import edu.zhku.domain.Folder;
import edu.zhku.domain.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface UserDao {
    /**
     * 注册用户
     */
    @Insert("Insert into user(uemail,uname,upassword) values(#{email},#{name},#{pwd})")
    public void addUser(@Param("email") String email, @Param("name")String name, @Param("pwd")String pwd, String pwd2)throws Exception;

    @Select("select * from user where uemail=#{email}")
    public Boolean findEmail(String email)throws Exception;

    @Select("select * from user where uname=#{name}")
    public Boolean findName(@Param("name") String name);

    @Select("select uid from user where uemail=#{name} and upassword=#{pwd} or uname=#{name} and upassword=#{pwd}")
    public String login(@Param("name") String account, @Param("pwd") String pwd);

    @Select("select * from folder where uid=#{uid}")
    public List<Folder> findMyPage(@Param("uid") String uid)throws Exception;

    @Select("select * from user where uid=#{uid}")
    public User findUser(@Param("uid") String uid)throws Exception;

    @Select("select * from user where uid=#{uid} and upassword=#{pwd}")
    public boolean findOldPwd(@Param("uid") String uid, @Param("pwd") String oldpwd)throws Exception;

    @Select("update user set upassword=#{pwd} where uid=#{uid}")
    public void changePwd(@Param("uid")int uid, @Param("pwd")String newpwd)throws Exception;

}
