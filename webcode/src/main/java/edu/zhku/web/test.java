package edu.zhku.web;

public class test {
    public static void main(String[] args) {
        String str = "哈哈哈(1).jpg";
        String s = "哈哈哈(1).jpg";
        String name = "哈哈哈";
        for (int i = 1; ;i++) {
           if(s.equals(str)){
               String t = s.substring(0,s.lastIndexOf("."));
               System.out.println(t);
               String q = name+"("+i+")";
               System.out.println(q);
               s = s.replace(t,q);
               System.out.println(s);
           }else{
               break;
           }
        }
    }
}