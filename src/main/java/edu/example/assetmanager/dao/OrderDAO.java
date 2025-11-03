package edu.example.assetmanager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import edu.example.assetmanager.domain.OrderContentDTO;
import edu.example.assetmanager.domain.OrderDTO;
import edu.example.assetmanager.domain.OrderFormDTO;
import edu.example.assetmanager.domain.OrderParamDTO;

@Mapper
public interface OrderDAO {
	// 페이징을 위한 모든 자산 개수
	public int countAll(OrderParamDTO orderParamDTO);
	public int countAllForAdmin(OrderParamDTO orderParamDTO);
	public int countAllForManager(OrderParamDTO orderParamDTO);
	public List<OrderDTO> listAll(OrderParamDTO orderParamDTO);
	public List<OrderDTO> listAllForAdmin(OrderParamDTO orderParamDTO);
	public List<OrderDTO> listAllForManager(OrderParamDTO orderParamDTO);
    public int insertOrder(OrderFormDTO orderFormDTO); 
    public int insertOrderContent(OrderContentDTO content);
    public OrderDTO getOrderById(int id);
    public List<OrderContentDTO> getContentsByOrderId(int id);
    public boolean cancelOrder(int id);

}
