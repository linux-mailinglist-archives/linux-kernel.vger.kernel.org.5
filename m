Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A822A7FF37E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346259AbjK3PWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346234AbjK3PWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:22:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D28B10E4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:22:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F112BC433C7;
        Thu, 30 Nov 2023 15:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701357772;
        bh=qkL/traqZYRhreQwWlBq0Fih3eZKxWuxg+IAiO0LgOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tH71F1PZXOL00uhIYMA+WMCwxITIiKNZ1KskmSoUJiUJMWY9VD5QKEueflTsxdnUl
         ZOhThyCyJ2adRZEs4xRiqwKRnxNwoFrwS+1GPoDJeAfYymcLiY1GXV29krH5jWdd7A
         /hiPxou8A0xW2GEQ1iSGg71JZBiuUFSdD3oMLA/yeog3qDSF3mSCHFCgFrSVpxIzAS
         mTuz523ozWSwy7Vuz9ZVNlNdK4MgR+TmbqTxCHf6dG0oeWuLmCdI+64yICbkm1d5gO
         KfO1YcygcRcO8WznF1NyEDB+XRMUarOT0cFaOFpRs75+bdO7CQ+FHknqgfkHkzYGSy
         P9P1+kO32rHaQ==
Date:   Thu, 30 Nov 2023 15:22:47 +0000
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
Message-ID: <20231130-snub-backshift-2f69754cf58f@spud>
References: <20231130053130.21966-1-linux.amoon@gmail.com>
 <20231130053130.21966-2-linux.amoon@gmail.com>
 <20231130-twig-stoning-58235b3195c8@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RlRi2l6ZtvVLk88M"
Content-Disposition: inline
In-Reply-To: <20231130-twig-stoning-58235b3195c8@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RlRi2l6ZtvVLk88M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 03:16:33PM +0000, Conor Dooley wrote:
> On Thu, Nov 30, 2023 at 11:01:26AM +0530, Anand Moon wrote:
> > Add the binding example for the USB3.1 Genesys Logic GL3523
> > integrates with USB 3.1 Gen 1 Super Speed and USB 2.0 High-Speed
> > hub.
> >=20
> > For onboard hub controllers that support USB 3.x and USB 2.0 hubs
> > with shared resets and power supplies, this property is used to identify
> > the hubs with which these are shared.
> >=20
>=20
> > [Conor Dooley: upgrade peer-hub description]
>=20
> This should not be in the commit message. Otherwise,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Cheers,
> Conor.
>=20
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v5: upgrade peer-hub description : Conor Dooley
> > [0] https://www.genesyslogic.com.tw/en/product_view.php?show=3D67 [Bloc=
k Diagram]
> > v4: Fix the description of peer-hub and update the commit message.
> > Schematics of the Odroid N2+
> > https://dn.odroid.com/S922X/ODROID-N2/Schematic/odroid-n2_rev0.6_202101=
21.pdf
> > V3: fix the dt_binding_check error, added new example for Genesys GL3523
> > v2: added Genesys GL3523 binding
> > v1: none
> > ---
> >  .../bindings/usb/genesys,gl850g.yaml          | 65 +++++++++++++++++--
> >  1 file changed, 61 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml =
b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > index ee08b9c3721f..499192ea4074 100644
> > --- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > +++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> > @@ -9,9 +9,6 @@ title: Genesys Logic USB hub controller
> >  maintainers:
> >    - Icenowy Zheng <uwu@icenowy.me>
> > =20
> > -allOf:
> > -  - $ref: usb-device.yaml#
> > -
> >  properties:
> >    compatible:
> >      enum:
> > @@ -27,12 +24,46 @@ properties:
> > =20
> >    vdd-supply:
> >      description:
> > -      the regulator that provides 3.3V core power to the hub.
> > +      phandle to the regulator that provides power to the hub.

Wait, why is this text changing? I don't see it mentioned anywhere why
this is no longer specifically 3.3v

Thanks,
Conor.

> > +
> > +  peer-hub:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      For onboard hub controllers that support USB 3.x and USB 2.0 hubs
> > +      with shared resets and power supplies, this property is used to =
identify
> > +      the hubs with which these are shared.
> > =20
> >  required:
> >    - compatible
> >    - reg
> > =20
> > +allOf:
> > +  - $ref: usb-device.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - usb5e3,608
> > +    then:
> > +      properties:
> > +        peer-hub: false
> > +        vdd-supply: false
> > +        reset-gpios: true
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - usb5e3,610
> > +              - usb5e3,620
> > +    then:
> > +      properties:
> > +        peer-hub: true
> > +        vdd-supply: true
> > +        reset-gpios: true
> > +
> >  additionalProperties: false
> > =20
> >  examples:
> > @@ -49,3 +80,29 @@ examples:
> >              reset-gpios =3D <&pio 7 2 GPIO_ACTIVE_LOW>;
> >          };
> >      };
> > +
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    usb {
> > +        dr_mode =3D "host";
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        /* 2.0 hub on port 1 */
> > +        hub_2_0: hub@1 {
> > +            compatible =3D "usb5e3,610";
> > +            reg =3D <1>;
> > +            peer-hub =3D <&hub_3_0>;
> > +            reset-gpios =3D <&gpio 20 GPIO_ACTIVE_LOW>;
> > +            vdd-supply =3D <&vcc_5v>;
> > +        };
> > +
> > +        /* 3.1 hub on port 4 */
> > +        hub_3_0: hub@2 {
> > +            compatible =3D "usb5e3,620";
> > +            reg =3D <2>;
> > +            peer-hub =3D <&hub_2_0>;
> > +            reset-gpios =3D <&gpio 20 GPIO_ACTIVE_LOW>;
> > +            vdd-supply =3D <&vcc_5v>;
> > +        };
> > +    };
> > --=20
> > 2.42.0
> >=20



--RlRi2l6ZtvVLk88M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWioxwAKCRB4tDGHoIJi
0kyvAP4mrFsSqjulILny2yGh8/2PbF9zjOgQLnavgZb2aA1pOwEAlbokM8AGRXLE
vImZQShoC/U9RPHihysDgZlZ1qae1Aw=
=xGZx
-----END PGP SIGNATURE-----

--RlRi2l6ZtvVLk88M--
