package controller;

import model.*;
import service.employee.PhongTroService;
import service.employee.IPhongTroService;
import service.employee.division.DivisionService;
import service.employee.division.IDivisionService;
import service.employee.education_degree.EducationDegreeService;
import service.employee.education_degree.IEducationDegreeService;
import service.employee.position.IPositionService;
import service.employee.position.PositionService;
import service.employee.user.IUserService;
import service.employee.user.UserService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "TrangChuController", value = "/employee")
public class PhongTroController extends HttpServlet {
    IPhongTroService employeeService = new PhongTroService();
    IPositionService positionService = new PositionService();
    IEducationDegreeService educationDegreeService = new EducationDegreeService();
    IDivisionService divisionService = new DivisionService();
    IUserService userService = new UserService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null){
            action ="";
        }
        switch (action){
            case "create" :
                showCreateForm(request,response);
                break;
            case "update":
                showUpdateForm(request,response);
                break;
            default:
                listPhongTro(request,response);
        }
    }

    private void showUpdateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Employee employee = employeeService.findById(id);
        request.setAttribute("employee", employee);
        request.setAttribute("positionList",positionService.findAll());
        request.setAttribute("educationDegreeList",educationDegreeService.findAll());
        request.setAttribute("divisionList",divisionService.findAll());
        request.setAttribute("userList",userService.findAll());
        request.getRequestDispatcher("update.jsp").forward(request,response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Position> positionList = positionService.findAll();
        List<EducationDegree> educationDegreeList = educationDegreeService.findAll();
        List<Division> divisionList = divisionService.findAll();
        List<User> userList = userService.findAll();
        request.setAttribute("positionList",positionList);
        request.setAttribute("educationDegreeList",educationDegreeList);
        request.setAttribute("divisionList",divisionList);
        request.setAttribute("userList",userList);
        request.getRequestDispatcher("create.jsp").forward(request,response);
    }

    private void listPhongTro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Employee> employeeList = employeeService.findAll();
        request.setAttribute("empList", employeeList);
        request.getRequestDispatcher("list.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null){
            action ="";
        }

        switch (action){
            case "create":
                createCustomer(request,response);
                break;
            case "update":
                update(request,response);
                break;
            case "search":
                search(request, response);
                break;
            case "delete":
                delete(request, response);
                break;
            default:
                listPhongTro(request,response);
        }
    }

    private void createCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String[] temp = request.getParameter("birthday").split("-");
        String birthday = null;
        try {
            birthday = String.join("-", temp[2], temp[1], temp[0]);
        } catch (Exception e) {
            e.printStackTrace();
        }
        double salary = Double.parseDouble(request.getParameter("salary"));
        String id_card = request.getParameter("idCard");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        Position position = new Position(Integer.parseInt(request.getParameter("positionId")));
        EducationDegree educationDegree = new EducationDegree(Integer.parseInt(request.getParameter("educationDegreeId")));
        Division division = new Division(Integer.parseInt(request.getParameter("divisionId")));
        User user = new User(request.getParameter("username"));
        Employee employee = new Employee(name, birthday, id_card,salary, phone, email, address,position,educationDegree,division,user);
        employeeService.add(employee);
        request.setAttribute("message", "Thêm mới thành công");
        showCreateForm(request,response);
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String[] temp = request.getParameter("birthday").split("-");
        String birthday = null;
        try {
            birthday = String.join("-", temp[2], temp[1], temp[0]);
        } catch (Exception e) {
            e.printStackTrace();
        }
        String idCard = request.getParameter("idCard");
        double salary = Double.parseDouble(request.getParameter("idCard"));
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        Position position = new Position(Integer.parseInt(request.getParameter("position")));
        EducationDegree educationDegree = new EducationDegree(Integer.parseInt(request.getParameter("education")));
        Division division = new Division(Integer.parseInt(request.getParameter("division")));
        User user = new User(request.getParameter("username"));
        Employee employee = new Employee(id, name, birthday, idCard, salary, phone, email, address, position, educationDegree, division, user);
        if (employeeService.update(employee)) {
            request.setAttribute("message", "Update thành công");
            showUpdateForm(request,response);
        }
    }

    private void search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        List<Employee> employeeList = employeeService.search(name, email, address);
        request.setAttribute("empList", employeeList);
        request.getRequestDispatcher("view/employee/list.jsp").forward(request,response);
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("idDelete"));
        employeeService.delete(id);
        listPhongTro(request,response);
    }
}
