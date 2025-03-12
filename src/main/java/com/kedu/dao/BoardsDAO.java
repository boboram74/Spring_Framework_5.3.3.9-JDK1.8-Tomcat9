package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.BoardsDTO;
@Repository
public class BoardsDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public int createById(BoardsDTO dto) {
		String sql = "insert into board (seq, title, writer, contents, write_date, view_count)"
				+ "values (?, ?, ?, ?, sysdate, 0)";
		return this.jdbc.update(sql, dto.getSeq(), dto.getTitle(), dto.getWriter(), dto.getContents());
	}
	
	public List<BoardsDTO> selectAll() { 
		String sql = "select * from board order by seq desc";
		return jdbc.query(sql, new BeanPropertyRowMapper<>(BoardsDTO.class));
	}
	
	public int getSeq() {
		String sql = "select board_seq.nextval from dual";
		return jdbc.queryForObject(sql, Integer.class);
	}
	
	public int getRecordTotalCount() {
		String sql = "select count(*) from board";
		return jdbc.queryForObject(sql, Integer.class);
	}
	
	public List<BoardsDTO> selectFromto(int start, int end){
		String sql = "SELECT * FROM ( SELECT board.*, ROW_NUMBER() "
				+ "OVER (ORDER BY seq DESC) AS rnum FROM board ) "
				+ "WHERE rnum BETWEEN ? AND ?";
		return jdbc.query(sql, new BeanPropertyRowMapper<>(BoardsDTO.class),start, end);
	}

	public BoardsDTO selectById(int id) {
		String sql = "select * from board where seq = ?";
		return jdbc.queryForObject(sql, new BeanPropertyRowMapper<BoardsDTO>(BoardsDTO.class),id);
	}

	public int updateById(BoardsDTO dto) {
		String sql = "update board set title = ?, contents = ? where seq = ?";
		return this.jdbc.update(sql, dto.getTitle(), dto.getContents(), dto.getSeq());
	}

	public int deleteById(int id) {
		String sql = "delete from board WHERE seq = ?";
		return jdbc.update(sql, id);
	}

	public void viewCountUp(int id) {
		String sql = "update board set view_count = view_count + 1 where seq = ?";
		jdbc.update(sql, id);
	}
}
