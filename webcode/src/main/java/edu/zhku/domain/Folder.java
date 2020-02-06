package edu.zhku.domain;

import java.util.Date;

public class Folder {
    private Integer pid;
    private Integer uid;
    private String route;
    private String title;
    private String content;
    private String finput;
    private String sinput;
    private String tinput;
    private String deadline;
    private String ppassword;
    private Integer pnum;
    private Integer status;
    private String stopreason;
    private String time;
    private String model;

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getRoute() {
        return route;
    }

    public void setRoute(String route) {
        this.route = route;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getFinput() {
        return finput;
    }

    public void setFinput(String finput) {
        this.finput = finput;
    }

    public String getSinput() {
        return sinput;
    }

    public void setSinput(String sinput) {
        this.sinput = sinput;
    }

    public String getTinput() {
        return tinput;
    }

    public void setTinput(String tinput) {
        this.tinput = tinput;
    }

    public String getDeadline() {
        return deadline;
    }

    public void setDeadline(String deadline) {
        this.deadline = deadline;
    }

    public String getPpassword() {
        return ppassword;
    }

    public void setPpassword(String ppassword) {
        this.ppassword = ppassword;
    }

    public Integer getPnum() {
        return pnum;
    }

    public void setPnum(Integer pnum) {
        this.pnum = pnum;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getStopreason() {
        return stopreason;
    }

    public void setStopreason(String stopreason) {
        this.stopreason = stopreason;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    @Override
    public String toString() {
        return "Folder{" +
                "pid=" + pid +
                ", uid=" + uid +
                ", route='" + route + '\'' +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", finput='" + finput + '\'' +
                ", sinput='" + sinput + '\'' +
                ", tinput='" + tinput + '\'' +
                ", deadline='" + deadline + '\'' +
                ", ppassword='" + ppassword + '\'' +
                ", pnum=" + pnum +
                ", status=" + status +
                ", stopreason='" + stopreason + '\'' +
                ", time='" + time + '\'' +
                ", model='" + model + '\'' +
                '}';
    }
}
