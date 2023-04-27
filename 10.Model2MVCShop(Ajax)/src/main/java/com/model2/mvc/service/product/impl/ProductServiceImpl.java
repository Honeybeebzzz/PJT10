package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDAO;
import com.model2.mvc.service.product.ProductService;


//==> 상품관리 서비스 구현
@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService {
	
	
	//Field
	@Autowired
	@Qualifier("productDAOImpl")
	private ProductDAO productDAO;
	public void setProductDAO(ProductDAO productDAO) {
		this.productDAO= productDAO;
	}
	
	///Constructor
	public ProductServiceImpl() {
		System.out.println(this.getClass());
	}
	
	///Method

	public void addProduct(Product product) throws Exception {
		System.out.println("여기는 서비스 임쁠");
		productDAO.addProduct(product);
		System.out.println("여기는 서비스 임쁠22");
	}
	
	public Product getProduct(int product) throws Exception {
		return productDAO.getProduct(product);
	}

	public Map<String , Object > getProductList(Search search) throws Exception {
		List<Product> list= productDAO.getProductList(search);
		int totalCount = productDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	


	@Override
	public void updateProduct(Product product) throws Exception {
		productDAO.updateProduct(product);
	}




}//end of class
