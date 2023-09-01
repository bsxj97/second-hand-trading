package com.daowen.service;

import com.daowen.vo.SearchVo;

import java.util.List;

public interface ISiteSearch {

   List<SearchVo> search(String text);
}
