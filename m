Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027B27FF349
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346154AbjK3PQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjK3PQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:16:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E571B4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:16:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAAAC433C7;
        Thu, 30 Nov 2023 15:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701357397;
        bh=cg7d/rMg3I2RsFPBbUzQIS4hsFzEfYLgoptbAfC9TqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jC6E0aAcM/h8zOAIvwpIVcj1iDnJtDO73UOMNtVkX+lVIb5h3XHTDFoYsvhwIz7dF
         eOjkHqXsNH19eIAuC22YjkHD7QZ9hgtXqA1MylD8Le9wvQ+t/8KRsPQ1ejoQaLe7Ag
         CSfRst5jB3YOMrZvG9kslP6I+rob9EuVvXNJuhTAm3wWRYrhTXPfVowVyN6RCwfqSB
         muHrWl3/RZUJU5L8BfnJXTIR6AvYRfu0QDrMC2eXK7VTMO++DpmrzPkxjs+dJipOwQ
         ydM8mq4Zgaf2/I9JHwXB8BUvwH/Ezry8DGpScCQaXaOOfVKgSn6ZR5VT8L8T/6623M
         zMYxiSr5rFqEA==
Date:   Thu, 30 Nov 2023 15:16:33 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: usb: Add the binding example for the
 Genesys Logic GL3523 hub
Message-ID: <20231130-twig-stoning-58235b3195c8@spud>
References: <20231130053130.21966-1-linux.amoon@gmail.com>
 <20231130053130.21966-2-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lTL/T6EYqFtp7uZi"
Content-Disposition: inline
In-Reply-To: <20231130053130.21966-2-linux.amoon@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lTL/T6EYqFtp7uZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 11:01:26AM +0530, Anand Moon wrote:
> Add the binding example for the USB3.1 Genesys Logic GL3523
> integrates with USB 3.1 Gen 1 Super Speed and USB 2.0 High-Speed
> hub.
>=20
> For onboard hub controllers that support USB 3.x and USB 2.0 hubs
> with shared resets and power supplies, this property is used to identify
> the hubs with which these are shared.
>=20

> [Conor Dooley: upgrade peer-hub description]

This should not be in the commit message. Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v5: upgrade peer-hub description : Conor Dooley
> [0] https://www.genesyslogic.com.tw/en/product_view.php?show=3D67 [Block =
Diagram]
> v4: Fix the description of peer-hub and update the commit message.
> Schematics of the Odroid N2+
> https://dn.odroid.com/S922X/ODROID-N2/Schematic/odroid-n2_rev0.6_20210121=
=2Epdf
> V3: fix the dt_binding_check error, added new example for Genesys GL3523
> v2: added Genesys GL3523 binding
> v1: none
> ---
>  .../bindings/usb/genesys,gl850g.yaml          | 65 +++++++++++++++++--
>  1 file changed, 61 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/=
Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> index ee08b9c3721f..499192ea4074 100644
> --- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> +++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> @@ -9,9 +9,6 @@ title: Genesys Logic USB hub controller
>  maintainers:
>    - Icenowy Zheng <uwu@icenowy.me>
> =20
> -allOf:
> -  - $ref: usb-device.yaml#
> -
>  properties:
>    compatible:
>      enum:
> @@ -27,12 +24,46 @@ properties:
> =20
>    vdd-supply:
>      description:
> -      the regulator that provides 3.3V core power to the hub.
> +      phandle to the regulator that provides power to the hub.
> +
> +  peer-hub:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      For onboard hub controllers that support USB 3.x and USB 2.0 hubs
> +      with shared resets and power supplies, this property is used to id=
entify
> +      the hubs with which these are shared.
> =20
>  required:
>    - compatible
>    - reg
> =20
> +allOf:
> +  - $ref: usb-device.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - usb5e3,608
> +    then:
> +      properties:
> +        peer-hub: false
> +        vdd-supply: false
> +        reset-gpios: true
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - usb5e3,610
> +              - usb5e3,620
> +    then:
> +      properties:
> +        peer-hub: true
> +        vdd-supply: true
> +        reset-gpios: true
> +
>  additionalProperties: false
> =20
>  examples:
> @@ -49,3 +80,29 @@ examples:
>              reset-gpios =3D <&pio 7 2 GPIO_ACTIVE_LOW>;
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    usb {
> +        dr_mode =3D "host";
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        /* 2.0 hub on port 1 */
> +        hub_2_0: hub@1 {
> +            compatible =3D "usb5e3,610";
> +            reg =3D <1>;
> +            peer-hub =3D <&hub_3_0>;
> +            reset-gpios =3D <&gpio 20 GPIO_ACTIVE_LOW>;
> +            vdd-supply =3D <&vcc_5v>;
> +        };
> +
> +        /* 3.1 hub on port 4 */
> +        hub_3_0: hub@2 {
> +            compatible =3D "usb5e3,620";
> +            reg =3D <2>;
> +            peer-hub =3D <&hub_2_0>;
> +            reset-gpios =3D <&gpio 20 GPIO_ACTIVE_LOW>;
> +            vdd-supply =3D <&vcc_5v>;
> +        };
> +    };
> --=20
> 2.42.0
>=20

--lTL/T6EYqFtp7uZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWinUQAKCRB4tDGHoIJi
0oBYAP9EyD0nfaT0/sje8xRsy43bcV3tjUrZMC7tQBdSN1URWwEAj3HN3gY9KtkI
O/bdedDkZGY3dMMNQVG2guKxWaU4+wo=
=yrvD
-----END PGP SIGNATURE-----

--lTL/T6EYqFtp7uZi--
