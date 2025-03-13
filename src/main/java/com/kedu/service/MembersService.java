package com.kedu.service;

import com.kedu.dao.FileDAO;
import com.kedu.dao.MembersDAO;
import com.kedu.dto.MembersDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import utils.Encryption;

import java.io.File;
import java.util.UUID;

@Service
public class MembersService {

    @Autowired
    private MembersDAO memberDAO;

    @Autowired
    private FileDAO fileDAO;
    public int insert(MembersDTO dto, String realPath, MultipartFile file) throws  Exception {
        dto.setPw(Encryption.encrypt(dto.getPw()));
        File realPathFile = new File(realPath);
        if(!realPathFile.exists()) realPathFile.mkdir();
        if(!file.isEmpty()) {
            String oriName = file.getOriginalFilename();
            String sysName = UUID.randomUUID() + "_"+ oriName;
            file.transferTo(new File(realPath+"/"+sysName));
            dto.setProfile_image(sysName);
        }
        return memberDAO.insert(dto);
    }

    public boolean checkDuplicateId(String id) {
        return memberDAO.checkDuplicateId(id);
    }

    public MembersDTO selectById(String id) {
        return memberDAO.selectById(id);
    }

    public MembersDTO login(String id, String pw) {
        String rePw = Encryption.encrypt(pw);
        return memberDAO.login(id,rePw);
    }

    public int deleteById(String id) {
        return  memberDAO.deleteById(id);
    }
}