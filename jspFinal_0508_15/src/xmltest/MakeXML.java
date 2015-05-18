package xmltest;

import java.io.FileOutputStream;
import java.io.IOException;

import org.jdom2.Attribute;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;
import org.jdom2.output.Format.TextMode;

public class MakeXML {
	public static void main(String[] args) {
		/* --- select tname, name1, name2, name3 from t
		 * ex) select tname, names from team;
		 * application names = 김길동-구하라-소효진
		 * split, StringTokenizer로 추려서 배치할 수 있어야 한다.
		 * <kosta97>
			<team>
				<tname>해피조</tname>
				<name1>김길동</name1>
				<name2>구하라</name2>
				<name3>소효진</name3>
			</team>
			</kosta97>
			
			엘리먼트 요소는 영어로 하는 것이 좋다.
		 * */
		
		// db로부터 읽어들인 값을 xml 문서로 보내는 작업
		
		
		// root element 만들기
		Element root = new Element("kosta97");
		Element team = new Element("team");
		Element tname = new Element("tname");
		Element name1 = new Element("name1");
		Element name2 = new Element("name2");
		Element name3 = new Element("name3");
		
		// 테이블명이 root, 각각의 컬럼은 element
		
		// ---------------- while문 처리
		tname.setText("해피조");
		name1.setText("김길동");
		name2.setText("구하라");
		name3.setText("소효진");

		// 속성
		Attribute att = new Attribute("tno", "ATeam");
		team.setAttribute(att);
		
		// 구조적 배치
		team.addContent(tname);
		team.addContent(name1);
		team.addContent(name2);
		team.addContent(name3);
		root.addContent(team);
		// ----------------- while문 처리
		
		// 문서 객체 생성
		Document doc = new Document();
		doc.setRootElement(root);
		
		XMLOutputter xo = new XMLOutputter();
		Format f = xo.getFormat();
		f.setEncoding("euc-kr"); // 한글 처리
		f.setIndent(" "); // 들여쓰기
		f.setLineSeparator("\r\n"); // 개행 처리(행 바꿈)
		f.setTextMode(TextMode.TRIM); // 문자 형식 줄바꿈 해제
		// 공백이 데이터로 처리되는 것을 막아준다.
		xo.setFormat(f); // 설정을 xo 객체에 초기화
		try {
			xo.output(doc, System.out);
			xo.output(doc, new FileOutputStream("src/xmltest/mytest2.xml"));
			// /와 \\는 같음
		} catch (IOException e) {
			e.printStackTrace();
		} // 출력
		
	}
	
}
