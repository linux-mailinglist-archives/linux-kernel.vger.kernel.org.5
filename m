Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17AD7ED65F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343686AbjKOVzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjKOVzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:55:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB5A130;
        Wed, 15 Nov 2023 13:55:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C601CC433C8;
        Wed, 15 Nov 2023 21:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700085349;
        bh=rxsJVAoAJu2unPfsigseF5/Irjtoe5C4h3hDvuDI2LE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Of3bAt7/iGINyWvNQZ6aO11NPVyWkqaWSqUcTnN5DgrdWJnjBf5vMSlapIoXqI13q
         3+uq1fC1RxdSXHZLxYN7EHtSH2KXGoqZFcFBCwkYW/K1Sn335g3wKqbMwi1/V8pQSZ
         WKYByUY+at5vVcJUeA3sTzlv79gU8+qiu8aQQPKexioCYgnIEoL4WDw8bJ8t4A1S8t
         z414dDBb4r9jrmmsBi54/igZIpHd2lckkdzysZ8+K0vOGnH7S9mSkEPR832DYw21N6
         EhHsGVPh094xw2EiTP48X9221BgQSNE7bQ6Fe3OxRQIObraXE1qM8x/85zC5XeUaox
         7j70BoC8SslLQ==
Date:   Wed, 15 Nov 2023 21:55:44 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document
 RZ/Five SoC
Message-ID: <20231115-quartered-laborer-5b85a793b22c@squawk>
References: <20231115211829.32542-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gr/AzMSS6UTSjHeT"
Content-Disposition: inline
In-Reply-To: <20231115211829.32542-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gr/AzMSS6UTSjHeT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 09:18:29PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The USBPHY Control Device on the RZ/Five SoC is identical to one found on
> the RZ/G2UL SoC. "renesas,r9a07g043-usbphy-ctrl" compatible string will be
> used on the RZ/Five SoC so to make this clear and to keep this file
> consistent, update the comment to include RZ/Five SoC.
>=20
> No driver changes are required as generic compatible string
> "renesas,rzg2l-usbphy-ctrl" will be used as a fallback on RZ/Five SoC.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheerrs,
Conor,

> ---
>  .../devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy=
-ctrl.yaml b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-c=
trl.yaml
> index 731b8ce01525..03c18611e42d 100644
> --- a/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.y=
aml
> +++ b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.y=
aml
> @@ -17,7 +17,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> -          - renesas,r9a07g043-usbphy-ctrl # RZ/G2UL
> +          - renesas,r9a07g043-usbphy-ctrl # RZ/G2UL and RZ/Five
>            - renesas,r9a07g044-usbphy-ctrl # RZ/G2{L,LC}
>            - renesas,r9a07g054-usbphy-ctrl # RZ/V2L
>        - const: renesas,rzg2l-usbphy-ctrl
> --=20
> 2.34.1
>=20

--gr/AzMSS6UTSjHeT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVU+XQAKCRB4tDGHoIJi
0nfeAQDnpo8a0Uhwi2jyXQ/OXTuiym77GMgcTLswBWauxu/ElQD8D33bXpByurRp
ZfcEgGa0qPIB/8TCaeqeigs56yeQUgs=
=+i2M
-----END PGP SIGNATURE-----

--gr/AzMSS6UTSjHeT--
