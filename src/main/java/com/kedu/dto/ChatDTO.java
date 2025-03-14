package com.kedu.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
public class ChatDTO {
    private String writer;
    private String contents;
    private Timestamp write_date;
}