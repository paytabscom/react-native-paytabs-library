# Steps to configure Apple Pay with PayTabs

Follow the steps to help you easily configure your Apple Pay with PayTabs

1. Add Apple Pay capability to your ptoject 
 	 * Click on ➕ to add a new capability
	![](https://user-images.githubusercontent.com/95287975/179398956-07de1619-bf2a-4225-8230-03f2f14bf43c.png)
	* Choose Apple pay
	![](https://user-images.githubusercontent.com/95287975/179398957-75206ded-3641-4f62-ada8-ee6766870e13.png)
	* Add the new merchant id
	![](https://user-images.githubusercontent.com/95287975/179398955-1da22b7d-401c-4755-9f32-216ff904c7a4.png)

2. Generate CSR via [PayTabs Portal](https://merchant.paytabs.com)

	* Navigate to PayTabs [Certificate Management](https://merchant.paytabs.com/merchant/developers/certs).
	![](https://user-images.githubusercontent.com/69899730/106730917-911fe680-6617-11eb-952f-ef12a544c916.jpg)
	* Click on ➕ to add a request for certificate.
	![](https://user-images.githubusercontent.com/69899730/106731208-e65bf800-6617-11eb-8404-d25bc1b39944.jpg)
	* Wait the proccess to be finished, then download the certificate file. 
	![](https://user-images.githubusercontent.com/69899730/106731229-ecea6f80-6617-11eb-878e-7ce508b8f1e1.jpg)

3. Create Apple Pay certificate via your account on [Apple Developer](http://developer.apple.com)
	* Navigate to the Certificates, Identifiers & Profiles, then click on **Add** certificate button.
	![](https://user-images.githubusercontent.com/69899730/106731619-58ccd800-6618-11eb-8f38-c4917aca5cf9.jpg)
	* Check the option **Apple Pay Payment Processing Certificate** under the section **Services**, then click on **Continue** button.
	![](https://user-images.githubusercontent.com/69899730/106731955-caa52180-6618-11eb-853f-5757e9b7420a.jpg)
	* Choose the **Merchant ID** from the dropdown list, then click on **Continue** button.
	![](https://user-images.githubusercontent.com/69899730/106731628-5a969b80-6618-11eb-9968-8ac35dff97d8.jpg)
	* Click on **Create Certificate** button under the section **Apple Pay Payment Processing Certificate**.
	![](https://user-images.githubusercontent.com/69899730/106731960-cbd64e80-6618-11eb-8785-ba599f2f2ddc.jpg)
	* Click on **Choose File** to select the certificate file you downloaded from PayTabs portal in step 1, then clikc on **Continue** button.
	![](https://user-images.githubusercontent.com/69899730/106731964-cd077b80-6618-11eb-9a9e-d065c74ce244.jpg)
	* Download your certificate to your Mac, then double click the **.cer** file to install in **Keychain Access**.
	![](https://user-images.githubusercontent.com/69899730/106732177-0b049f80-6619-11eb-86b9-9ddee2b6c35e.jpg)
	
4. Upload your certificate to PayTabs portal.
	* Navigate to [PayTabs Certificate Management](https://merchant.paytabs.com/merchant/developers/certs).
		
	* Enter the **Merchant ID** under the section **COMPLETE CERTIFICATE REQUEST**, then choose the **.cer** file you downloaded in step 2 and click on **Save** button.
	![](https://user-images.githubusercontent.com/69899730/106732182-0cce6300-6619-11eb-924f-469cb21e83d7.jpg)
	* Congratulations, Your certificate request completed successfully, your PayTabs profile is now ready for doing payment using Apple Pay.
	![](https://user-images.githubusercontent.com/69899730/106732184-0d66f980-6619-11eb-8951-ac799e66d8e1.jpg)
	