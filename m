Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6327741AF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbjHHRZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjHHRZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:25:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C91620279;
        Tue,  8 Aug 2023 09:10:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C39D162421;
        Tue,  8 Aug 2023 07:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A91C433C8;
        Tue,  8 Aug 2023 07:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691480750;
        bh=jZLZ8CvM1w8S1v7NoGQUVK+x9cqzTTPGM8CE6Cf2wK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c3JT8QVl0iYnnGmiuAOZLhPRFJIiZMB4T0Ziv9fvvob0fMIDp/iBsN723AVFuviBK
         pKqhQEgWlHTNIQm2jKRCHNBBxgn+91Pey3NF4zwh2LiT2m/8ddXte+Nm6plBTROk6y
         gsJ0ZXmOSxNz3l4I61bafdFENyHLtDNNE2TRwqYFRZGM9Hdx0tN7xt7TSTwY4vGYmH
         IfSRekzlpxdn0RFbH4a0gOlrlbpBjuDl0mxCtROX0ACxx099nrQ1xgOrgIy8/opvgd
         ddiQuo+p1t81oH2ASma1fXzq/MMm+qVkhA0EbkUM0hUkpNMHrANtYN16Agw9LJmugi
         2xf0N2/H9T5uw==
Date:   Tue, 8 Aug 2023 08:45:43 +0100
From:   Conor Dooley <conor@kernel.org>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 1/3] dt-bindings: arm: fsl: Add VAR-SOM-MX6 SoM with
 Custom Board
Message-ID: <20230808-whacky-bolt-7b0cc6efa619@spud>
References: <20230726123747.4097755-1-james.hilliard1@gmail.com>
 <20230726-frosted-scroll-a42298d2ee9c@spud>
 <CADvTj4oPKyAx3szHhvphJ+cCpvwWaLZiTfaWZdWYQrmU5Aymxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cZJT4Ut+zLXzEeG0"
Content-Disposition: inline
In-Reply-To: <CADvTj4oPKyAx3szHhvphJ+cCpvwWaLZiTfaWZdWYQrmU5Aymxg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cZJT4Ut+zLXzEeG0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 10:03:45AM -0600, James Hilliard wrote:
> On Wed, Jul 26, 2023 at 12:26=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Wed, Jul 26, 2023 at 06:37:39AM -0600, James Hilliard wrote:
> > > Add support for Variscite i.MX6Q VAR-SOM-MX6 SoM with Custom Board.
> > >
> > > Cc: Pierluigi Passaro <pierluigi.p@variscite.com>
> > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documen=
tation/devicetree/bindings/arm/fsl.yaml
> > > index 2510eaa8906d..76bb098605e7 100644
> > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > @@ -385,6 +385,12 @@ properties:
> > >            - const: toradex,apalis_imx6q
> > >            - const: fsl,imx6q
> > >
> > > +      - description: i.MX6Q Variscite VAR-SOM-MX6 Boards
> > > +        items:
> > > +          - const: variscite,mx6customboard
> > > +          - const: variscite,var-som-imx6q
> > > +          - const: fsl,imx6q
> >
> > I find it hard to tell what the sort order here is meant to be, but it
> > appears to be first by what I.MX processor and then by the board
> > compatibles? If so, this is added out of order.
>=20
> Ordering follows the same pattern as say the "Variscite VAR-SOM-MX8MM
> based boards", should it be different?

What I meant was I was not sure whether things were being sorted by the
contents of the description or by the compatible strings. I don't really
care which it is, I was hoping for an fsl platform maintainer to weigh
in.

If I hadn't already given one,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
for whatever way is opted for.

> > >        - description: TQ-Systems TQMa6Q SoM (variant A) on MBa6x
> > >          items:
> > >            - const: tq,imx6q-mba6x-a
> > > --
> > > 2.34.1
> > >

--cZJT4Ut+zLXzEeG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNHypwAKCRB4tDGHoIJi
0ukXAP925fH2UyTmnH2FBzBJXIHtFe4SLinXHe/BWu6YhI0FTAD/RiqVGO7QHt1p
seXgp94nw6DAc1ZAZjHdQSXmiTUlqQk=
=Q5Fm
-----END PGP SIGNATURE-----

--cZJT4Ut+zLXzEeG0--
