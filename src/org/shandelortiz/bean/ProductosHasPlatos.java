package org.shandelortiz.bean;

/**
 *
 * @author Shandel
 */
public class ProductosHasPlatos {
    private int Productos_codigoProductos;
    private int codigoPlato;
    private int codigoProducto;

    public ProductosHasPlatos() {
    }

    public ProductosHasPlatos(int Productos_codigoProductos, int codigoPlato, int codigoProducto) {
        this.Productos_codigoProductos = Productos_codigoProductos;
        this.codigoPlato = codigoPlato;
        this.codigoProducto = codigoProducto;
    }

    public int getProductos_codigoProductos() {
        return Productos_codigoProductos;
    }

    public void setProductos_codigoProductos(int Productos_codigoProductos) {
        this.Productos_codigoProductos = Productos_codigoProductos;
    }

    public int getCodigoPlato() {
        return codigoPlato;
    }

    public void setCodigoPlato(int codigoPlato) {
        this.codigoPlato = codigoPlato;
    }

    public int getCodigoProducto() {
        return codigoProducto;
    }

    public void setCodigoProducto(int codigoProducto) {
        this.codigoProducto = codigoProducto;
    }
}