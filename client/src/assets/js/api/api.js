// URL base de la API del backend. Cambia aquí si tu backend cambia de dirección.
export const API_BASE = "http://localhost/NKI/server/public";

/**
 * Realiza una petición POST a la API.
 * @param {string} url - URL completa del endpoint (usa API_BASE para construirla).
 * @param {object} data - Objeto con los datos a enviar en el body.
 * @returns {Promise<object>} - Respuesta de la API en formato JSON.
 * @throws {Error} - Si la respuesta no es exitosa.
 */
export async function apiPost(url, data) {
  const response = await fetch(url, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data)
  });
  let result;
  try {
    result = await response.json();
  } catch {
    result = {};
  }
  if (!response.ok) {
    throw new Error(result.message || "Error en la petición");
  }
  return result;
}

/**
 * Realiza una petición GET a la API.
 * @param {string} url - URL completa del endpoint.
 * @returns {Promise<object>} - Respuesta de la API en formato JSON.
 * @throws {Error} - Si la respuesta no es exitosa.
 */
export async function apiGet(url) {
  const response = await fetch(url);
  let result;
  try {
    result = await response.json();
  } catch {
    result = {};
  }
  if (!response.ok) {
    throw new Error(result.message || "Error en la petición");
  }
  return result;
}