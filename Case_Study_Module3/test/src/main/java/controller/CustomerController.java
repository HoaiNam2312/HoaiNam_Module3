package controller;

import model.customer.Customer;
import service.customer.CustomerService;
import service.customer.ICustomerService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CustomerController", value = "/CustomerController")
public class CustomerController extends HttpServlet {
    ICustomerService customerService = new CustomerService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null){
            action ="";
        }
        switch (action){
            case "create" :
//                showCreateForm(request,response);
                break;
            case "update":
//                showUpdateForm(request,response);
                break;
            case "delete":
                int id = Integer.parseInt(request.getParameter("id"));
                customerService.delete(id);
//                listCustomer(request,response);
                break;

            default:
                listCustomer(request,response);
        }
    }

    private void listCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Customer> customerList = customerService.findAll();
        request.setAttribute("cusList", customerList);
        request.getRequestDispatcher("view/customer/list.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
