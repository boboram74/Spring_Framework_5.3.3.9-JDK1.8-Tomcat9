package com.kedu.controller;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.dao.FileDAO;
import com.kedu.dto.FileDTO;

@Controller
@RequestMapping("/files")
public class FileController {
	
	@Autowired
	private FileDAO fileDAO;
	
	@ResponseBody
	@GetMapping("/list") //출력
	public List<FileDTO> list(String parent_seq) throws Exception {
		List<FileDTO> list = fileDAO.findBySeq(parent_seq);
		Map<String, Object> dto = new HashMap<String, Object>();
		dto.put("list", list);
		return list;
	}
	@GetMapping("/download") //다운로드
	public void download(String sysName, String oriName, HttpServletResponse response, HttpSession session) throws Exception {
		String realPath = session.getServletContext().getRealPath("upload");
		File target = new File(realPath + "/"+ sysName);
		
		oriName = new String(oriName.getBytes("utf8"),"ISO-8859-1");
		response.setHeader("content-disposition", "attachment;filename=\""+oriName+"\""); //dispatcher에게 첨부파일임을 명시
		
		try(DataInputStream dis = new DataInputStream(new FileInputStream(target));
			DataOutputStream dos = new DataOutputStream(response.getOutputStream())) {
			byte[] fileContents = dis.readAllBytes();
			dos.write(fileContents);
			dos.flush();
		}
	}
}