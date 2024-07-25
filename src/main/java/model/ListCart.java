/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author tanpr
 */
public final class ListCart {

    private List<Cart> carts;

    public ListCart() {
        carts = new ArrayList<>();
    }

    public ListCart(List<Cart> carts) {
        this.carts = carts;
    }

    public List<Cart> getCarts() {
        return carts;
    }

    public int getQuantityById(int id) {
        return getCartById(id).getQuantity();
    }

    public Cart getCartById(int id) {
        for (Cart c : carts) {
            if (c.getProduct().getId() == id) {
                return c;
            }
        }
        return null;
    }

    public void addCart(Cart c) {
        if (getCartById(c.getProduct().getId()) != null) {
            Cart m = getCartById(c.getProduct().getId());
            m.setQuantity(m.getQuantity() + c.getQuantity());
        } else {
            carts.add(c);
        }
    }

    public void removeCart(int id) {
        if (getCartById(id) != null) {
            carts.remove(getCartById(id));
        }
    }

    public double getTotalMoney() {
        double t = 0;
        for (Cart c : carts) {
            t += (c.getQuantity() * c.getProduct().getPrice());
        }
        return t;
    }

    public double getTotalMoneyVAT(){
        double t = 0;
        for (Cart c : carts) {
            t+=(c.getQuantity()*c.getProduct().getPrice()*0.1);}
        return t;
    }

    public double getTotalMoneyt(){
        double t = 0;
        for (Cart c : carts) {
            t+=((c.getQuantity()*c.getProduct().getPrice())+ (c.getQuantity()*c.getProduct().getPrice()*0.1));
        }
        return t;

    }

    private Product getProductById(int id, List<Product> list) {
        for (Product i : list) {
            if (i.getId() == id) {
                return i;
            }
        }
        return null;
    }
}
