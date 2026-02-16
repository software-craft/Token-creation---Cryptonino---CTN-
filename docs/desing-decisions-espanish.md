# Decisiones de diseño - Cryptonino (CTN)

## 1. Objetivo del Proyecto
Crear un token ERC20 llamado **Cryptonino (CTN)** desplegado en la red **Arbitrum** para minimizar costos de transacción, y enviar la totalidad del suministro inicial a mi propia wallet de **Metamask**, asegurando control exclusivo y descentralizado.

## 2. Elección de la Red: Arbitrum
- **Motivo:** Arbitrum es una solución de capa 2 de Ethereum que ofrece tarifas de gas significativamente más bajas que la red principal, manteniendo la seguridad de Ethereum.
- **Ventaja:** Permite realizar despliegues y transferencias del token con costos mínimos, ideal para un proyecto personal o de prueba.

## 3. Wallet: Metamask
- **Motivo:** Metamask es una de las wallets más descentralizadas y ampliamente utilizadas. Proporciona control total sobre las claves privadas, asegurando que solo yo tenga acceso a los fondos.
- **Uso:** Se utilizará para desplegar el contrato, recibir los tokens minteados inicialmente y posteriormente para gestionar y transferir los CTN.

## 4. Versión de Solidity: 0.8.30
- **Motivo:** Se elige la última versión estable de Solidity (0.8.30) para beneficiarse de las últimas mejoras de seguridad, correcciones de bugs y optimizaciones del compilador.
- **Impacto:** Reduce la probabilidad de vulnerabilidades conocidas en versiones anteriores y garantiza compatibilidad con prácticas modernas de desarrollo.

## 5. Librería de OpenZeppelin: ERC20
- **Motivo:** OpenZeppelin es el estándar de la industria para contratos seguros y auditados. Su implementación de ERC20 es utilizada por proyectos como Uniswap, Aave, etc.
- **Ventajas:**
  - Código probado en producción y auditado.
  - Ahorro de tiempo y esfuerzo al no tener que reescribir funciones estándar.
  - Minimiza riesgos de bugs o errores manuales.
- **Implementación:** Se importa el contrato `ERC20.sol` de OpenZeppelin y se hereda en `Cryptonino`.

## 6. Suministro Inicial y Mint Automático
- **Cantidad:** 9,000,000 CTN (expresado como `9000000 * 1e18` para manejar los 18 decimales estándar).

- **Destinatario:** El contrato utiliza `_mint(msg.sender, ...)` en el constructor, lo que asigna todos los tokens minteados a la dirección que despliega el contrato.

- **Ventaja:** No es necesario escribir explícitamente la dirección de la wallet; el contrato detecta automáticamente al deployer (mi wallet de Metamask), simplificando el proceso y evitando errores al copiar direcciones.

## 7. Seguridad y Buenas Prácticas

- Se utiliza la última versión de Solidity y librerías oficiales auditadas.
- El contrato es simple y hereda la funcionalidad completa de OpenZeppelin, reduciendo la superficie de ataque.
- Se evitan modificaciones personalizadas que puedan introducir vulnerabilidades.

## 8. Proceso de Despliegue

1. Configurar Metamask con la red Arbitrum.
2. Financiar la wallet con ETH en Arbitrum para pagar el gas.
3. Compilar y desplegar el contrato usando herramientas como Remix, Hardhat o Truffle.
4. Verificar el contrato en el explorador de bloques de Arbitrum (Arbiscan) para transparencia.

## 9. Post-Despliegue

- Los 9 millones de CTN estarán automáticamente en mi wallet de Metamask.
- Podré realizar transferencias, aprobaciones y cualquier operación ERC20 estándar.

# Decisiones de diseño (texto plano)

1) Por qué el supply es fijo

El total supply se define en el constructor y se mintéan 9,000,000 tokens a la cuenta desplegadora. Decidimos supply fijo para mantener predictibilidad económica, evitar inflación por mint posteriores y simplificar auditoría y razonamiento sobre la distribución inicial.

2) Por qué el mint solo ocurre en el constructor

Limitar el mint al constructor elimina funciones de emisión posteriores y reduce la superficie de ataque (no hay funciones públicas/externas que puedan crear nuevos tokens). Además, permite que la cantidad total sea inmutable desde el momento del deploy.

3) Por qué no hay owner

No se incluye un `owner` ni controles administrativos: es una implementación deliberada para minimizar privilegios poderosos y evitar riesgos de centralización y errores en la lógica de administración. Esto simplifica seguridad y hace al contrato más predecible.

4) Por qué usas OpenZeppelin

Se utiliza la implementación probada y ampliamente auditada de `ERC20` de :contentReference[oaicite:0]{index=0} por su robustez, compatibilidad y mantenimiento comunitario. Reusar código estándar reduce riesgo de bugs y vulnerabilidades en funciones ERC-20 críticas.

5) Qué cosas el contrato no puede hacer

- No puede mintear fuera del constructor (no existe función `mint` pública).
- No tiene mecanismo de quema (`burn`) explícito.
- No tiene pausado (`pause`) ni roles administrativos.
- No soporta features avanzadas (impuestos, staking, snapshots, ERC-777,ERC-4626).
- No gestiona listado blanco/negro de cuentas.