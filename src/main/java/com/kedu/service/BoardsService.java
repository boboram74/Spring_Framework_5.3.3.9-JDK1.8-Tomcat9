package com.kedu.service;

import com.kedu.dao.BoardsDAO;
import com.kedu.dao.FileDAO;
import com.kedu.dao.MembersDAO;
import com.kedu.dto.BoardsDTO;
import com.kedu.dto.FileDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import utils.Statics;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class BoardsService {

    @Autowired
    private MembersDAO membersDAO;

    @Autowired
    private FileDAO fileDAO;

    @Autowired
    private BoardsDAO boardsDAO;

    public void viewCountUp(int id) {
        boardsDAO.viewCountUp(id);
    }

    public BoardsDTO selectById(int id) {
        return boardsDAO.selectById(id);
    }

    public int updateById(BoardsDTO dto) {
        return  boardsDAO.updateById(dto);
    }

    public int deleteById(int id) {
        return boardsDAO.deleteById(id);
    }

    public int createById(BoardsDTO dto) {
        return  boardsDAO.createById(dto);
    }

    @Transactional
    public int insert(BoardsDTO dto,String realPath, MultipartFile[] files,int parent_seq) throws  Exception {
        File realPathFile = new File(realPath);
        if(!realPathFile.exists()) realPathFile.mkdir();
        int insertFileCount = 0;
        for(MultipartFile file : files) { //여러개의 경우
            if(!file.isEmpty()) { //파일의 내용이 있을경우만 실행
                String oriName = file.getOriginalFilename(); //업로드 한 이름
                String sysName = UUID.randomUUID() + "_"+ oriName; //서버에 저장될 이름
                file.transferTo(new File(realPath+"/"+sysName));
                insertFileCount += fileDAO.insert(new FileDTO(0, oriName, sysName, parent_seq));
            }
        }
        return insertFileCount;
    }

    public int getRecordTotalCount() {
        return boardsDAO.getRecordTotalCount();
    }

    public List<BoardsDTO> selectFromto(int start, int end) {
        return boardsDAO.selectFromto(start, end);
    }
    public Map<String, Object> getPagedBoardList(int cpage) {
        int recordTotalCount = this.getRecordTotalCount();

        int pageTotalCount = (recordTotalCount % Statics.recordCountPerPage > 0)
                ? recordTotalCount / Statics.recordCountPerPage + 1
                : recordTotalCount / Statics.recordCountPerPage;
        if (cpage < 1) cpage = 1;
        else if (cpage > pageTotalCount) cpage = pageTotalCount;
        int end = cpage * Statics.recordCountPerPage;
        int start = end - (Statics.recordCountPerPage - 1);
        int startNavi = (cpage - 1) / Statics.naaviCountPerPage * Statics.naaviCountPerPage + 1;
        int endNavi = startNavi + Statics.naaviCountPerPage - 1;
        if (endNavi > pageTotalCount) endNavi = pageTotalCount;
        boolean needPrev = startNavi != 1;
        boolean needNext = endNavi != pageTotalCount;
        List<BoardsDTO> list = this.selectFromto(start, end);
        Map<String, Object> result = new HashMap<>();
        result.put("startNavi", startNavi);
        result.put("endNavi", endNavi);
        result.put("needPrev", needPrev);
        result.put("needNext", needNext);
        result.put("list", list);
        return result;
    }
}
