Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D222076D245
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbjHBPjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbjHBPjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:39:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB9D2D72;
        Wed,  2 Aug 2023 08:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BF3D61A11;
        Wed,  2 Aug 2023 15:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4489C433C8;
        Wed,  2 Aug 2023 15:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690990752;
        bh=+26frRLbvBpbYBKLmJbCxTJ/vpdqT+JFg+ruN1qp2TI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=moG/CIIHh4jSEEMJTLNu8/lHpH+QeCZqw1zh6+nhnGf04Yb5nvwOm2gdI0JrMG9Mc
         OMn+4YpFX7bWq/+9VbFGIeA8KDn32BxQyD5KYpG72dNNC5LsLtAsMdrjG8Lgaf9MIg
         tR/T9dxm9K8EOQt22jHWnho9Q/JKLknjvMnzVqvcxLjyanCab4zEso9bdFJKtnRWoU
         1Ho7ItAhXLN2zgEYy0uIndcyRHY0AcIsa+V5NWFBRlO8da6Buovhm5sI4+C0PwP3NW
         27VEoz2RcLoYB3k6HyCdmmtoVMPXxHvuf1WTheKzGMLc4MtyNmoYpLLzPDfSEsLzvC
         Ejdr3KndY2O8Q==
Date:   Wed, 2 Aug 2023 16:39:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Mihai.Sain@microchip.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com,
        andre.przywara@arm.com, Andrei.Simion@microchip.com,
        Jerry.Ray@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian.Birsan@microchip.com
Subject: Re: [PATCH 1/2] dt-bindings: ARM: at91: Document Microchip SAMA5D29
 Curiosity
Message-ID: <20230802-scoring-pony-0cb3ad094018@spud>
References: <20230801111151.6546-1-mihai.sain@microchip.com>
 <20230801-unbalance-baguette-cd0d4e7e0107@spud>
 <PH8PR11MB6804073D5A1F26D8699756F8820BA@PH8PR11MB6804.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="99q6Lptlzcoa5Bia"
Content-Disposition: inline
In-Reply-To: <PH8PR11MB6804073D5A1F26D8699756F8820BA@PH8PR11MB6804.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--99q6Lptlzcoa5Bia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 12:42:52PM +0000, Mihai.Sain@microchip.com wrote:
> On Tue, Aug 01, 2023 at 02:11:50PM +0300, Mihai Sain wrote:

> > ---
> >  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml=20
> > b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> > index dfb8fd089197..89d75fbb1de4 100644
> > --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> > +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> > @@ -79,6 +79,13 @@ properties:
> >            - const: atmel,sama5d2
> >            - const: atmel,sama5
> > =20
> > +      - description: Microchip SAMA5D29 Curiosity
> > +        items:
> > +          - const: microchip,sama5d29-curiosity
> > +          - const: atmel,sama5d29
> > +          - const: atmel,sama5d2
> > +          - const: atmel,sama5
>=20
> What is the benefit of adding the two familial compatibles? Is there soft=
ware that actually uses these?
>=20
> Thanks,
> Conor.
>=20
> Currently there is no software.
> In this file we've just documented the previous boards from sam9, sama5, =
sama7 MPUs.

Please fix your quoting. If no software cares about this, what is the
benefit of adding familial compatibles?

--99q6Lptlzcoa5Bia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMp4mwAKCRB4tDGHoIJi
0piVAP9G3ga7bbRbo8QSR420Fhqag5yUVcino8bfFrLs7ssDaQEA/X+Kkb3OBTGT
ET5ozafhFE9pZqdveoRIppIc0UnOtwM=
=TrOH
-----END PGP SIGNATURE-----

--99q6Lptlzcoa5Bia--
