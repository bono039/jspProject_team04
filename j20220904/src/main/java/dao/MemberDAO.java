package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.MemberDTO;

public class MemberDAO {
	private static MemberDAO instance;
	
	private MemberDAO() {}
	
	public static MemberDAO getInstance() {
		if(instance == null) {
			instance = new MemberDAO();
		}
		
		return instance;
	}
	
	// DBCP
	public Connection getConnection() {
		Connection conn = null;
		
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return conn;
	}
	
	// 회원 1명 조회하는 메서드
	public MemberDTO selectMember(String mem_id) {
		Connection conn = getConnection();
		
		String sql = "select * from member where mem_id=?";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDTO memberDTO = new MemberDTO();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mem_id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				memberDTO.setMem_id(rs.getString("mem_id"));
				memberDTO.setMem_name(rs.getString("mem_name"));
				memberDTO.setMem_pwd(rs.getString("mem_pwd"));
				memberDTO.setMem_email1(rs.getString("mem_email1"));
				memberDTO.setMem_email2(rs.getString("mem_email2"));
				memberDTO.setMem_tel(rs.getString("mem_tel"));
				memberDTO.setMem_zipcode(rs.getString("mem_zipcode"));
				memberDTO.setMem_addr1(rs.getString("mem_addr1"));
				memberDTO.setMem_addr2(rs.getString("mem_addr2"));
				memberDTO.setMem_rogDate(new Date(rs.getDate(10).getTime()));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		
		return memberDTO;
	}
	
	// 회원가입 메서드
	public int insertMember(MemberDTO memberDTO) {
		Connection conn = getConnection();
		
		String sql = "insert into member values (?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
		
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberDTO.getMem_id());		// 아이디
			pstmt.setString(2, memberDTO.getMem_name());	// 이름
			pstmt.setString(3, memberDTO.getMem_pwd());		// 비밀번호
			pstmt.setString(4, memberDTO.getMem_email1());	// 이메일1
			pstmt.setString(5, memberDTO.getMem_email2());	// 이메일2
			pstmt.setString(6, memberDTO.getMem_tel());		// 휴대폰 번호
			pstmt.setString(7, memberDTO.getMem_zipcode());	// 우편번호
			pstmt.setString(8, memberDTO.getMem_addr1());	// 주소
			pstmt.setString(9, memberDTO.getMem_addr2());	// 상세주소
			
			result = pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt, conn);
		}
		
		return result;
	}
	
	// 이메일 확인을 위해 일치하는 멤버들 가져오는 메서드
	public List<MemberDTO> findIdMember(String mem_name, String email1, String email2) {
		Connection conn = getConnection();
		
		String sql = "select * from member where mem_name = ? and mem_email1=? and mem_email2=?";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MemberDTO> list = new ArrayList<>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mem_name);
			pstmt.setString(2, email1);
			pstmt.setString(3, email2);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				do {
					MemberDTO memberDTO = new MemberDTO();
					
					memberDTO.setMem_id(rs.getString("mem_id"));
					memberDTO.setMem_name(rs.getString("mem_name"));
					memberDTO.setMem_pwd(rs.getString("mem_pwd"));
					memberDTO.setMem_email1(rs.getString("mem_email1"));
					memberDTO.setMem_email2(rs.getString("mem_email2"));
					memberDTO.setMem_tel(rs.getString("mem_tel"));
					memberDTO.setMem_zipcode(rs.getString("mem_zipcode"));
					memberDTO.setMem_addr1(rs.getString("mem_addr1"));
					memberDTO.setMem_addr2(rs.getString("mem_addr2"));
					memberDTO.setMem_rogDate(new Date(rs.getDate(10).getTime()));
					
					list.add(memberDTO);
				} while(rs.next());
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		return list;
	}
	
	// 비밀번호 재설정 메서드
	public int updatePwd(String mem_id, String mem_pwd) {
		Connection conn = getConnection();
		
		String sql = "update member set mem_pwd = ? where mem_id = ?";
		
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mem_pwd);
			pstmt.setString(2, mem_id);
			
			result = pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt, conn);
		}
		
		return result;
	}
	
	// 회원정보 변경 메서드 (이메일, 휴대폰 번호, 주소만 바뀜)
	public int update(MemberDTO memberDTO) {
		Connection conn = getConnection();
		
		String sql = "update member set mem_email1 = ?, mem_email2 = ?, mem_tel = ?, mem_zipcode=?, mem_addr1=?, mem_addr2=? "
				+ "where mem_id = ?";
		
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberDTO.getMem_email1());
			pstmt.setString(2, memberDTO.getMem_email2());
			pstmt.setString(3, memberDTO.getMem_tel());
			pstmt.setString(4, memberDTO.getMem_zipcode());
			pstmt.setString(5, memberDTO.getMem_addr1());
			pstmt.setString(6, memberDTO.getMem_addr2());
			pstmt.setString(7, memberDTO.getMem_id());
			
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt, conn);
		}
		
		return result;
	}
	
	//close하는 메서드
	private void close(AutoCloseable... ac) {
		try {
			for(AutoCloseable a : ac) {
				if(a != null) {
					a.close();
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	

	
}
