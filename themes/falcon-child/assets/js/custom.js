/**
 * ==============================================================================
 * Falcon Child Theme - Custom Scripts (custom.js)
 * ==============================================================================
 * 
 * Este archivo se carga automáticamente en todas las páginas con prioridad 1000.
 * Puedes escribir scripts en JavaScript Vanilla o jQuery para personalizar el
 * comportamiento de tu tienda.
 */

document.addEventListener('DOMContentLoaded', () => {
  // Código que se ejecuta cuando el DOM está completamente cargado.
  // Ejemplo: Escuchar eventos de actualización de PrestaShop:
  if (window.prestashop) {
    prestashop.on('updatedCart', () => {
      // El carrito ha sido actualizado
    });

    prestashop.on('updatedProduct', () => {
      // Opciones o combinaciones de producto actualizadas
    });
  }
});
