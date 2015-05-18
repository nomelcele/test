package xmltest;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.List;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;
import org.jdom2.output.Format;
import org.jdom2.output.Format.TextMode;
import org.jdom2.output.XMLOutputter;

public class TestXML {
	public static void main(String[] args){
		// ���� ��ü�� �̾Ƴ��� ���ؼ� JDOM ���̺귯������ SAXBuilder�� �����Ѵ�.
		SAXBuilder builder = new SAXBuilder();
		try {
			URL url = new URL("http://192.168.7.178/jspFinal_0508_15/book.xml");
			// url�� ���� �о����
			
			/*
			BufferedInputStream bis = new BufferedInputStream(url.openStream());
			File file = new File("src/xmltest/mybooks.xml");
		
			// �о�� ���� ���Ͽ� ����
			FileOutputStream fos = new FileOutputStream(file);
			// BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(file));
			
			int res = 0;
			while((res = bis.read()) != -1){
				fos.write(res);
			}
			
			fos.close();
			bis.close();
			*/
			
			
			// xml ������ �о�ͼ� Document ��ü�� ����
			// build���� url�� �� �� �ִ�.
			Document doc = builder.build(url);
			System.out.println(doc);
			
			// �ֻ��� rootElement�� Element ��ü�� ��ȯ - xml�� �б� ���� ȯ�� ����
			Element root = doc.getRootElement();
			System.out.println("rootName: "+root.getName());
			// root�κ��� �ڽ� element�� �о���δ�. ���, ���
			List<Element> child = root.getChildren();
			
			for(Element el : child){
				// ����� �ڽ�
				List<Element> ch = el.getChildren();
				System.out.println(ch.size());
				for(Element e: ch){
					// ������Ʈ �̸�
					System.out.println("<"+e.getName()+">");
					// ������Ʈ�� ���� ��
					System.out.println(e.getText());
					
					// �ڽ� ������Ʈ�� ���� ��
					if(e.getChildren() != null){
						List<Element> ch2 = e.getChildren();
						for(Element e2: ch2){
							System.out.println("<"+e2.getName()+">");
							System.out.println(e2.getText());
						}
					}
					
				}
				System.out.println("----------");
			}
			
			XMLOutputter xo = new XMLOutputter();
			// url���� �о�� xml ������ ������ �����ϱ� ���ؼ� �ʿ��� ��ü
			Format f = xo.getFormat();
			// jdom���� �����ϴ� format ��ü
			f.setEncoding("euc-kr"); // �ѱ� ó��
			f.setIndent(" "); // �鿩����(���ڿ� �� ��ŭ�� �鿩���Ⱑ �ȴ�)
			f.setLineSeparator("\r\n"); // ���� ó��(�� �ٲ�)
			f.setTextMode(TextMode.TRIM); // ���� ���� �ٹٲ� ����
			// ������ �����ͷ� �νĵǴ� ���� �����ش�.
			xo.setFormat(f); // ������ xo ��ü�� �ʱ�ȭ
			xo.output(doc, System.out); // ���
			// ���� �ڵ�� �ֿܼ��� ���
			xo.output(doc, new FileOutputStream("src/xmltest/mytest.xml"));
			// doc�� �ش� ����� ���Ͽ� ����.
			// /�� \\�� ����
		} catch (JDOMException | IOException e) {
			e.printStackTrace();
		} 
		
	}

}
