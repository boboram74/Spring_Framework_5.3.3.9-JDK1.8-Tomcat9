package com.kedu.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kedu.dto.MembersDTO;

@Repository
public class MembersDAO {

	@Autowired
	private SqlSession mybatis;
	
	public int insert(MembersDTO dto) {
		return mybatis.insert("Member.insert", dto);
	}

	public List<MembersDTO> selectAll() {
		return mybatis.selectList("Member.selectAll");
	}
	public int deleteById(String id) { //Delete
		return mybatis.delete("Member.deleteById", id);
	}
	public boolean checkDuplicateId(String id) {
		int result = mybatis.selectOne("Member.checkDuplicateId",id);
		return result > 0;
	}
	public MembersDTO login(String id, String pw) {
		Map<String, Object> params = new HashMap<>();
		params.put("id", id);
		params.put("pw", pw);
		try {
			return mybatis.selectOne("Member.login", params);
		} catch (Exception e) {
			return null;
		}
	}

	public MembersDTO selectById(String id) {
		return mybatis.selectOne("Member.selectById", id);
	}
}