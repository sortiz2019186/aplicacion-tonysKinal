package org.shandelortiz.controller;

import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.ResourceBundle;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import org.shandelortiz.bean.Platos;
import org.shandelortiz.bean.Producto;
import org.shandelortiz.bean.ProductosHasPlatos;
import org.shandelortiz.bean.Servicios;
import org.shandelortiz.db.Conexion;
import org.shandelortiz.system.Principal;

/**
 *
 * @author Shandel
 */
public class ProductosHasPlatosController implements Initializable{
    private Principal escenarioPrincipal;
    private ObservableList<Producto> listaProducto;
    private ObservableList<Platos> listaPlatos;
    private ObservableList<ProductosHasPlatos> listaProductosHasPlatos;
    
    @FXML private ComboBox cmbCodigoProducto;
    @FXML private ComboBox cmbCodigoPlato;
    @FXML private TableView tblProductoshasPlatos;
    @FXML private TableColumn colCodigoTipoEmpleado;
    @FXML private TableColumn colCodigoPlato;
    
    @Override
    public void initialize(URL location, ResourceBundle resources) {
        cargarDatos();
    }
    
    public void cargarDatos(){
        
    }
    
    public ObservableList<Producto> getProducto(){
        ArrayList<Producto> lista = new ArrayList<Producto>();
        try{
            PreparedStatement prodecimiento = Conexion.getInstance().
                    getConexion().prepareCall("{Call sp_ListarProductos}");
            ResultSet resultado = prodecimiento.executeQuery();
            
            while(resultado.next()){
                lista.add(new Producto(
                    resultado.getInt("codigoProducto"),
                    resultado.getString("nombreProducto"),
                    resultado.getInt("cantidad")
                ));
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return listaProducto = FXCollections.observableArrayList(lista);
    }
    
    public ObservableList<Platos> getPlatos(){
        ArrayList<Platos> lista = new ArrayList<Platos>();
        try{
            PreparedStatement procedimiento = Conexion.getInstance().
                    getConexion().prepareCall("{Call sp_ListarPlatos}");
            ResultSet resultado = procedimiento.executeQuery();
            while(resultado.next()){
                lista.add(new Platos(
                        resultado.getInt("codigoPlato"),
                        resultado.getInt("cantidad"),
                        resultado.getString("nombrePlato"),
                        resultado.getString("descripcionPlato"),
                        resultado.getDouble("precioPlato"),
                        resultado.getInt("codigoTipoPlato")
                ));
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return listaPlatos = FXCollections.observableArrayList(lista);
    }
    
    public Producto buscarProducto(int codigoProducto){
        Producto resultado = null;
        try{
            PreparedStatement procedimiento = Conexion.getInstance().
                    getConexion().prepareCall("{Call sp_BuscarProductos(?)}");
            procedimiento.setInt(1, codigoProducto);
            ResultSet registro = procedimiento.executeQuery();
            while(registro.next()){
                resultado = new Producto(
                        registro.getInt("codigoProducto"),
                        registro.getString("nombreProducto"),
                        registro.getInt("cantidad")
                );
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return resultado;
    }
    
    public Platos buscarPlatos(int codigoPlato){
        Platos resultado = null;
        try{
            PreparedStatement procedimiento = Conexion.getInstance().
                    getConexion().prepareCall("{Call sp_BuscarPlatos(?)}");
            procedimiento.setInt(1, codigoPlato);
            ResultSet registro = procedimiento.executeQuery();
            while(registro.next()){
                resultado = new Platos(
                        registro.getInt("codigoPlato"),
                        registro.getInt("cantidad"),
                        registro.getString("nombrePlato"),
                        registro.getString("descripcionPlato"),
                        registro.getDouble("precioPlato"),
                        registro.getInt("codigoTipoPlato")
                );
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return resultado;
    }

    public Principal getEscenarioPrincipal() {
        return escenarioPrincipal;
    }

    public void setEscenarioPrincipal(Principal escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }
    
    public void menuPrincipal(){
        escenarioPrincipal.menuPrincipal();
    }
}