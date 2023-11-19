Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6345D7F0671
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 14:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjKSNex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 08:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjKSNev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 08:34:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2D5138
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 05:34:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9934FC433C8;
        Sun, 19 Nov 2023 13:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700400880;
        bh=gRy63m5oP/eWC/wD8dCNRHAQkB1ST3bcQJr/HYdhsh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oz9FhMObmBmJL//1ggZ/WYka61XnaOKnxASiIecv4k2Ck/fiaD+P/ymRKE8ICOeOW
         FGsejM8suwiVXBkj5t+hY1GLgTzaEF5AZC12Yu53VeXjNZjsI9Tg2UZMO4EbZ+RUKn
         1V5prOlZxOsG6GI6TZJWbmAMZd8NzJRI0Ja3EDS9eXTzx2Js4AI5FpJ31x373wiBAo
         ofneWTeA+1rxC2YhaA123MP6BefDoLYozE5MbdYHq7EhKgDyid+Z34wvb3HexQLa/k
         UbEn+23GI+ZcR9mb4LoBMX3QBJ+G9Zbtmbes+WbhQ8DSgYGyVPrebkreEc2H2yAQZp
         6KPTouC5iSZSg==
Date:   Sun, 19 Nov 2023 13:34:35 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Elad Nachman <enachman@marvell.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, pali@kernel.org,
        mrkiko.rs@gmail.com, chris.packham@alliedtelesis.co.nz,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, cyuval@marvell.com
Subject: Re: [PATCH v5 2/3] dt-bindings: arm64: add Marvell COM Express boards
Message-ID: <20231119-avatar-implicate-75cd2f12dff5@spud>
References: <20231119102638.1041978-1-enachman@marvell.com>
 <20231119102638.1041978-3-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bpE9nlwIO/xMULOZ"
Content-Disposition: inline
In-Reply-To: <20231119102638.1041978-3-enachman@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bpE9nlwIO/xMULOZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 12:26:37PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
>=20
> Add dt bindings for:
> CN9130 COM Express CPU module

Did you forget this one? There's only the CN9191 system here.

> CN9131 COM Express CPU module
> AC5X RD COM Express Type 7 carrier board.
> AC5X RD COM Express board with a CN9131 COM Express Type 7 CPU module.
>=20
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  .../bindings/arm/marvell/armada-7k-8k.yaml           | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.y=
aml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
> index 52d78521e412..6b19f23bcf63 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
> @@ -60,4 +60,16 @@ properties:
>            - const: marvell,armada-ap807-quad
>            - const: marvell,armada-ap807
> =20
> +      - description:
> +            Alleycat5X (98DX35xx) Reference Design as COM Express Carrie=
r plus
> +            Armada CN9131 COM Express CPU module
> +        items:
> +          - enum:
> +              - marvell,ac5x-car-with-cn9131

Why not just marvell,cn9131-ac5x-carrier or similar? The "with" isn't
particularly helpful.

Cheers,
Conor.

> +          - const: marvell,rd-ac5x-carrier
> +          - const: marvell,cn9131-cpu-module
> +          - const: marvell,cn9131
> +          - const: marvell,armada-ap807-quad
> +          - const: marvell,armada-ap807
> +
>  additionalProperties: true
> --=20
> 2.25.1
>=20

--bpE9nlwIO/xMULOZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVoO6wAKCRB4tDGHoIJi
0kxzAQDIfFI+4D2QNGfT6wBPbYpCaJ1MkWDRfkjLXjPko/hmegEAjvIIcJgfVeUr
PLVO2PiimvxVQH4b9rJT75dpFQOHYwM=
=7ZHL
-----END PGP SIGNATURE-----

--bpE9nlwIO/xMULOZ--
