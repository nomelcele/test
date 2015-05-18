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
		 * application names = ��浿-���϶�-��ȿ��
		 * split, StringTokenizer�� �߷��� ��ġ�� �� �־�� �Ѵ�.
		 * <kosta97>
			<team>
				<tname>������</tname>
				<name1>��浿</name1>
				<name2>���϶�</name2>
				<name3>��ȿ��</name3>
			</team>
			</kosta97>
			
			������Ʈ ��Ҵ� ����� �ϴ� ���� ����.
		 * */
		
		// db�κ��� �о���� ���� xml ������ ������ �۾�
		
		
		// root element �����
		Element root = new Element("kosta97");
		Element team = new Element("team");
		Element tname = new Element("tname");
		Element name1 = new Element("name1");
		Element name2 = new Element("name2");
		Element name3 = new Element("name3");
		
		// ���̺���� root, ������ �÷��� element
		
		// ---------------- while�� ó��
		tname.setText("������");
		name1.setText("��浿");
		name2.setText("���϶�");
		name3.setText("��ȿ��");

		// �Ӽ�
		Attribute att = new Attribute("tno", "ATeam");
		team.setAttribute(att);
		
		// ������ ��ġ
		team.addContent(tname);
		team.addContent(name1);
		team.addContent(name2);
		team.addContent(name3);
		root.addContent(team);
		// ----------------- while�� ó��
		
		// ���� ��ü ����
		Document doc = new Document();
		doc.setRootElement(root);
		
		XMLOutputter xo = new XMLOutputter();
		Format f = xo.getFormat();
		f.setEncoding("euc-kr"); // �ѱ� ó��
		f.setIndent(" "); // �鿩����
		f.setLineSeparator("\r\n"); // ���� ó��(�� �ٲ�)
		f.setTextMode(TextMode.TRIM); // ���� ���� �ٹٲ� ����
		// ������ �����ͷ� ó���Ǵ� ���� �����ش�.
		xo.setFormat(f); // ������ xo ��ü�� �ʱ�ȭ
		try {
			xo.output(doc, System.out);
			xo.output(doc, new FileOutputStream("src/xmltest/mytest2.xml"));
			// /�� \\�� ����
		} catch (IOException e) {
			e.printStackTrace();
		} // ���
		
	}
	
}
