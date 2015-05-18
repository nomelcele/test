/**
 * 
 */
function imgChange(){
		$("#targetIcon").click(function(){
			$("#iconView").show();
		});
		
		$(".subIcon").click(function(){
			$("#targetIcon").attr("src",$(this).attr("src"));
			$("#resIcon").val($(this).attr("src"));
			$("#iconView").hide();
			
		});
			
		$("#sub").click(function(){
			$("#commF").submit();
		});
	}