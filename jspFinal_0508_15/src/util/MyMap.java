package util;

import java.util.Enumeration;
import java.util.HashMap;


import java.util.Map;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;

public class MyMap {
	private static MyMap maps;
	public static synchronized MyMap getMaps() {
		if(maps == null) maps = new MyMap();
		return maps;
	}
public HashMap<String, String> getMapList(HttpServletRequest request){
	// ��û�� request��ü�� ���� �Ķ���Ͱ��� �ڵ����� ��� ���� ���ؼ�
	//getParameterNames()����ؼ� ���� �Ķ���� �̸����� 
	//Enumeration���� �����Ѵ�.
		Enumeration<String> params = request.getParameterNames();
		 HashMap<String, String> parms = new HashMap<>();
	      String parmName;
	      String parmValue;
	      // �̸��� Enumeration���� �ϳ��� �����鼭 HashMap��
	      // �̸��� ������ �����Ѵ�.
	     while (params.hasMoreElements())
	      {
	         parmName = params.nextElement();
	         parmValue = request.getParameter(parmName);
	         parms.put(parmName, parmValue);
	      }
	     System.out.println("�ڵ� �Ķ���� �ޱ� ���� : --------");
	      for(Map.Entry<String, String> e : parms.entrySet()){
	    	  System.out.println(e.getKey()+":"+e.getValue());
	      }
	      System.out.println("�ڵ� �Ķ���� �ޱ� �� : --------");
	      return parms;
	}

// ��Ƽ��Ʈ�ϰ�� ���Ͼ��ε� ���� 3.0 ����� ������ �ڵ� �Ķ���� �ޱ� ����

public HashMap<String, String> getMapList(){
	return null;
}




}
