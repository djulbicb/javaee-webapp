package servlet;

import db.HibernateUtil;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Orders;
import model.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

@WebServlet(name = "Transactions", urlPatterns = {"/transactions"})
public class Transactions extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        if (request.getSession().getAttribute("logged_in") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        User u = (User) request.getSession().getAttribute("logged_in");

        Session currentSession = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = currentSession.beginTransaction();
        try {
            Query namedQuery = currentSession.getNamedQuery("Orders.findByUserId");
            namedQuery.setInteger("id", u.getId());
            List<Orders> listOrders = namedQuery.list();

            request.getSession().setAttribute("listOrders", listOrders);
        } catch (Exception e) {
            tx.rollback();
        } finally {
            tx.commit();
        }
        request.getRequestDispatcher("WEB-INF/transactions.jsp").forward(request, response);
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
