package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.FileDTO;

@Repository
public class FileDAO {
	
	@Autowired
	private JdbcTemplate jdbc;

	public int insert(FileDTO dto) {
		String sql = "insert into files values(files_seq.nextval, ?, ?, ?)";
		return this.jdbc.update(sql, dto.getOriName(), dto.getSysName(), dto.getParent_seq());
	}
	public List<FileDTO> findBySeq(String parent_seq) {
		String sql = "select * from files where parent_seq = ?";
		return jdbc.query(sql, new BeanPropertyRowMapper<FileDTO>(FileDTO.class),parent_seq);
	}
}