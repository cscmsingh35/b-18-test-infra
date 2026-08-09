# Azure Infrastructure with Terraform (b-18-test-infra)

This repository contains modular Terraform configurations to provision and manage Azure infrastructure across multiple environments (such as `preprod` and `prod`).

---

## 📁 Project Structure

```text
b-18-test-infra/
├── .gitignore
├── README.md
├── modules/
│   ├── azurerm_resource_group/
│   │   ├── main.tf          # Resource group definition (for_each)
│   │   └── variable.tf      # Variables for resource groups
│   └── azurerm_storage_account/
│       ├── main.tf          # Storage account definition (for_each)
│       └── variable.tf      # Variables for storage accounts
└── environment/
    ├── preprod/
    │   ├── provider.tf      # Azure provider configuration
    │   ├── main.tf          # Module invocation & dependencies
    │   ├── variable.tf      # Environment-level variables
    │   └── terraform.tfvars # Input values for preprod
    └── prod/                # Production environment (future scope)
```

---

## ⚙️ Prerequisites

Before running Terraform commands, ensure you have:
1. **Terraform CLI** installed (v1.0+).
2. **Azure CLI (`az`)** installed.
3. Authenticated to Azure using:
   ```bash
   az login
   ```
4. Set the desired Azure subscription (if you have multiple):
   ```bash
   az account set --subscription "<SUBSCRIPTION_ID_OR_NAME>"
   ```

---

## 🚀 Step-by-Step Deployment Process

### 1. Navigate to the Environment Directory
Change directory to the specific environment folder you want to deploy (e.g., `preprod`):
```bash
cd environment/preprod
```

### 2. Initialize Terraform (`terraform init`)
Initializes the working directory, downloads required provider plugins (`hashicorp/azurerm`), and installs local modules:
```bash
terraform init
```

### 3. Validate Configuration (`terraform validate`)
Checks whether the configuration files are syntactically valid and internally consistent:
```bash
terraform validate
```

### 4. Format Check (`terraform fmt`)
Ensures all `.tf` files follow standard Terraform formatting conventions:
```bash
terraform fmt -recursive
```

### 5. Generate Execution Plan (`terraform plan`)
Previews all changes that Terraform will make in Azure based on `terraform.tfvars`:
```bash
terraform plan
```

### 6. Apply Changes (`terraform apply`)
Provisions the resources in Azure. You will be prompted to confirm by typing `yes`:
```bash
terraform apply
```
*(Or run `terraform apply -auto-approve` for non-interactive execution).*

---

## 🔍 How the Modules Work

### 1. Resource Group Module (`modules/azurerm_resource_group`)
- Accepts a map of resource groups via `var.rgs`.
- Uses `for_each` to create multiple Resource Groups dynamically.

### 2. Storage Account Module (`modules/azurerm_storage_account`)
- Accepts a map of storage accounts via `var.storage_accounts`.
- Uses `for_each` to create multiple Storage Accounts dynamically.

### 3. Dependency Management
- In `environment/preprod/main.tf`, `depends_on = [module.resource_group]` ensures that Resource Groups are created **before** Storage Accounts to prevent deployment errors.

---

## 🧹 Destroying Resources

To tear down and remove all provisioned infrastructure in the environment:
```bash
terraform destroy
```
Type `yes` when prompted to confirm the deletion.