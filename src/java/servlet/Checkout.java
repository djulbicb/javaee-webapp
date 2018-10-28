package servlet;

import java.io.IOException;
import java.util.*;
import model.ProductOrder;

import db.HibernateUtil;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Orderdetail;
import model.Orders;
import model.Product;
import model.ProductOrder;
import model.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

@WebServlet(name = "Checkout", urlPatterns = {"/checkout"})
public class Checkout extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        if (request.getSession().getAttribute("logged_in") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        if (request.getSession().getAttribute("allCartProducts") == null) {
            response.sendRedirect("./shops");
            return;
        }

        int count = (int) request.getSession().getAttribute("productCount");

        if (count == 0) {
            response.sendRedirect("./shops");
            return;
        }

        Session currentSession = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = currentSession.beginTransaction();
        try {
            Query namedQuery = currentSession.getNamedQuery("User.findAll");
            List<User> list = namedQuery.list();

            List<ProductOrder> listProducts = (List<ProductOrder>) request.getSession().getAttribute("allCartProducts");
            if (listProducts.size() > 0) {
                User u = (User) request.getSession().getAttribute("logged_in");
                Orders order = new Orders();
                order.setCreatedAt(new Date());
                order.setUserId(u);
                ArrayList<Orderdetail> arrayList = new ArrayList();
                order.setOrderdetailCollection(arrayList);
                for (ProductOrder prod : listProducts) {

                    Orderdetail detail = new Orderdetail();
                    detail.setCreatedAt(new Date());
                    detail.setAmount(prod.getStock());
                    detail.setProductId(prod.product);
                    detail.setUserId(u);
                    detail.setOrdersId(order);
                    currentSession.save(detail);

                    Product get = (Product) currentSession.get(Product.class, prod.product.getId());
                    get.setStockQuantity(get.getStockQuantity() - prod.getStock());
                    currentSession.update(get);
                }
                currentSession.save(order);
            }

            request.getSession().setAttribute("allUsers", list);
        } catch (Exception e) {
            tx.rollback();
        } finally {
            tx.commit();

        }

        request.getSession().setAttribute("allCartProducts", null);
        int productCount = 0;
        request.getSession().setAttribute("productCount", productCount);
        HashMap<Integer, Integer> cart = new HashMap<>();
        request.getSession().setAttribute("cart", cart);

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
