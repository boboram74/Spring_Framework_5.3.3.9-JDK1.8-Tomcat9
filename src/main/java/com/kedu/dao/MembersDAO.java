package com.kedu.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kedu.dto.MembersDTO;

@Repository
public class MembersDAO {

	@Autowired
	private JdbcTemplate jdbc;
	
	public int insert(MembersDTO dto) {
		String sql = "insert into members values(?, ?, ?, ?, ?)";
		return this.jdbc.update(sql, dto.getId(), dto.getPw(), dto.getName(), dto.getContact(), dto.getProfile_image());
	}	
	
	public List<MembersDTO> selectAll() {
		String sql = "select * from members";
		return jdbc.query(sql, new RowMapper<MembersDTO>() {
			@Override
			public MembersDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				MembersDTO dto = new MembersDTO();
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));				
				dto.setName(rs.getString("name"));
				dto.setContact(rs.getString("contact"));
				return dto;
			}
		});
	}
	
	public int selectById3(String id) { // 꺼낸 값이 DTO 타입이 아닐때
		String sql = "select count(*) from members";
		return jdbc.queryForObject(sql, Integer.class);
	}
	
	public int updateById(MembersDTO dto) throws Exception { //Update
		String sql = "update members set name =?, contact=? where id = ?";
		return this.jdbc.update(sql, dto.getName(), dto.getContact(), dto.getId());
	}	
	
	public int deleteById(String id) { //Delete
		String sql = "delete from members where id = ?";
		return jdbc.update(sql, id);
	}
	
	public boolean checkDuplicateId(String id) {
        String sql = "select count(*) from members where id = ?";
        int result = jdbc.queryForObject(sql, Integer.class, id);
        return result > 0;
	}

	public MembersDTO login(String id, String pw) {
	    String sql = "select * from members where id = ? and pw = ?";
	    try {
	        return jdbc.queryForObject(sql, new BeanPropertyRowMapper<>(MembersDTO.class), id, pw);
	    } catch (Exception e) {
	        return null;
	    }
	}


	public MembersDTO selectById(String id) { // DTO와 컬럼 이름이 다를 때
		String sql = "select * from members where id = ?";
		return jdbc.queryForObject(sql, new RowMapper<MembersDTO>() {
			@Override
			public MembersDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				MembersDTO dto = new MembersDTO();
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setContact(rs.getString("contact"));
				return dto;
			}
		}, id);
	}
}