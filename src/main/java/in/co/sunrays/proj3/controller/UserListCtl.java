package in.co.sunrays.proj3.controller;

import in.co.sunrays.project3.dto.BaseDTO;
import in.co.sunrays.project3.dto.UserDTO;
import in.co.sunrays.proj3.exception.ApplicationException;
import in.co.sunrays.proj3.model.ModelFactory;
import in.co.sunrays.proj3.model.UserModelInt;
import in.co.sunrays.proj3.util.DataUtility;
import in.co.sunrays.proj3.util.PropertyReader;
import in.co.sunrays.proj3.util.ServletUtility;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

/**
 * User List functionality Controller. Performs operation for list, search and
 * delete operations of User
 * 
 * @author SUNRAYS Technologies
 * @version 1.0
 * @Copyright (c) SUNRAYS Technologies
 */
@WebServlet(name = "UserListCtl", urlPatterns = "/ctl/UserListCtl")
public class UserListCtl extends BaseCtl {

	private static Logger log = Logger.getLogger(UserListCtl.class);

	protected BaseDTO populateDTO(HttpServletRequest request) {
		UserDTO dto = new UserDTO();

		dto.setRoleId(DataUtility.getInt(request.getParameter("roleId")));

		dto.setFirstName(DataUtility.getString(request.getParameter("firstName")));

		dto.setLoginId(DataUtility.getString(request.getParameter("loginId")));

		System.out.println(dto.getLoginId());

		return dto;
	}

	protected void preload(HttpServletRequest request) {
		try {
			List list = ModelFactory.getInstance().getRoleModel().list();
			request.setAttribute("rolList", list);
		} catch (ApplicationException e) {

			e.printStackTrace();

		}

	}

	/**
	 * View Logic
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		log.debug("UserListCtl doGet Start");
		System.out.println("UserListCtl doget");

		List list = null;

		int pageNo = DataUtility.getInt(request.getParameter("pageNo"));
		int pageSize = DataUtility.getInt(request.getParameter("pageSize"));

		pageNo = (pageNo == 0) ? 1 : pageNo;
		pageSize = (pageSize == 0) ? DataUtility.getInt(PropertyReader.getValue("page.size")) : pageSize;

		UserDTO dto = (UserDTO) populateDTO(request);

		String op = DataUtility.getString(request.getParameter("operation"));

		UserModelInt model = ModelFactory.getInstance().getUserModel();

		try {

			list = model.search(dto, pageNo, pageSize);

			ServletUtility.setList(list, request);
			if (list == null || list.size() == 0) {
				ServletUtility.setErrorMessage("No record found ", request);
			}
			ServletUtility.setList(list, request);
			ServletUtility.setPageNo(pageNo, request);
			ServletUtility.setPageSize(pageSize, request);
		} catch (ApplicationException e) {
			log.error(e);
			ServletUtility.handleException(e, request, response);
			return;
		}
		ServletUtility.forward(ORSView.USER_LIST_VIEW, request, response);

		log.debug("UserListCtl doGet End");
	}

	/**
	 * Submit Logic
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List list = null;

		int pageNo = DataUtility.getInt(request.getParameter("pageNo"));
		int pageSize = DataUtility.getInt(request.getParameter("pageSize"));

		String op = DataUtility.getString(request.getParameter("operation"));
		UserDTO dto = (UserDTO) populateDTO(request);
		pageNo = (pageNo == 0) ? 1 : pageNo;
		pageSize = (pageSize == 0) ? DataUtility.getInt(PropertyReader.getValue("page.size")) : pageSize;

		UserModelInt model = ModelFactory.getInstance().getUserModel();
		try {
			if (OP_RESET.equalsIgnoreCase(op)) {
				ServletUtility.redirect(ORSView.USER_LIST_CTL, request, response);
				return;
			}

			if (OP_SEARCH.equalsIgnoreCase(op) || "Next".equalsIgnoreCase(op) || "Previous".equalsIgnoreCase(op)) {

				if (OP_SEARCH.equalsIgnoreCase(op)) {
					pageNo = 1;
				} else if (OP_NEXT.equalsIgnoreCase(op)) {
					pageNo++;
				} else if (OP_PREVIOUS.equalsIgnoreCase(op) && pageNo > 1) {
					pageNo--;
				}

			} else if (OP_NEW.equalsIgnoreCase(op)) {
				ServletUtility.redirect(ORSView.USER_CTL, request, response);
				return;
			} else if (OP_DELETE.equalsIgnoreCase(op)) {
				pageNo = 1;
				// get the selected checkbox ids array for delete list
				String[] ids = request.getParameterValues("ids");
				if (ids != null && ids.length > 0) {
					UserDTO deletedDto = new UserDTO();
					for (String id : ids) {
						if("1".equalsIgnoreCase(id))
						{
							ServletUtility.setErrorMessage("Admin can't be deleted", request);
							break;
						}
						deletedDto.setId(DataUtility.getLong(id));
						model.delete(deletedDto);
						ServletUtility.setSuccessMessage("Data deleted successfully", request);
					}
				} else {
					
					ServletUtility.setErrorMessage("Select at least one record", request);
				}
			}

			list = model.search(dto, pageNo, pageSize);

			ServletUtility.setList(list, request);

			if (list == null || list.size() == 0 && !OP_DELETE.equalsIgnoreCase(op)) {
				ServletUtility.setErrorMessage("No record found ", request);
			}
			ServletUtility.setList(list, request);
			ServletUtility.setPageNo(pageNo, request);
			ServletUtility.setPageSize(pageSize, request);
			ServletUtility.forward(ORSView.USER_LIST_VIEW, request, response);

		} catch (ApplicationException e) {
			log.error(e);

			ServletUtility.handleException(e, request, response);
			return;
		}

	}

	protected String getView() {
		return ORSView.USER_LIST_VIEW;
	}

}
