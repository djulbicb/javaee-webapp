package servlet;

import db.HibernateUtil;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.swing.filechooser.FileSystemView;
import javax.tools.FileObject;
import model.Category;
import model.Manufactor;
import model.Product;
import model.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

@WebServlet(name = "Products", urlPatterns = {"/products"})
@MultipartConfig
public class Products extends HttpServlet {

    public String getImagePath() {
        return Config.Configuration.getImagePath();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        if (request.getSession().getAttribute("logged_in") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        if (request.getSession().getAttribute("produuid") != null && request.getParameter("form_id") != null) {

            UUID uuid = (UUID) request.getSession().getAttribute("produuid");
            request.getSession().setAttribute("produuid", null);
            String form_id = request.getParameter("form_id");

            if (form_id.equals(uuid.toString())) {
                // CREATE PRODUCT
                if (request.getParameter("add") != null) {

                    Session currentSession = HibernateUtil.getSessionFactory().getCurrentSession();
                    Transaction tx = currentSession.beginTransaction();

                    String name = request.getParameter("name");
                    String listManufactorsId = request.getParameter("listManufactors");
                    String listCategorysId = request.getParameter("listCategorys");
                    String stock = request.getParameter("stock");
                    Part image = request.getPart("imageUrl");

                    try {
                        Product p = new Product();

                        InputStream picture = image.getInputStream();

                        UUID randomUUID = UUID.randomUUID();
                        FileOutputStream fos = new FileOutputStream(getImagePath() + randomUUID.toString() + "_" + image.getSubmittedFileName());
                        //FileOutputStream fos = new FileOutputStream(image.getSubmittedFileName());
                        int c;
                        while ((c = picture.read()) != -1) {
                            fos.write(c);
                        }

                        fos.close();

                        p.setName(name);
                        p.setManufactorId((Manufactor) currentSession.get(Manufactor.class, Integer.parseInt(listManufactorsId)));
                        p.setCategoryId((Category) currentSession.get(Category.class, Integer.parseInt(listCategorysId)));
                        p.setStockQuantity(Integer.parseInt(stock));
                        p.setImageUrl(randomUUID.toString() + "_" + image.getSubmittedFileName());
                        currentSession.save(p);

                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                        tx.rollback();
                    } finally {
                        tx.commit();
                    }
                }

                // UPDATE PRODUCT
                if (request.getParameter("update") != null) {
                    Session currentSession = HibernateUtil.getSessionFactory().getCurrentSession();
                    Transaction tx = currentSession.beginTransaction();

                    String id = request.getParameter("id");
                    String name = request.getParameter("name");
                    String listManufactorsId = request.getParameter("listManufactors");
                    String listCategorysId = request.getParameter("listCategorys");
                    String stock = request.getParameter("stock");
                    Part image = request.getPart("imageUrl");

                    try {
                        Product p = (Product) currentSession.get(Product.class, Integer.parseInt(id));

                        InputStream picture = image.getInputStream();

                        UUID randomUUID = UUID.randomUUID();
                        FileOutputStream fos = new FileOutputStream(getImagePath() + randomUUID.toString() + "_" + image.getSubmittedFileName());

                        int c;
                        while ((c = picture.read()) != -1) {
                            fos.write(c);
                        }

                        fos.close();

                        p.setName(name);
                        p.setManufactorId((Manufactor) currentSession.get(Manufactor.class, Integer.parseInt(listManufactorsId)));
                        p.setCategoryId((Category) currentSession.get(Category.class, Integer.parseInt(listCategorysId)));
                        p.setStockQuantity(Integer.parseInt(stock));
                        p.setImageUrl(randomUUID.toString() + image.getSubmittedFileName());
                        currentSession.update(p);

                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                        tx.rollback();
                    } finally {
                        tx.commit();
                    }
                }
            }

            // DELETE PRODUCT
            if ((request.getParameter("delete") != null)) {
                if (request.getParameter("id") != null) {
                    String idStr = request.getParameter("id");
                    try {
                        int id = Integer.parseInt(idStr);
                        Session currentSession = HibernateUtil.getSessionFactory().getCurrentSession();
                        Transaction tx = currentSession.beginTransaction();

                        try {
                            Product product = (Product) currentSession.get(Product.class, id);
                            currentSession.delete(product);
                        } catch (Exception e) {
                            tx.rollback();
                        } finally {
                            tx.commit();
                        }
                    } catch (Exception e) {
                    }
                }
            }
        }

        Session currentSession = HibernateUtil.getSessionFactory().getCurrentSession();
        Transaction tx = currentSession.beginTransaction();

        try {
            Query queryProducts = currentSession.getNamedQuery("Product.findAll");
            List<Product> listProducts = queryProducts.list();

            Query queryManufactor = currentSession.getNamedQuery("Manufactor.findAll");
            List<Manufactor> listManufactors = queryManufactor.list();

            Query queryCategory = currentSession.getNamedQuery("Category.findAll");
            List<Category> listCategorys = queryCategory.list();

            request.getSession().setAttribute("allProducts", listProducts);
            request.getSession().setAttribute("listManufactors", listManufactors);
            request.getSession().setAttribute("listCategorys", listCategorys);
        } catch (Exception e) {
            tx.rollback();
        } finally {
            tx.commit();
        }

        request.getRequestDispatcher("WEB-INF/products.jsp").forward(request, response);
        /*
        request.getRequestDispatcher("WEB-INF/products.jsp").include(request, response);
        response.sendRedirect("./products");
        return;*/
        //
    }

    private boolean validity(String[] args, HttpServletRequest request) {
        String check = "";
        for (String arg : args) {
            if (request.getParameter(arg) == null) {
                check += arg + " ,";
            }
        }
        request.getSession().setAttribute("info", "test");
        if (check.equals("")) {
            return true;
        } else {
            request.getSession().setAttribute("info", check.substring(0, check.length() - 1));
            return false;
        }

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
