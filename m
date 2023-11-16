Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96EE7EE62D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345356AbjKPRyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKPRyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:54:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF3A126
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:54:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5D5C433C8;
        Thu, 16 Nov 2023 17:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700157258;
        bh=y8eFS6dl8OZQt7xyX9mow8MlruoXZo3WcMeBbYxVhcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p3hbPSNTkZmgKqFxus5EZggFA2A4fn5RRIa2wG/hRfCNCfsqEIiuursx3IwSgoU1w
         suBvk/M6dg2EnjQj7x33oDeDwMzjut8XKNVX9Omqdk7qJADHPXHsAmVU6vtuJEAL6g
         W5jRH5NMq/0jVkIwTyNYKLmmEoKmI+/5YGEtz0ECWFtq/aznLIGasmTRKQtYFs6CX2
         A2mjP1/RGMkAEE6IdHY5o+3FkIHdiM/fSSePAGKeF7jMT14D8dOimMr4vWpi5hpcRV
         MT2xr97YYRAuJ/J05oa5zZ61vr27xHP4HNJVpWzuOnDr5eyQ202j1IdEdpz8M+Z10x
         FocS5sYEQYmZA==
Date:   Thu, 16 Nov 2023 17:54:13 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     mitrutzceclan <mitrutzceclan@gmail.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, andy@kernel.org, linux-gpio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: adc: add AD7173
Message-ID: <20231116-spousal-mystify-dcd1d4fec7e6@squawk>
References: <20231116134655.21052-1-user@HYB-hhAwRlzzMZb>
 <44cfcd9a-f139-479b-85ff-5fd23c9714b2@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="esKPrMVRLJw2O/9X"
Content-Disposition: inline
In-Reply-To: <44cfcd9a-f139-479b-85ff-5fd23c9714b2@linaro.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--esKPrMVRLJw2O/9X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 03:54:13PM +0100, Krzysztof Kozlowski wrote:
> On 16/11/2023 14:46, mitrutzceclan wrote:
> > From: Dumitru Ceclan <mitrutzceclan@gmail.com>
> >=20
> > The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> > which can be used in high precision, low noise single channel applicati=
ons
> > or higher speed multiplexed applications. The Sigma-Delta ADC is intend=
ed
> > primarily for measurement of signals close to DC but also delivers
> > outstanding performance with input bandwidths out to ~10kHz.
> >=20
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com> # except referen=
ce_select
>=20
> Please drop the tag. You clearly did not test it, so it must be
> re-reviewed. Do not send code which was not tested.

yeah, this is vastly different from what I reviewed. I suppose if
someone finds it necessary to add a "# except foo" to the end of a tag
it is very good signifier that the tag should in fact be removed.

>=20
> > Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> > ---
> > V3 -> V4
> >  - include supply attributes
> >  - add channel attribute for selecting conversion reference
> >=20
> >  .../bindings/iio/adc/adi,ad7173.yaml          | 166 ++++++++++++++++++
> >  1 file changed, 166 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad717=
3.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> > new file mode 100644
> > index 000000000000..92aa352b6653
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> > @@ -0,0 +1,166 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2023 Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7173.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD7173 ADC device driver
>=20
> Drop: device driver
>=20
> Bindings are for hardware.
>=20
> > +
> > +maintainers:
> > +  - Ceclan Dumitru <dumitru.ceclan@analog.com>
> > +
> > +description: |
> > +  Bindings for the Analog Devices AD717X ADC's. Datasheets for support=
ed chips:
> > +    https://www.analog.com/media/en/technical-documentation/data-sheet=
s/AD7172-2.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheet=
s/AD7173-8.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheet=
s/AD7175-2.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheet=
s/AD7176-2.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad7172-2
> > +      - adi,ad7173-8
> > +      - adi,ad7175-2
> > +      - adi,ad7176-2
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +  spi-max-frequency:
> > +    maximum: 20000000
> > +
> > +  refin-supply:
> > +    description: external reference supply, can be used as reference f=
or conversion.
> > +
> > +  refin2-supply:
> > +    description: external reference supply, can be used as reference f=
or conversion.
> > +
> > +  avdd-supply:
> > +    description: avdd supply, can be used as reference for conversion.
> > +
> > +  dependencies:
>=20
> Nope, needs testing... See also example-schema.
>=20
>=20
> > +    refin2-supply:
> > +      properties:
> > +        compatible:
> > +          adi,ad7173-8
> > +
> > +  required:
>=20
> Please open example schema and put it in similar place.
>=20
> > +    - compatible
> > +    - reg
> > +    - interrupts
> > +
> > +patternProperties:
> > +  "^channel@[0-9a-f]$":
> > +    type: object
> > +    $ref: adc.yaml
> > +    unevaluatedProperties: false
> > +
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 15
> > +
> > +      diff-channels:
> > +        items:
> > +          minimum: 0
> > +          maximum: 31
> > +
> > +      adi,reference-select:
> > +        description: |
> > +          Select the reference source to use when converting on
> > +          the specific channel. Valid values are:
> > +          0: REFIN(+)/REFIN(=E2=88=92).
> > +          1: REFIN2(+)/REFIN2(=E2=88=92)
> > +          2: REFOUT/AVSS (Internal reference)
> > +          3: AVDD
> > +
> > +          External reference 2 only available on ad7173-8.
> > +          If not specified, internal reference used.
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        enum: [0, 1, 2, 3]
> > +        default: 2

I really don't like these properties where integers are mapped to
functionalities like this. I'd much rather see a enum of strings where
the meaning for these things can be put in & there's no need to look up
the binding to figure out what "adi,reference-select =3D <3>" means.
For example having "refin", "refin2", "refout-avss" & "avdd" as the
options and therefore "adi,reference-select =3D "avdd" in a devicetree is
a lot more understandable IMO.


Cheers,
Conor.

> > +
> > +      bipolar:
> > +        type: boolean
> > +
> > +    required:
> > +      - reg
> > +      - diff-channels
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: adi,ad7173-8
> > +    then:
>=20
> ??? Maybe you want to use "not"?
>=20
> > +    else:
>=20
> > +      patternProperties:
> > +        "^channel@[0-9a-f]$":
> > +          properties:
> > +            enum: [0, 2, 3]
> > +
> > +unevaluatedProperties: false
> > +
>=20
> Best regards,
> Krzysztof
>=20

--esKPrMVRLJw2O/9X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVZXPwAKCRB4tDGHoIJi
0hUDAPdjZjcsiNy/vVJdyjREO1Ge/SU9glgPFwQpHxIOZJrqAP9cbEHhajGJgx9s
3poiKjiTyKlIZg/Ls691B5MeTt6RDQ==
=+iDh
-----END PGP SIGNATURE-----

--esKPrMVRLJw2O/9X--
