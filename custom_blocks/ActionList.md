---
name: Action list
---
* **`Purchase`**: a tap on the button will trigger an In-App Purchase Flow.

  * The Plan (and optionally the Promotional Offer) can be associated directly to the button

    <Image align="center" className="border" width="350px" border={true} src="https://files.readme.io/5c5b3ec3c1d50224d93c190df7fde475a2b44e8e24093e57d2f80c19bdcdf2d9-image.png" />

    <br />
* **`Promo code`**: a tap on the button will trigger the Promo code redemption flow. 

  * On iOS, the promo-code can be redeemed in the app: in this case the user has to enter the promo code manually (which means that you should display it on the Screen itself)

    <Image align="center" className="border" width="350px" border={true} src="https://files.readme.io/1b204eb3a5c130492d6d9d3ce79286e283577b48512388b6367f75f573122e43-image.png" />

    <br />
  * Or inside the App Store: in this case you must enter the associated promo code. The user will be redirected in the App Store to redeem it and the promo code will be pre-filled.

    <Image align="center" className="border" width="350px" border={true} src="https://files.readme.io/e00a11846fcdf7bf0e6391d5d6f4b37eaf70ac5375f603aff1f304d92436d3ec-image.png" />

    <br />
* **`Open placement`**: a tap on the button will open the associated Placement

  <Image align="center" className="border" width="350px" border={true} src="https://files.readme.io/120373d99c7860b23f8b3a1f93261cb6cb4529176ffc97c76edf612eda737ddd-image.png" />

  <br />
* **`Open Screen`**: a tap on the button will open the associated Screen

  <Image align="center" className="border" width="350px" border={true} src="https://files.readme.io/e2232587a64bc37ca21126ef0e7b89b02a7e8f9629876d1b0ec1d38fa8ab9ed1-image.png" />
* **`Deeplink`**: a tap on the button will open the associated deeplink

  <Image align="center" className="border" width="350px" border={true} src="https://files.readme.io/84cbd05b95862d1db36fae40e31b33f3710f14eb9f71eb505847c65be1ae9828-image.png" />

  <br />
* **`Web page`**: a tap on the button will open the associated web page in the web browser

  <Image align="center" className="border" width="350px" border={true} src="https://files.readme.io/d9aa81b04c800121abd7eb93114e08f7e2ec090b50fbda961f76310f4a8386c9-image.png" />

  <br />
* **`Login`**: a tap on the button will handover the control to the app (using the [Paywall action interceptor](paywall-action-interceptor)) and provide the value "Login", so that the app can display the sign-in form

  <Image align="center" className="border" width="350px" border={true} src="https://files.readme.io/49edbd8677ccde4a5549e75989f5ea2f303fab11df8b115dd6d3605b5f999b3c-image.png" />

  <br />
* **`Restore`**: a tap on the button will trigger the restore purchases action

  <Image align="center" className="border" width="350px" border={true} src="https://files.readme.io/e5c955ceae6422d69ad5d43b5d27af495af305f4188b4b3e828da53689abd250-image.png" />

  <br />
* **`Close`:** a tap on the button will close the current Screen

  <Image align="center" className="border" width="350px" border={true} src="https://files.readme.io/82303895d5d6b17c0b5f8729a0e254afcf0bffdb5e1567216afc84e217e04d97-image.png" />

  <br />
* **`Close all`**: a tap on the button will close the current Screen and all the Purchasely Screens previously opened

  <Image align="center" className="border" width="350px" border={true} src="https://files.readme.io/0b8e4dc98a0410e66c5c60b8f45a95c5df90be1e4ba367db5e8c245de7412006-image.png" />

  <br />
