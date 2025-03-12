package com.kedu.dto;

import lombok.Setter;

import java.security.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
public class ReplyDTO {
	
	private int id;
	private String writer;
	private String content;
	private Timestamp write_date;
	private int parent_seq;

}
