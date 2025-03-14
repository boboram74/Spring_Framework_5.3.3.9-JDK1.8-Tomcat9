package com.kedu.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.FileDTO;

@Repository
public class FileDAO {

	@Autowired
	private SqlSession mybatis;

	public int insert(FileDTO dto) {
		 return mybatis.insert("File.insert", dto);
	}

	// parent_seq를 기준으로 파일 목록 조회
	public List<FileDTO> findBySeq(String parent_seq) {
		return mybatis.selectList("File.findBySeq", parent_seq);
	}
}