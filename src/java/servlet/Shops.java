package servlet;

import db.HibernateUtil;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Category;
import model.Manufactor;
import model.Product;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Bojan
 */
@WebServlet(name = "Shop", urlPatterns = {"/shops"})
public class Shops extends HttpServlet {

 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        if (request.getSession().getAttribute("logged_in") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        if (request.getParameter("add") != null) {
            System.out.println("--------------------------------------------------01");
            if (request.getSession().getAttribute("cart") != null) {
                System.out.println("--------------------------------------------------02");
                try {
                    int id = Integer.parseInt(request.getParameter("add"));
                    HashMap<Integer, Integer> cart = (HashMap<Integer, Integer>) request.getSession().getAttribute("cart");

                    if (cart.containsKey(id)) {
                        cart.put(id, (int) cart.get(id) + 1);
                    } else {
                        cart.put(id, 1);
                    }

                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            } else {
                try {
                    System.out.println("--------------------------------------------------03");
                    HashMap<Integer, Integer> cart = (HashMap<Integer, Integer>) request.getSession().getAttribute("cart");
                    int id = Integer.parseInt(request.getParameter("add"));
                    cart.put(id, 1);
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
        }

        if (request.getSession().getAttribute("productCount") == null) {
            int productCount = 0;
            request.getSession().setAttribute("productCount", productCount);
        }

        HashMap<Integer, Integer> cart = (HashMap<Integer, Integer>) request.getSession().getAttribute("cart");
        int productCount = 0;
        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            Integer key = entry.getKey();
            Integer value = entry.getValue();
            productCount += value;
        }

        System.out.println("--------------------------------" + productCount);
        System.out.println(cart);
        request.getSession().setAttribute("productCount", productCount);

        Session currentSession = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = currentSession.beginTransaction();

        try {
            Query queryProducts = currentSession.getNamedQuery("Product.findAll");
            List<Product> listProducts = queryProducts.list();

            request.getSession().setAttribute("allProducts", listProducts);
        } catch (Exception e) {
            tx.rollback();
        } finally {
            tx.commit();
        }

        request.getRequestDispatcher("WEB-INF/shops.jsp").forward(request, response);

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
