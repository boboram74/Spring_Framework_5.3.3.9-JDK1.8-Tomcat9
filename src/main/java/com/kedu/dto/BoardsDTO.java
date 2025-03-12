package com.kedu.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BoardsDTO {
	private int seq;
	private String title;
	private String writer;
	private String contents;
	private Timestamp write_date;
	private int view_count;
}
