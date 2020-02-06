package edu.zhku.uitl;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;

import sun.misc.BASE64Encoder;

public class CharacterUtil {
	public static String getName(HttpServletRequest request,String name) throws Exception {
		String agent = request.getHeader("User-Agent");
		String filenameEncoder = "";
		if (agent.contains("MSIE")) {
			filenameEncoder = URLEncoder.encode(name, "utf-8");
			filenameEncoder = filenameEncoder.replace("+", " ");
		} else if (agent.contains("Firefox")) {
			BASE64Encoder base64Encoder = new BASE64Encoder();
			filenameEncoder = "=?utf-8?B?" + base64Encoder.encode(name.getBytes("utf-8")) + "?=";
		} else {
			filenameEncoder = URLEncoder.encode(name, "utf-8");
		}
		System.out.println(filenameEncoder);
		return filenameEncoder;
	}
}
