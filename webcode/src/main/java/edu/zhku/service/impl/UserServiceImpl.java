package edu.zhku.service.impl;

import com.github.pagehelper.PageHelper;
import edu.zhku.dao.UserDao;
import edu.zhku.domain.Folder;
import edu.zhku.domain.User;
import edu.zhku.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UserServiceImpl implements UserService {
    @Autowired
    UserDao userDao;

    @Override
    public boolean findEmail(String email) throws Exception {
        return userDao.findEmail(email) == null?true:false;
    }
    @Override
    public boolean findName(String name) throws Exception {
        return userDao.findName(name) == null?true:false;
    }

    @Override
    public String login(String account, String pwd) throws Exception {
        return userDao.login(account,pwd);
    }

    @Override
    public List<Folder> findMyPage(String uid,int page,int size) throws Exception {
        PageHelper.startPage(page, size);
        return userDao.findMyPage(uid);
    }

    @Override
    public User findUser(String uid) throws Exception {
        return userDao.findUser(uid);
    }

    @Override
    public boolean findOldPwd(String uid, String oldpwd) throws Exception {
        return userDao.findOldPwd(uid,oldpwd);
    }

    @Override
    public void changePwd(String uid, String newpwd) throws Exception {
        userDao.changePwd(Integer.parseInt(uid),newpwd);
    }

    @Override
    public void sendEmail(String email) throws Exception {

    }

    @Override
    public void addUser(String email, String name, String pwd, String pwd2)throws Exception{
        userDao.addUser(email,name,pwd,pwd2);
    }


}
