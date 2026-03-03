# Terraform Examples

Colección de ejemplos prácticos para aprender Terraform, organizados por conceptos: variables, módulos, providers, lifecycle, datasources y más.

## Estructura

| Carpeta | Descripción |
|---|---|
| `variables/` | Declaración y uso de variables de entrada |
| `tipos compuestos/` | Tipos de datos complejos: listas, mapas, objetos, sets |
| `expresiones_funciones/` | Expresiones condicionales y funciones built-in de Terraform |
| `datasources/` | Consulta de recursos existentes con `data` sources |
| `depends_on/` | Control explícito de dependencias entre recursos |
| `lifecycle/` | Gestión del ciclo de vida: `create_before_destroy`, `prevent_destroy`, `ignore_changes` |
| `providers/` | Configuración y uso de providers |
| `modulos/` | Creación y reutilización de módulos |
| `multicontainer/` | Despliegue de múltiples contenedores |
| `terraform_docker/` | Gestión de recursos Docker con el provider de Docker |
| `kubernetes/` | Despliegue de recursos en Kubernetes |
| `localstack/` | Simulación de servicios AWS en local con LocalStack |
| `terraform_cloud/` | Integración con Terraform Cloud como backend remoto |

## Uso general

Cada carpeta contiene ejemplos independiente. Para ejecutar cualquiera de ellos:

```bash
cd <carpeta>
terraform init
terraform plan
terraform apply
```

Para destruir la infraestructura creada:

```bash
terraform destroy
```

## Requisitos

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.0
- Según el ejemplo: Docker, kubectl, LocalStack o Terraform Cloud
- Para `localstack/`: [LocalStack](https://docs.localstack.cloud/getting-started/installation/) instalado y en ejecución
