package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.BestSellerAction;
import action.CartInsertAction;
import action.ItemDeleteProAction;
import action.ItemModifyFormAction;
import action.ItemModifyproAction;
import action.ItemRecentAction;
import action.ItemRegisterProAction;
import action.ItemSingleAction;
import action.RecommendListAction;
import action.ConfirmCheckoutProAction;
import action.ShopMainAction;
import vo.ActionForward;

@WebServlet("*.em")
public class ItemFrontController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		String requestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = requestURI.substring(contextPath.length());
//		System.out.println(requestURI + " " + contextPath +  " " + command);
		
		Action action = null;
		ActionForward forward = null;
		
		// 주영
		if(command.equals("/shopMain.em")) { // DB단에 가서 item들을 select 해야 함 Redirect
//			System.out.println("shopMain.em");
			action = new ShopMainAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		} else if (command.equals("/recommendList.em")) { // DB 단에 가서 해당 item의 정보를 가져와야 함 Redirect
//			System.out.println("recommendList");
			action = new RecommendListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else if (command.equals("/itemRecent.em")) { // DB 단에 가서 해당 item의 정보를 가져와야 함 Redirect
//          System.out.println("itemRecent.em");
            action = new ItemRecentAction();
            try {
                forward = action.execute(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
            
        } else if (command.equals("/itemSingle.em")) { // DB 단에 가서 해당 item의 정보를 가져와야 함 Redirect
//			System.out.println("itemSingle");
			action = new ItemSingleAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		// 기홍
		} else if (command.equals("/itemRegister.em")) { // 등록 페이지로 바로 가면 됨 Dispatch
//			System.out.println("itemRegister");
			forward = new ActionForward();
			forward.setPath("./shop/product-register.jsp");
			
		// 기홍
		} else if (command.equals("/itemRegisterPro.em")) { // 등록 페이지 Pro
//			System.out.println("itemRegisterPro");
			action = new ItemRegisterProAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		// 미송
		} else if (command.equals("/itemModify.em")) { // DB 단에 가서 해당 아이템의 정보를 가져와야 함 Redirect
//			System.out.println("itemModify");
			
			action = (Action) new ItemModifyFormAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				System.out.println("itemModify 실패"+ e.getMessage());
			}
			
		// 미송
		} else if (command.equals("/itemModifyPro.em")) { // 아이템 수정 Pro
//			System.out.println("itemModifyPro");
			
			action = (Action) new ItemModifyproAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				System.out.println("itemModifyPro 실패"+ e.getMessage());
			}
		
		// 영비
		} else if(command.equals("/itemDeleteForm.em")) {
//		     System.out.println("itemDeleteForm--");
		     forward = new ActionForward();
		     forward.setPath("./shop/product-delete.jsp");
		// 영비     
		} else if (command.equals("/itemDeletePro.em")) {
//		     System.out.println("itemDeletePro");
		          
		     action = (Action) new ItemDeleteProAction();
		          
		     try {
		    	 forward = action.execute(request, response);
		     } catch (Exception e) {
		    	 System.out.println("controller-itemDeletePro 실패"+ e.getMessage());
		    	 System.out.println("controller- 에러:"+e);
		     }
		         
	    } 
		//else if (command.equals("/itemView.em")) { // 빅데이터 관련한 관리자 페이지 [???]
//			System.out.println("itemDeleteForm--");
//			forward = new ActionForward();
//			forward.setPath("./shop/product-delete.jsp");
//			
//		}
	
		if(forward != null) {
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			}else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				
				dispatcher.forward(request, response);
			}
			
		}
		
	}

}
