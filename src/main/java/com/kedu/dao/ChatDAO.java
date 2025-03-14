package com.kedu.dao;

import com.kedu.dto.ChatDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ChatDAO {
    @Autowired
    private SqlSession mybatis;
    public int insert(ChatDTO dto) {
        return mybatis.insert("Chat.insert",dto);
    }

    public List<ChatDTO> selectAll() {
        return mybatis.selectList("Chat.selectAll");
    }
}