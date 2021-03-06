<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
</head>
<body class="cart">

	<header id="layout-header">
		<div class="clearfix container">
			<a href="/" id="logo"> <!-- <img src="http://cdn.shopify.com/s/files/1/0155/7645/t/177/assets/casa-do-codigo-blue.svg?58522" alt="Casa do Codigo"> -->
			</a>
			<div id="header-content">
				<nav id="main-nav">
					<ul class="clearfix">

						<li><a href="${spring:mvcUrl('SCC#items').build()}"
							rel="nofollow">Seu carrinho(${shoppingCart.quantity}-R$
								${shoppingCart.total}) </a></li>
					</ul>
				</nav>
			</div>
		</div>
	</header>


	<section class="container middle">

		<h2 id="cart-title">Seu carrinho de compras</h2>

		<table id="cart-table">
			<colgroup>
				<col class="item-col">
				<col class="item-price-col">
				<col class="item-quantity-col">
				<col class="line-price-col">
				<col class="delete-col">
			</colgroup>
			<thead>
				<tr>
					<th class="cart-img-col"></th>
					<th width="65%">Item</th>
					<th width="10%">Preço</th>
					<th width="10%">Quantidade</th>
					<th width="10%">Total</th>
					<th width="5%"></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${shoppingCart.list}" var="item">
					<tr>
						<td class="cart-img-col"><img src=""
							alt="${item.product.title}" /></td>
						<td class="item-title">${item.product.title}-
							${item.bookType}</td>
						<td class="numeric-cell">${item.price}</td>
						<td class="quantity-input-cell"><input type="number" min="0"
							readonly="readonly" value="${shoppingCart.getQuantity(item)}"></td>
						<td class="numeric-cell">${shoppingCart.getTotal(item)}</td>
						<td class="remove-item"><form method="post"
								action="${spring:mvcUrl('SCC#remove').arg(0,item.product.id).arg(1,item.bookType).build()}">
								<input type="image"
									src="//cdn.shopify.com/s/files/1/0155/7645/t/177/assets/excluir.png?58522"
									alt="Excluir" title="Excluir" />
							</form></td>
					</tr>
				</c:forEach>

			</tbody>
			<tfoot>
				<tr>
					<td colspan="2"><form
							action="${spring:mvcUrl('PC#checkout').build()}" method="post">
							<input type="submit" class="checkout" name="checkout"
								value="Finalizar compra " id="checkout" />
						</form></td>
					<td class="numeric-cell">${shoppingCart.total}</td>
					<td></td>
				</tr>
			</tfoot>
		</table>

	</section>

	<footer id="layout-footer"> </footer>


	<script>
		$(function() {
			$('#checkout').click(function() {
				_gaq.push([ '_trackPageview', '/checkout/finalizaCompra' ]);
			});
			$('.book-suggest').click(function() {
				var book = $(this).data('book');
				_gaq.push([ '_trackEvent', 'Recomendação', 'Livro', book ]);
			});
		});
	</script>

	<noscript>
		<img height="1" width="1" alt="" style="display: none"
			src="https://www.facebook.com/offsite_event.php?id=6009930053200&amp;value=0&amp;currency=USD" />
	</noscript>

	<script>
		$(function() {
			$('a[href^="http"]').not('.dont-track').filter(function(index) {
				var ccb = $(this).attr('href').indexOf("casadocodigo.com.br");
				if (ccb == -1)
					ccb = $(this).attr('href').indexOf("localhost");
				return ccb != 7 && ccb != 11;
			}).click(function(event) {
				var domain = this.href;
				domain = domain.substring(7);
				domain = domain.substring(0, domain.indexOf('/'));
				if (domain.substring(0, 4) == 'www.')
					domain = domain.substring(4);

				_gaq.push([ '_trackPageview', '/LinkExterno/' + this.href ]);
			});
		});
	</script>
</body>
</html>