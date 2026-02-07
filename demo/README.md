## Demos

### 1-simple-module-repo

This is a module repository example with a module that doesn't have any incoming dependencies. 
This example showcases the validation options available. 

#### Run unit tests

1. `cd demo/1-simple-module-repo/standalone-module`
2. `tflocal init`
2. `tflocal test`

##### 1-simple-module-repo/standalone-module/tests/1-unit-test-minimal.tftest.hcl
This should be the bare minimum test fixture that should be created for all modules.
This test checks the basic example of the module and validates that all required variables are properly used.

##### 1-simple-module-repo/standalone-module/tests/2-unit-test-basic.tftest.hcl
This is a basic test fixture that shows how all variable mappings can be tested.
These tests should be included when complex variable mappings are used or when local variables perform complex calculations based on the input variables.

##### 1-simple-module-repo/standalone-module/tests/3-unit-test-error-cases.tftest.hcl
This is a test fixture that shows how to handle error cases in the module.
These tests should cover scenarios where the module is expected to fail or produce errors.
These error cases should represent failure cases where rollouts are expected to fail or when configuration failes to adhere to policy. 

#### Run integration test

1. `cd demo/1-simple-module-repo/integration-test`
2. `tflocal init`
3. `tflocal test`

This test simply validates that the module is deployable and working. 
In this simple scenario where there are no incoming dependencies, this test could be omitted. 
For this test to run, the module needs to be actually deployed (applied) to an environment.

### 2-complex-module-repo

This example contains multiple module repositories to showcase how dependencies can be tested when a module has incoming dependencies. 
In this example the highlighted module is the EC2 module and it has an incoming dependency on a subnet (which is provided by the VPC module). 

In this scenario, it's important to check the VPC modules output interface and to validate that the EC2 module can use the subnet.
Alternative, the VPC module could have been omitted and the subnet could have been created as part of the EC2 test fixture (as an embedded test module). 

#### Run unit tests

1. `cd demo/2-complex-module-repo/ec2-module`
2. `tflocal init`
3. `ADDITIONAL_TF_OVERRIDE_LOCATIONS=../vpc-module tflocal test`
4. `cd demo/2-complex-module-repo/ec2-default-alarms`
5. `tflocal init`
6. `ADDITIONAL_TF_OVERRIDE_LOCATIONS=../vpc-module,../ec2-module tflocal test`

Important: due to a limitation in the way tflocal handles the terraform context, you need to set the `ADDITIONAL_TF_OVERRIDE_LOCATIONS` environment variable to include the path to the VPC module. See the [tflocal documentation](https://github.com/localstack/terraform-local?tab=readme-ov-file#validation-errors-when-using-local-terraform-modules) for more information.

##### 2-complex-module-repo/ec2-module/tests/1-unit-test-minimal.tftest.hcl
This is again the bare minimum test case of a simple EC2 module. 
The main difference here is that the VPC module needs to be "setup" before the EC2 module can be tested. 
The EC2 module needs a subnet to be created in the VPC before it can be launched.
This is handled by the "setup" run where the vpc-module is instantiated. 

#### Run integration test

1. `cd demo/2-complex-module-repo/integration-test`
2. `tflocal init`
3. `tflocal test`

This test simply validates that the module is deployable and working. 
It should validate that the incoming dependencies work with the module. 
In this case that the EC2 instance can be launched successfully within the VPC.

### 3-orchestration-repo

This shows the example of an orchestration repo (an actual deployable repository)

In this example, the orchestration repo will include the necessary modules and their configurations to deploy a complete application stack.
The tests required for this setup should focus on the correct deployment of the modules, the correct composition of the modules dependencies and validate that the configuration is in line with any special requirements for the environment it's deployed in (E.g. validate that all resources have the correct tag.)

#### Run orchestration test

1. `cd demo/3-orchestration-repo`
2. `tflocal init`
2. `ADDITIONAL_TF_OVERRIDE_LOCATIONS=./tests/validate-instance,./tests/create-s3-object,./tests/validate-s3-object tflocal test`

Note: again the additional override location is needed to include the fixture modules in the tflocal override mechanism.

##### 3-orchestration-repo/tests/main.tftest.hcl
This file has 4 test fixtures: one to deploy the actual repository, a second one to validate the EC2 instance, one to deploy an S3 object and one to check the S3 object. 

The `validate-instance` module is used to fetch the instance details and validate that the instance has the expected IP address. 
These types of tests validate that the different modules interact as expected and the outcome of the deployed orchestration is what is desired. 
In a live scenario it's not recommended to check things like IP addresses as they tend to be more volatile, but it's a good showcase of how the additional information gathered throught the data blocks can be used to validate the configuration.

The second part of the test validate that S3 object can be created and validate that the correct encryption method is applied.
The `create-s3-object` module is responsible for creating the S3 object.
Note that this explicitly doesn't set the desired encryption method.
When fetching the object throught the data block in `validate-s3-object` the test can validate that the default SSE algorithm is applied.
