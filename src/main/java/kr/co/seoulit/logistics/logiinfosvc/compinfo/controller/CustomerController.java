package kr.co.seoulit.logistics.logiinfosvc.compinfo.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import kr.co.seoulit.logistics.logiinfosvc.compinfo.service.CompInfoService;
import kr.co.seoulit.logistics.logiinfosvc.compinfo.to.CustomerTO;

@RestController
@RequestMapping("/compinfo/*")
public class CustomerController {

	@Autowired
	private CompInfoService compInfoService;
	
	ModelMap map = null;

	// GSON 라이브러리
	private static Gson gson = new GsonBuilder().serializeNulls().create(); // 속성값이 null 인 속성도 JSON 변환

	@RequestMapping(value = "/customer/list", method=RequestMethod.GET)
	public ModelMap searchCustomerList(HttpServletRequest request, HttpServletResponse response) {
		String searchCondition = request.getParameter("searchCondition");
		String companyCode = request.getParameter("companyCode");
		String workplaceCode = request.getParameter("workplaceCode");
		String itemGroupCode = request.getParameter("itemGroupCode");
		map = new ModelMap();
		ArrayList<CustomerTO> customerList = null;
		try {
			customerList = compInfoService.getCustomerList(searchCondition, companyCode, workplaceCode,itemGroupCode);
	
			map.put("gridRowJson", customerList);
			map.put("errorCode", 1);
			map.put("errorMsg", "성공!");
		} catch (Exception e1) {
			e1.printStackTrace();
			map.put("errorCode", -1);
			map.put("errorMsg", e1.getMessage());
		} 
		return map;
	}

	@RequestMapping(value = "/customer/batch", method=RequestMethod.POST)
	public ModelMap batchListProcess(HttpServletRequest request, HttpServletResponse response) {
		String batchList = request.getParameter("batchList");
		map = new ModelMap();
		try {
			ArrayList<CustomerTO> customerList = gson.fromJson(batchList, new TypeToken<ArrayList<CustomerTO>>() {
			}.getType());
			HashMap<String, Object> resultMap = compInfoService.batchCustomerListProcess(customerList);
	
			map.put("result", resultMap);
			map.put("errorCode", 1);
			map.put("errorMsg", "성공!");
		} catch (Exception e1) {
			e1.printStackTrace();
			map.put("errorCode", -1);
			map.put("errorMsg", e1.getMessage());
		} 
		return map;
	}
	@RequestMapping(value = "/customer/allList", method = RequestMethod.GET)
	public ModelMap findCustomerList() {
		map = new ModelMap();
		ArrayList<CustomerTO> list = compInfoService.findCustomerList();
		map.put("customer", list);
		System.out.println(list);
		return map;
	}

	@RequestMapping(value = "/customer/registerAccount", method = RequestMethod.POST)
	public ModelMap registerAccount(HttpServletRequest request) {
		ModelMap map = new ModelMap();
		String toList = request.getParameter("toList");
		ArrayList<CustomerTO> cto_list = gson.fromJson(toList,new TypeToken<ArrayList<CustomerTO>>() {}.getType());
		// gson을 쓰는 이유는 넘어오는 값들을 하나하나 담아주기 위함이라고함 분석필요 ㅠ

		// System.out.println("test : "+cto_list.get(0).getCustomerName());
		compInfoService.registerCustomer(cto_list);
		return map;
	}

}
