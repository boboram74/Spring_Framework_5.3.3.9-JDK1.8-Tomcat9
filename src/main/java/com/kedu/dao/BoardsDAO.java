package com.kedu.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.BoardsDTO;
@Repository
public class BoardsDAO {

	@Autowired
	private SqlSession mybatis;

	public int createById(BoardsDTO dto) {
		mybatis.insert("Boards.createById", dto);
		return dto.getSeq();
	}

	public List<BoardsDTO> selectAll() {
		return mybatis.selectList("Boards.selectAll");
	}

	public int getRecordTotalCount() {
		return mybatis.selectOne("Boards.getRecordTotalCount");
	}

	public List<BoardsDTO> selectFromto(int start, int end) {
		Map<String, Object> param = new HashMap<>();
		param.put("start", start);
		param.put("end", end);
		return mybatis.selectList("Boards.selectFromto", param);
	}

	public BoardsDTO selectById(int id) {
		return mybatis.selectOne("Boards.selectById", id);
	}

	public int updateById(BoardsDTO dto) {
		return mybatis.update("Boards.updateById", dto);
	}

	public int deleteById(int id) {
		return mybatis.delete("Boards.deleteById", id);
	}
	public void viewCountUp(int id) {
		mybatis.update("Boards.viewCountUp", id);
	}
}