package com.model2.mvc.service.product;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

//==> 상품관리에서 CRUD 추상화/캡슐화한 DAO Interface Definition
//==> 데이터 베이스와 직접적인 통신을 담당하는 퍼시스턴스 계층을 담당할 인터페이스
public interface ProductDAO {
	
	// INSERT
	public void addProduct(Product product) throws Exception;
	// SELECT ONE
	public Product getProduct(int prodNo) throws Exception;
	// SELECT LIST
	public List<Product> getProductList(Search search) throws Exception;
	// UPDATE
	public void updateProduct(Product product) throws Exception;
	
	// 게시판 Page 처리를 위한 전체Row(totalCount)  return
	public int getTotalCount(Search search)throws Exception;

	
}
