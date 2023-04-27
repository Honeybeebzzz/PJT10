package com.model2.mvc.web.product;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


//==> 상품관리 Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
	
	///Constructor
	public ProductController(){
		System.out.println("ProductController 생성자");
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	//////////////////////////////////////////////////////////////
	//@RequestMapping("/addProductView.do")
	//public String addProductView() throws Exception {

	@RequestMapping( value="addProductView", method=RequestMethod.GET )
	public String addProductView() throws Exception {

		System.out.println("/product/addProductView: GET");
		
		return "forward:/product/addProductView.jsp";
	}
	
	
	//@RequestMapping("/addProduct.do")
	@RequestMapping( value="addProduct", method=RequestMethod.POST )
	public String addProduct(@ModelAttribute("product")Product product, @RequestParam("uploadFile") MultipartFile multipartFile) throws Exception{
		
		
		System.out.println("/product/addProduct : POST");
		
		String file = multipartFile.getOriginalFilename();
		
		file = System.currentTimeMillis()+"_"+file;
		product.setFileName(file);
		File saveFile = new File("C:\\Users\\weyla\\git\\PJT9\\09.Model2MVCShop(jQuery)\\src\\main\\webapp\\images\\uploadFiles",file);
		
		//tranNo="1" 판매중
		product.setProTranCode("1");
		
		productService.addProduct(product);
		multipartFile.transferTo(saveFile);
		
		return "forward:/product/addProduct.jsp";
		
	}
	//@RequestMapping("/getProduct.do")
	@RequestMapping( value="getProduct", method=RequestMethod.GET )
	public String getProduct( @RequestParam("prodNo") int prodNo , Model model, HttpServletRequest request ) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		if(request.getParameter("menu") != null) {
			String menu= request.getParameter("menu");
			System.out.println(menu);
			request.setAttribute("menu", menu);		
		}
		
		return "forward:/product/getProduct.jsp";
	}
	
	//@RequestMapping("/updateProductView.do")==> 수정하는 update
	@RequestMapping( value="updateProductView", method=RequestMethod.GET )
	public String updateProductView( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{

		System.out.println("==> 수정하는 update-->/product/updateProductView :GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/updateProductView.jsp";
	}
	
	//@RequestMapping("/updateProduct.do")==> 수정후 결과를 보여주는 update
	@RequestMapping( value="updateProduct", method=RequestMethod.POST )
	public String updateProduct( @ModelAttribute("product") Product product, Model model, HttpSession session,  @RequestParam("fileName2") MultipartFile multipartFile) throws Exception{

		System.out.println("수정후 결과를 보여주는 update update-->/product/updateProduct:POST");
		String file = multipartFile.getOriginalFilename();
		product.setFileName(file);
		//Business Logic
		productService.updateProduct(product);
		
		file = System.currentTimeMillis()+"_"+file;
		product.setFileName(file);
		
		File saveFile = new File("C:\\Users\\weyla\\git\\PJT9\\09.Model2MVCShop(jQuery)\\src\\main\\webapp\\images\\uploadFiles",file);
		
		multipartFile.transferTo(saveFile);
		
		return "forward:/product/updateProduct.jsp";
	}

	
	//@RequestMapping("/listProduct.do")
	@RequestMapping( value="listProduct" )
	public String listProduct( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/product/listProduct: GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map = productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}
}