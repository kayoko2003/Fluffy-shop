/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ngoc
 */
public class Role {
    private int rID;
    private String rName;

    public Role() {
    }

    public Role(int rID, String rName) {
        this.rID = rID;
        this.rName = rName;
    }

    public int getrID() {
        return rID;
    }

    public void setrID(int rID) {
        this.rID = rID;
    }

    public String getrName() {
        return rName;
    }

    public void setrName(String rName) {
        this.rName = rName;
    }

    @Override
    public String toString() {
        return "Role{" + "rID=" + rID + ", rName=" + rName + '}';
    }
    
}
