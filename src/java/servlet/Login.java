package servlet;

import db.HibernateUtil;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

@WebServlet(name = "Login", urlPatterns = {"/login"})
public class Login extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        Session currentSession = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = currentSession.beginTransaction();
        User u = null;
        try {
            Query checkUser = currentSession.getNamedQuery("User.authUser");
            checkUser.setParameter("username", request.getParameter("username"));
            checkUser.setParameter("password", request.getParameter("password"));

            u = (User) checkUser.uniqueResult();
        } catch (Exception e) {
            tx.rollback();
            response.sendRedirect("index.jsp");
            return;
        } finally {
            tx.commit();
        }

        HashMap<Integer, Integer> cart = new HashMap<Integer, Integer>();
        request.getSession().setAttribute("cart", cart);
        
        int productCount = 0;
        request.getSession().setAttribute("productCount", productCount);

        request.getSession().setAttribute("logged_in", u);
        response.sendRedirect("panel.jsp");
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
