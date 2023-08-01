Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9607F76B8AB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjHAPfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjHAPfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:35:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4117FD;
        Tue,  1 Aug 2023 08:35:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A2F8615FF;
        Tue,  1 Aug 2023 15:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB786C433C8;
        Tue,  1 Aug 2023 15:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690904120;
        bh=+cwvm7KqAYEm8igIi7EJmbzhx3t4jk8qmDFYGUbK1n8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OEmQalPsnPZe5dV5+HC17mkbP5qQeyzyCPOd5J1148jUqRy9K+BautyRWQhFMVmog
         QRra3+auWfmx+HwaVsac532wVtXfvuEBF5k/SPQSkViXMBif43d5Wo05aBB6FrKjmD
         9nIgAsyhls9lr4/Njqv+fSJQ7ADkALfducrSizI/qNt5sjbXUgf82UT11S46dPEMtZ
         0x4JWlcetqAsatuP1NbVmou5Tin60CL/F00blsnWlEY4rwbUHW4hB24Jh67uDK3DCo
         hc/i7pKa0fqFz5exHyEqtC3UKMsIX2uGvKdqTM/v/G/i0qm4lChIYiFDpevZYtQ7Fm
         WMTN/woDCkS3A==
Date:   Tue, 1 Aug 2023 16:35:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Mihai Sain <mihai.sain@microchip.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        andre.przywara@arm.com, andrei.simion@microchip.com,
        jerry.ray@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        cristian.birsan@microchip.com
Subject: Re: [PATCH 1/2] dt-bindings: ARM: at91: Document Microchip SAMA5D29
 Curiosity
Message-ID: <20230801-unbalance-baguette-cd0d4e7e0107@spud>
References: <20230801111151.6546-1-mihai.sain@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="di4kJkj0aDyLBh4/"
Content-Disposition: inline
In-Reply-To: <20230801111151.6546-1-mihai.sain@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--di4kJkj0aDyLBh4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Aug 01, 2023 at 02:11:50PM +0300, Mihai Sain wrote:
> From: Andrei Simion <andrei.simion@microchip.com>
>=20
> Document device tree binding of SAMA5D29 Curiosity, from Microchip.
>=20
> Reviewed-by: Mihai Sain <mihai.sain@microchip.com>
> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>

Your SoB is missing from here.

> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Docu=
mentation/devicetree/bindings/arm/atmel-at91.yaml
> index dfb8fd089197..89d75fbb1de4 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> @@ -79,6 +79,13 @@ properties:
>            - const: atmel,sama5d2
>            - const: atmel,sama5
> =20
> +      - description: Microchip SAMA5D29 Curiosity
> +        items:
> +          - const: microchip,sama5d29-curiosity
> +          - const: atmel,sama5d29
> +          - const: atmel,sama5d2
> +          - const: atmel,sama5

What is the benefit of adding the two familial compatibles? Is there
software that actually uses these?

Thanks,
Conor.

> +
>        - items:
>            - const: atmel,sama5d27
>            - const: atmel,sama5d2
> --=20
> 2.41.0
>=20

--di4kJkj0aDyLBh4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMkmMwAKCRB4tDGHoIJi
0gCxAPwLg4OkKMAdyQsxsIrHt/o8duTRmkAL09SwVKGyqc/NvQD+IgKaOpPQrPg6
3wQ2YL6yd7uHCMTwNJR1qOstN+Fgug8=
=kiwg
-----END PGP SIGNATURE-----

--di4kJkj0aDyLBh4/--
