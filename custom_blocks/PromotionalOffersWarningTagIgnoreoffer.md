---
name: Promotional Offers - warning tag ignore-offer
---
> 🚧 Tag `ignore-offer` for Promotional Offers
>
> When creating Promotional offer (Developer determined offers that are meant to retain or win-back subscribers), don't forget to add the tag `ignore-offer` to indicate to the SDK that this offer cannot be proposed to new users. 
>
> <Image
>   alt="For developers determined offers, add the `ignore-offer` tag to avoid having the offer proposed to everyone
>
> "
>   align="center"
>   border={true}
>   src="https://files.readme.io/893c73e-image.png"
> >
>   For developers determined offers, add the `ignore-offer` tag to avoid having the offer proposed to everyone
> </Image>
>
> If you don't put this tag, **the offer will be proposed on standard paywalls to everyone** as there will be no way for the Purchasely SDK to know make the distinction with Introductory Offers (meant for acquisitions).
