package model;

public class ProductOrder {

    public Product product;
    public int amount;

    @Override
    public String toString() {
        return product.getName() + " " + amount; 
    }
    
    public String getName(){
        return product.getName();
    }
    
    public String getManufactor(){
        return product.getManufactorId().getName();
    }
    
    public int getStock(){
        return amount;
    }
    
    public String getUrl(){
        return product.getImageUrl();
    }
    
    public int getId(){
        return product.getId();
    }
}

                          