package edu.zhku.service;

import edu.zhku.domain.Folder;
import edu.zhku.domain.User;

import java.util.List;

public interface UserService {

    public boolean findEmail(String email)throws Exception;

    public void addUser(String email, String name, String pwd, String pwd2)throws Exception;

    public boolean findName(String name)throws Exception;

    public String login(String account, String pwd)throws Exception;

    public List<Folder> findMyPage(String uid,int page,int size)throws Exception;

    public User findUser(String uid)throws Exception;

    public boolean findOldPwd(String uid, String oldpwd)throws Exception;

    public void changePwd(String uid, String newpwd)throws Exception;

    public void sendEmail(String email)throws Exception;
}
