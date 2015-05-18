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

// xml�� �о���δ�. 
// (�ʿ��� ��ü: SaxBuilder, URL, Document, Element, ArrayList�� ���� Collection)
// ������� �˻�� �м��ؼ� xml�� �ڽ� ����� ���� ��ġ�� ������ ã�Ƽ� ������� �Ѵ�.
public class Suggest {
	private static Suggest suggest;
	private Document doc;
	private Element root;

	public static synchronized Suggest getSuggest() {
		if(suggest == null) suggest = new Suggest();
		return suggest;
	}
	
	private Suggest(){
		SAXBuilder sb = new SAXBuilder(); // xml ������ �а� �����κ��� element�� �б� ����
		String path = "http://192.168.7.178/jspFinal_0508_15/suggest.xml";
		try {
			doc = sb.build(new URL(path));
			root = doc.getRootElement();
		} catch (JDOMException | IOException e) {
			e.printStackTrace();
		} 
	}

	// �ʿ��� ���� ���� �޼���
	public String[] getSuggest(String key){
		// key: �˻����� ���� ��(����ڰ� �Է��� ��)
		ArrayList<String> sugList = new ArrayList<String>();
		List<Element> list = root.getChildren("keyword");
		// root�� children�� keyword�� �ƴ� �ٸ� element�� ���� ���
		// �� �޼���� keyword element�� ����
		System.out.println("Key: "+key);
		Iterator<Element> it = list.iterator();
		
		key = key.toLowerCase(); // String�� �ҹ��ڷ�
		while(it.hasNext()){ // �÷��ǿ������� element�� �̾ƿ´�.
			// �ݺ��ڰ� ��ġ�� ���� ���� ĭ�� ��Ұ� ������ true�� ����
			String result = it.next().getText(); 
			// ���ڿ�(pcdata)�� ������ ���� �޼���
			String compare = result.toLowerCase();
			// ����ڰ� �Է��� key�� ���ϱ� ���ؼ� compare�� �ҹ��ڷ� ��ȯ���ش�.
			
			// ����ڰ� �Է��� ������ �����ϴ� �������� �Ǻ��ϰ� �ʹٸ�?
			if(compare.startsWith(key)){
				sugList.add(result);
			}
		}
		
		int sugSize = sugList.size();
		if(sugSize > 0){
			// ArrayList�� �迭�� ��ȯ
			String[] sugArr = new String[sugSize];
			// �÷����� �迭�� ��ȯ���ִ� �޼���
			// sugList(�÷���) -> sugArr(�迭)
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
