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
		// 문서 객체를 뽑아내기 위해서 JDOM 라이브러리에서 SAXBuilder를 생성한다.
		SAXBuilder builder = new SAXBuilder();
		try {
			URL url = new URL("http://192.168.7.178/jspFinal_0508_15/book.xml");
			// url의 내용 읽어오기
			
			/*
			BufferedInputStream bis = new BufferedInputStream(url.openStream());
			File file = new File("src/xmltest/mybooks.xml");
		
			// 읽어온 내용 파일에 쓰기
			FileOutputStream fos = new FileOutputStream(file);
			// BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(file));
			
			int res = 0;
			while((res = bis.read()) != -1){
				fos.write(res);
			}
			
			fos.close();
			bis.close();
			*/
			
			
			// xml 문서를 읽어와서 Document 객체를 생성
			// build에는 url도 들어갈 수 있다.
			Document doc = builder.build(url);
			System.out.println(doc);
			
			// 최상위 rootElement를 Element 객체로 반환 - xml을 읽기 위한 환경 시작
			Element root = doc.getRootElement();
			System.out.println("rootName: "+root.getName());
			// root로부터 자식 element를 읽어들인다. 기사, 기사
			List<Element> child = root.getChildren();
			
			for(Element el : child){
				// 기사의 자식
				List<Element> ch = el.getChildren();
				System.out.println(ch.size());
				for(Element e: ch){
					// 엘리먼트 이름
					System.out.println("<"+e.getName()+">");
					// 엘리먼트가 가진 값
					System.out.println(e.getText());
					
					// 자식 엘리먼트가 있을 때
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
			// url에서 읽어온 xml 파일을 실제로 생성하기 위해서 필요한 객체
			Format f = xo.getFormat();
			// jdom에서 제공하는 format 객체
			f.setEncoding("euc-kr"); // 한글 처리
			f.setIndent(" "); // 들여쓰기(인자에 들어간 만큼만 들여쓰기가 된다)
			f.setLineSeparator("\r\n"); // 개행 처리(행 바꿈)
			f.setTextMode(TextMode.TRIM); // 문자 형식 줄바꿈 해제
			// 공백이 데이터로 인식되는 것을 막아준다.
			xo.setFormat(f); // 설정을 xo 객체에 초기화
			xo.output(doc, System.out); // 출력
			// 위의 코드는 콘솔에서 출력
			xo.output(doc, new FileOutputStream("src/xmltest/mytest.xml"));
			// doc을 해당 경로의 파일에 쓴다.
			// /와 \\는 같음
		} catch (JDOMException | IOException e) {
			e.printStackTrace();
		} 
		
	}

}
