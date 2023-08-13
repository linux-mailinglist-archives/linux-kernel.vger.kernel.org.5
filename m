Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D93177A5EA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 11:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjHMJz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 05:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjHMJz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 05:55:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96911708;
        Sun, 13 Aug 2023 02:55:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 667C060C4C;
        Sun, 13 Aug 2023 09:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DADC433C7;
        Sun, 13 Aug 2023 09:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691920528;
        bh=hfelxX0Xrk7Tyjxr1ZgPuM4NJn814LmlQLnTBPkiN4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLP1vMnjLVa0uefI5SS6xiDbhfY9VCPMLayAczh4axgQBSYPxFEDY4rgGlwiet4/p
         v4tMluem37SuWJQIR4Yu6EOZFaQxhEeaZqHD+sjR00VcDF04uyi9MzSIlpL/MrYtgR
         dJIHBuSaVC1UYIyiGiSWqQ661c3RwI/kkBQut9X+CfucFKvn6ArT2IYjhqDoZt7HEG
         9dvoKHtCc2zv7ADhmzXLk/7PcsuXmt4vIr4X+vPifcls1t3ltGxoQKEUKmc+yAMGUh
         v7eNsT8nz/yAev4RXQGNtvoG/JTI3g2YZVgFQToGH+FxdflR/oFbqEgI8thfkDphq7
         fpcaFGuWFYUTQ==
Date:   Sun, 13 Aug 2023 10:55:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: arm: ti: Add bindings for AM62P5 SoCs
Message-ID: <20230813-sleek-trash-16ea454e2640@spud>
References: <20230810045314.2676833-1-vigneshr@ti.com>
 <20230810045314.2676833-2-vigneshr@ti.com>
 <20230810-exile-accurate-790c6828133b@spud>
 <20230810184308.q67ldarld6qwo5uq@erased>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OpbEKqHF6/QfKMMU"
Content-Disposition: inline
In-Reply-To: <20230810184308.q67ldarld6qwo5uq@erased>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OpbEKqHF6/QfKMMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 01:43:08PM -0500, Nishanth Menon wrote:
> On 17:03-20230810, Conor Dooley wrote:
> > On Thu, Aug 10, 2023 at 10:23:12AM +0530, Vignesh Raghavendra wrote:
> > > From: Bryan Brattlof <bb@ti.com>
> > >=20
> > > Add bindings for TI's AM62P5 family of devices.
> > >=20
> > > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > > Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> > > ---
> > >  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Docum=
entation/devicetree/bindings/arm/ti/k3.yaml
> > > index 5ca6af492507..93b2774cc0a9 100644
> > > --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> > > @@ -25,6 +25,12 @@ properties:
> > >                - ti,am62a7-sk
> > >            - const: ti,am62a7
> > > =20
> > > +      - description: K3 AM62P5 SoC
> >=20
> > SoC seems a bit off here, since the sk is actually a board using the
> > SoC, but it seems to be the convention for TI stuff,
>=20
> Thanks for providing that perspective - there will be new boards
> getting added to the enum list, they should be one line additions at
> this point.
>=20
> But, your point taken. K3 AM625P SoC based boards is more appropriate.
>=20
> I can do the local change as I apply and keep your ack unless you
> object.

Oh totally no objection, "xyz SoC based boards" is what most people seem
to use.

>=20
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> >=20
> >=20
> > > +        items:
> > > +          - enum:
> > > +              - ti,am62p5-sk
> > > +          - const: ti,am62p5
> > > +
> > >        - description: K3 AM625 SoC PHYTEC phyBOARD-Lyra
> > >          items:
> > >            - const: phytec,am625-phyboard-lyra-rdk
> > > --=20
> > > 2.41.0
> > >=20
>=20
>=20
>=20
> --=20
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DD=
B5 849D 1736 249D

--OpbEKqHF6/QfKMMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNiojAAKCRB4tDGHoIJi
0nC+AP9ZBsvaZyYeYAH97lR4IraORYfU+eL/VzW/EK0R54eLjgEAhrO7j0EWsobm
YVTlLDnabi3ze5DLaDX8Z9FGWQQesAo=
=WVtK
-----END PGP SIGNATURE-----

--OpbEKqHF6/QfKMMU--
