package dto;

import util.Util;

public class Member {
	public final static int NOT_EXIST = -31;	// 그 아이디는 존재하지 않는다.
	
	public static int getNotExist() {
		return NOT_EXIST;
	}

	private String ID = "";
	private String name = "";
	private String password = "";
	private String tel = "";
	private String email = "";
	private int point = 0;
	private String createDate = "";
	

	public void print(String head) {
		System.out.println( "[Member.java] " + head + "-----");
		System.out.println("ID: " + ID);
		System.out.println("name: " + name);
		System.out.println("password: " + password);
		System.out.println("tel:" + tel);
		System.out.println("email: " + email);
		System.out.println("point: " + point);
		System.out.println("createDate: " + createDate);
		System.out.println( "[Member.java] END -----");		
	}
	public String getID() {
		return ID;
	}

	public void setID(String id) {
		ID = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	public String getCreateDateWithDelimiter() {

		return Util.addDelimiterToStringDate( createDate);
	}
}
