$(function(){function i(){$(this).find(".preview").fadeIn()}function t(){$(this).find(".preview").fadeOut()}$(".gallery-container > li").hoverIntent({over:i,timeout:500,out:t,sensitivity:4}),setTimeout(function(){$(".gallery-container > li").each(function(){var i,t,e,n;i=$(this).find(".preview"),t=$(this).find("img"),e=t.width(),n=t.height(),i.css({width:e}),i.css({height:n}),i.addClass("ui-lightbox")})},500)});