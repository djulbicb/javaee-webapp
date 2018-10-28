package servlet;

import db.HibernateUtil;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

@WebServlet(name = "Users", urlPatterns = {"/users"})
public class Users extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        if (request.getSession().getAttribute("uuid") != null && request.getParameter("form_id") != null) {

            String form_id = request.getParameter("form_id");

            System.out.println("------------------------------" + request.getSession().getAttribute("uuid"));
            System.out.println("------------------------------" + form_id);

            if (form_id.equals(request.getSession().getAttribute("uuid").toString())) {
                request.getSession().setAttribute("uuid", null);

                Session currentSession = HibernateUtil.getSessionFactory().getCurrentSession();
                Transaction tx = currentSession.beginTransaction();
                try {
                    // ADD USER
                    if (request.getParameter("add") != null) {

                        String first_name = request.getParameter("first_name");
                        String last_surname = request.getParameter("last_surname");
                        String password = request.getParameter("password");
                        String status = request.getParameter("status");
                        String username = request.getParameter("username");

                        if (first_name != null && last_surname != null && password != null && status != null && username != null) {
                            if (!first_name.trim().isEmpty() && !last_surname.trim().isEmpty() && !password.trim().isEmpty() && !status.trim().isEmpty() && !username.trim().isEmpty()) {
                                User u = new User();
                                u.setCreatedAt(new Date());
                                u.setFirstName(first_name);
                                u.setLastSurname(last_surname);
                                u.setPassword(password);
                                u.setStatus(Integer.parseInt(status));
                                u.setUsername(username);
                                currentSession.save(u);
                            }
                        }
                    }

                    // UPDATE USER
                    if (request.getParameter("update") != null) {

                        String first_name = request.getParameter("first_name");
                        String last_surname = request.getParameter("last_surname");
                        String password = request.getParameter("password");
                        String status = request.getParameter("status");
                        String username = request.getParameter("username");
                        String idStr = request.getParameter("id");

                        if (first_name != null && last_surname != null && password != null && status != null && username != null && idStr != null) {
                            if (!first_name.trim().isEmpty() && !last_surname.trim().isEmpty() && !password.trim().isEmpty() && !status.trim().isEmpty() && !username.trim().isEmpty() && !idStr.trim().isEmpty()) {
                                try {
                                    int id = Integer.parseInt(idStr);
                                    User u = (User) currentSession.get(User.class, id);
                                    u.setCreatedAt(new Date());
                                    u.setFirstName(first_name);
                                    u.setLastSurname(last_surname);
                                    u.setPassword(password);
                                    u.setStatus(Integer.parseInt(status));
                                    u.setUsername(username);
                                    currentSession.update(u);
                                } catch (Exception e) {
                                }
                            }
                        }
                    }

                    // DELETE USER
                    if (request.getParameter("delete") != null) {
                        String idStr = request.getParameter("id");
                        if (idStr != null) {
                            if (!idStr.trim().isEmpty()) {
                                try {
                                    int id = Integer.parseInt(idStr);
                                    User u = (User) currentSession.get(User.class, id);
                                    currentSession.delete(u);
                                } catch (Exception e) {
                                }

                            }
                        }
                    }
                } catch (Exception e) {
                    tx.rollback();
                } finally {
                    tx.commit();
                }

            }
        }

        Session currentSession = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = currentSession.beginTransaction();
        try {
            Query namedQuery = currentSession.getNamedQuery("User.findAll");
            List<User> list = namedQuery.list();

            System.out.println("-------------------------" + list.size());
            request.getSession().setAttribute("allUsers", list);
        } catch (Exception e) {
            tx.rollback();
        } finally {
            tx.commit();
        }

        request.getRequestDispatcher("WEB-INF/users.jsp").forward(request, response);

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
