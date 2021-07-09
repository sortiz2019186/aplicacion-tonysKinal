package org.shandelortiz.system;

import java.io.InputStream;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.fxml.JavaFXBuilderFactory;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;
import org.shandelortiz.controller.DatosProgramadorController;
import org.shandelortiz.controller.EmpleadosController;
import org.shandelortiz.controller.EmpresaController;
import org.shandelortiz.controller.MenuPrincipalController;
import org.shandelortiz.controller.PlatosController;
import org.shandelortiz.controller.PresupuestoController;
import org.shandelortiz.controller.ProductoController;
import org.shandelortiz.controller.ServiciosController;
import org.shandelortiz.controller.TipoEmpleadoController;
import org.shandelortiz.controller.TipoPlatoController;
import org.shandelortiz.controller.ProductosHasPlatosController;
import org.shandelortiz.controller.ServiciosHasPlatosController;

/**
 *
 * @author Shandel Ortiz
 */
public class Principal extends Application {
    private final String PAQUETE_VISTA = "/org/shandelortiz/view/";
    private Stage escenarioPrincipal;
    private Scene escena;
    
    @Override
    public void start(Stage escenarioPrincipal) throws Exception {
        this.escenarioPrincipal = escenarioPrincipal;
        this.escenarioPrincipal.setTitle("Tony's Kinal App");
        escenarioPrincipal.getIcons().add(new Image("/org/shandelortiz/image/Icono.png"));
        //Parent root = FXMLLoader.load(getClass().getResource("/org/shandelortiz/view/MenuPrincipalView.fxml"));
        //Scene escena = new Scene(root);
        //escenarioPrincipal.setScene(escena);
        menuPrincipal();
        escenarioPrincipal.show();
    }
    
    public void menuPrincipal(){
        try{
            MenuPrincipalController menuPrincipal = (MenuPrincipalController)
                    cambiarEscena("MenuPrincipalView.fxml",600,400);
            menuPrincipal.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaEmpresa(){
        try{
            EmpresaController empresasController = (EmpresaController)
                    cambiarEscena("EmpresasView.fxml",715,570);
            empresasController.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaProgramador(){
        try{
            DatosProgramadorController datosPersonales = (DatosProgramadorController)
                    cambiarEscena("DatosProgramadorView.fxml",600,500);
            datosPersonales.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaTipoEmpleado(){
        try{
            TipoEmpleadoController tipoEmpleado = (TipoEmpleadoController)
                    cambiarEscena("TipoEmpleadoView.fxml",715,500);
            tipoEmpleado.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaTipoPlato(){
        try{
            TipoPlatoController tipoPlato = (TipoPlatoController)
                    cambiarEscena("TipoPlatoView.fxml",715,500);
            tipoPlato.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaProducto(){
        try{
            ProductoController producto = (ProductoController)
                    cambiarEscena("ProductoView.fxml",715,550);
            producto.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaPresupuesto(){
        try{
            PresupuestoController presupuesto = (PresupuestoController)
                    cambiarEscena("PresupuestoView.fxml",715,500);
            presupuesto.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaEmpleados(){
        try{
            EmpleadosController empleados = (EmpleadosController)
                    cambiarEscena("EmpleadosView.fxml",955,580);
            empleados.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaPlatos(){
        try{
            PlatosController platos = (PlatosController)
                    cambiarEscena("PlatosView.fxml",785,520);
            platos.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaServicios(){
        try{
            ServiciosController servicios = (ServiciosController)
                    cambiarEscena("ServiciosView.fxml",995,580);
            servicios.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaProductosHasPlatos(){
        try{
            ProductosHasPlatosController productosHasPlatos = (ProductosHasPlatosController)
                cambiarEscena("ProductosHasPlatosView.fxml",715,500);
        productosHasPlatos.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public void ventanaServiciosHasPlatos(){
        try{
            ServiciosHasPlatosController serviciosHasPlatos = (ServiciosHasPlatosController)
                cambiarEscena("ServiciosHasPlatosView.fxml",715,500);
            serviciosHasPlatos.setEscenarioPrincipal(this);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        launch(args);
    }
    
    public Initializable cambiarEscena (String fxml, int ancho, int alto)
            throws Exception{
        Initializable resultado = null;
        FXMLLoader cargadorFXML = new FXMLLoader();
        InputStream archivo = Principal.class.getResourceAsStream
        (PAQUETE_VISTA+fxml);
        cargadorFXML.setBuilderFactory(new JavaFXBuilderFactory());
        cargadorFXML.setLocation(Principal.class.getResource
        (PAQUETE_VISTA+fxml));
        escena = new Scene((AnchorPane)cargadorFXML.load(archivo),ancho,alto);
        escenarioPrincipal.setScene(escena);
        escenarioPrincipal.sizeToScene();
        resultado = (Initializable)cargadorFXML.getController();
        
        return resultado;
    }
}