package br.com.casadocodigo.loja.controllers;

import java.io.Serializable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import br.com.casadocodigo.loja.daos.ProdutoDAO;
import br.com.casadocodigo.loja.models.CarrinhoCompras;
import br.com.casadocodigo.loja.models.CarrinhoItem;
import br.com.casadocodigo.loja.models.Produto;
import br.com.casadocodigo.loja.models.TipoPreco;

@Controller
@RequestMapping("/carrinho")

/* Escopo:
 * 		SCOPE_APPLICATION = É o default do spring. Este escopo é da aplicação, ou seja, qualquer usuário tem
 * 							acesso aos mesmos dados 
 * 		SCOPE_REQUEST =  Este escopo dura apenas na requisição.
 * 		SCOPE_SESSION =  Este escopo dura enquanto o browser do usuário esteja aberto.
 * */
@Scope(value=WebApplicationContext.SCOPE_REQUEST)
public class CarrinhoController implements Serializable{
	
	private static final long serialVersionUID = 1L;

	@Autowired
	private ProdutoDAO produtoDAO;
	
	@Autowired
	private CarrinhoCompras carrinho;
	
	@RequestMapping(name="carrinhoAdd", value="/add")
	public ModelAndView add(Integer idProduto,TipoPreco tipoPreco){
		ModelAndView mv = new ModelAndView("redirect:/carrinho");
		
		Produto produto = produtoDAO.buscaPorId(idProduto); 
		
		CarrinhoItem carrinhoItem = new CarrinhoItem(produto, tipoPreco);
		
		carrinho.add(carrinhoItem);
		
		return mv ;
	}
	
	@RequestMapping(value="remover", method=RequestMethod.POST)
	public ModelAndView remover(Integer produtoId, TipoPreco tipoPreco){
		carrinho.remover(produtoId, tipoPreco);
		ModelAndView mv = new ModelAndView("redirect:/carrinho");
		return mv;
	}
	
	@RequestMapping(name="carrinhoItens", method=RequestMethod.GET)
	public ModelAndView itens(){
		ModelAndView mv = new ModelAndView("carrinho/itens");
		return mv;
	}

}
