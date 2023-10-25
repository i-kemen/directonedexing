package com.namhoon.di.dto;


import lombok.Data;

import java.time.LocalDate;
import java.util.Date;

@Data
public class KorTickerDTO {
    private String ticker;
    private String stockname;
    private String market;
    private Float closing;
    private Float cap;
    private Date bday;
    private Float eps;
    private Float leps;
    private Float bps;
    private Float dps;
    private String category;
}
