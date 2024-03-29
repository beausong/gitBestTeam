package action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.w3c.dom.events.MutationEvent;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import svc.ItemRegisterProService;
import vo.ActionForward;
import vo.ItemBean;

public class ItemRegisterProAction implements Action {
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		if (id == null || !id.equals("admin") ) {
			out.println("<script>");
			out.println("alert('잘못된 접근입니다.')");
			out.println("location.href='index.in'");
			out.println("</script>");
			return null;
		} 
		
		ItemBean itemBean = null;
		
		// 톰캣(이클립스) 상의 가상의 경로
		String saveFolder = "/itemUpload"; 

		// 실제 경로 : 파일이 저장될 서버의 경로 
		// ex) String realFolder = "D:/Projects/workspace/projectName/WebContent/itemUpload";
		String realFolder = request.getServletContext().getRealPath(saveFolder); 
//		String realFolder; // 실제 경로
//		ServletContext context = request.getServletContext();
//		realFolder = context.getRealPath(saveFolder);
		
		// 파일 사이즈 (5MB = 5 * 1024 * 1024)
		int fileSize = 5 * 1024 * 1024; 
		
//		Path newDirectory = Paths.get(realFolder);
//        
//        try {
//            Path createDirResult = Files.createDirectories(newDirectory);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
		

		// MultipartRequest multi = new MultipartRequest(request 객체, 저장될 서버 경로, 파일 최대 크기, 인코딩 방식, 같은 이름의 파일명 방지 처리)
		MultipartRequest multi = new MultipartRequest(request, realFolder, fileSize, "UTF-8", new DefaultFileRenamePolicy());

		
		//--- 데이터 DB 저장 ---//
		
		Enumeration files = multi.getFileNames();
		
		String file = (String)files.nextElement();
		String filename = multi.getFilesystemName(file);
		
		String file2 = (String)files.nextElement();
		String filename2 = multi.getFilesystemName(file2);
		
		itemBean = new ItemBean();
		
		itemBean.setItem_name(multi.getParameter("item_name"));
		itemBean.setItem_price(Integer.parseInt(multi.getParameter("item_price")));
		itemBean.setItem_img(filename2);
		itemBean.setItem_info(multi.getParameter("item_info"));
		itemBean.setItem_amount(Integer.parseInt(multi.getParameter("item_amount")));
		itemBean.setItem_content(filename);
		itemBean.setItem_favor_aroma(Integer.parseInt(multi.getParameter("item_favor_aroma")));
		itemBean.setItem_favor_acidity(Integer.parseInt(multi.getParameter("item_favor_acidity")));
		itemBean.setItem_favor_sweetness(Integer.parseInt(multi.getParameter("item_favor_sweetness")));
		itemBean.setItem_favor_bitterness(Integer.parseInt(multi.getParameter("item_favor_bitterness")));
		itemBean.setItem_favor_body(Integer.parseInt(multi.getParameter("item_favor_body")));
		
		ItemRegisterProService itemRegisterProService = new ItemRegisterProService();
		boolean isRegistSuccess = itemRegisterProService.registItem(itemBean);
		
		if(!isRegistSuccess) {
			out.println("<script>"); // 자바스크립트 시작 태그
			out.println("alert('게시물 등록 실패!')"); // 오류 메세지 다이얼로그 표시
			out.println("history.back()"); // 이전 페이지로 돌아가기
			out.println("</script>"); // 자바스크립트 종료 태그
		} else {
			// => boardList.bo 페이지로 이동하면서 주소가 변경되므로(새로운 요청이 발생하므로) Redirect 방식으로 포워딩
			
			forward = new ActionForward();
			forward.setPath("shopMain.em");
			forward.setRedirect(true);
		}
		
		return forward;
	}
}
