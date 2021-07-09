package org.shandelortiz.controller;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
//import javafx.scene.image.ImageView;
//import javafx.scene.layout.AnchorPane;
import org.shandelortiz.system.Principal;

/**
 *
 * @author Shandel
 */
public class DatosProgramadorController implements Initializable{
    private Principal escenarioPrincipal;
    
    @FXML private Button btnProgramador;
    @FXML private Button btnAdministracion;
    //@FXML private AnchorPane pnlStatus;
    @FXML private Label lblNombres;
    @FXML private Label lblApellidos;
    @FXML private Label lblTitulo;
    
    @Override
    public void initialize(URL location, ResourceBundle resources) {
        
    }

    public Principal getEscenarioPrincipal() {
        return escenarioPrincipal;
    }

    public void setEscenarioPrincipal(Principal escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }
    
    @FXML
    private void botones(ActionEvent event){
        if(event.getSource() == btnProgramador){
            lblNombres.setText("Shandel Noe");
            lblApellidos.setText("Ortiz Morales");
            lblTitulo.setText("Datos del Programador");
        }else if(event.getSource() == btnAdministracion){
            lblNombres.setText("Fundación");
            lblApellidos.setText("KINAL");
            lblTitulo.setText("Datos del Administrador");
        }
    }
    
    public void menuPrincipal(){
        escenarioPrincipal.menuPrincipal();
    }
}