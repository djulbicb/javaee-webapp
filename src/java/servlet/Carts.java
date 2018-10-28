package servlet;

import db.HibernateUtil;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Category;
import model.Manufactor;
import model.Product;
import model.ProductOrder;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

@WebServlet(name = "Carts", urlPatterns = {"/carts"})
public class Carts extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        if (request.getSession().getAttribute("logged_in") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        if (request.getSession().getAttribute("productCount") == null) {
            response.sendRedirect("WEB-INF/products.jsp");
            return;
        }

        if (request.getParameter("remove") != null) {
            try {
                HashMap<Integer, Integer> cart = (HashMap<Integer, Integer>) request.getSession().getAttribute("cart");
                cart.remove(Integer.parseInt(request.getParameter("remove")));
                      
                int productCount = 0;
                for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                    Integer key = entry.getKey();
                    Integer value = entry.getValue();
                    productCount += value;
                }
                request.getSession().setAttribute("productCount", productCount);

            } catch (Exception e) {
            }
        }

        HashMap<Integer, Integer> cart = (HashMap<Integer, Integer>) request.getSession().getAttribute("cart");
        String ids = "";
        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            Integer key = entry.getKey();
            Integer value = entry.getValue();
            ids += (key + " ,");
        }

        Session currentSession = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx1 = currentSession.beginTransaction();
        try {
            List<ProductOrder> listProducts = new ArrayList();

            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                Integer key = entry.getKey();
                Integer value = entry.getValue();
                Product p = (Product) currentSession.get(Product.class, key);
                ProductOrder po = new ProductOrder();
                po.product = p;
                po.amount = value;
                listProducts.add(po);
            }

            request.getSession().setAttribute("allCartProducts", listProducts);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            tx1.rollback();
        } finally {
            tx1.commit();
        }

        request.getRequestDispatcher("WEB-INF/cart.jsp").forward(request, response);
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
