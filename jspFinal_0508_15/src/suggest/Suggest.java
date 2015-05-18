package suggest;

import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;

// xml을 읽어들인다. 
// (필요한 객체: SaxBuilder, URL, Document, Element, ArrayList와 같은 Collection)
// 사용자의 검색어를 분석해서 xml의 자식 요소의 값과 일치한 값들을 찾아서 돌려줘야 한다.
public class Suggest {
	private static Suggest suggest;
	private Document doc;
	private Element root;

	public static synchronized Suggest getSuggest() {
		if(suggest == null) suggest = new Suggest();
		return suggest;
	}
	
	private Suggest(){
		SAXBuilder sb = new SAXBuilder(); // xml 문서를 읽고 문서로부터 element를 읽기 위해
		String path = "http://192.168.7.178/jspFinal_0508_15/suggest.xml";
		try {
			doc = sb.build(new URL(path));
			root = doc.getRootElement();
		} catch (JDOMException | IOException e) {
			e.printStackTrace();
		} 
	}

	// 필요한 값을 얻어내는 메서드
	public String[] getSuggest(String key){
		// key: 검색으로 들어온 값(사용자가 입력한 값)
		ArrayList<String> sugList = new ArrayList<String>();
		List<Element> list = root.getChildren("keyword");
		// root의 children중 keyword가 아닌 다른 element가 있을 경우
		// 이 메서드는 keyword element만 리턴
		System.out.println("Key: "+key);
		Iterator<Element> it = list.iterator();
		
		key = key.toLowerCase(); // String을 소문자로
		while(it.hasNext()){ // 컬렉션에서부터 element를 뽑아온다.
			// 반복자가 위치한 곳에 다음 칸에 요소가 있으면 true를 리턴
			String result = it.next().getText(); 
			// 문자열(pcdata)을 얻어오기 위한 메서드
			String compare = result.toLowerCase();
			// 사용자가 입력한 key와 비교하기 위해서 compare도 소문자로 변환해준다.
			
			// 사용자가 입력한 값으로 시작하는 것인지를 판별하고 싶다면?
			if(compare.startsWith(key)){
				sugList.add(result);
			}
		}
		
		int sugSize = sugList.size();
		if(sugSize > 0){
			// ArrayList를 배열로 변환
			String[] sugArr = new String[sugSize];
			// 컬렉션을 배열로 변환해주는 메서드
			// sugList(컬렉션) -> sugArr(배열)
			return sugList.toArray(sugArr);
		}
		
		return null;
	}
	
	public static void main(String[] args) {
		Suggest su = new Suggest();
		String[] re = su.getSuggest("j");
		for(String e: re){
			System.out.println(e);
		}
	}
}
