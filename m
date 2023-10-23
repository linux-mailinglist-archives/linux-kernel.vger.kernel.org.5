Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3817D3C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjJWQTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbjJWQTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:19:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676FFC1;
        Mon, 23 Oct 2023 09:19:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0B4C433C9;
        Mon, 23 Oct 2023 16:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698077971;
        bh=2yoJUFciYjOGBPAKWjjWU0kAwyU1Itk6s1tGuUXNy9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ocyl6RJle/R2/8cViurxiFrtIssXCSYTIV2gwxm9RYSl/AqO4DKoG4L9vgATnJNep
         uhjw7AfIAwNGMtAkbKWdqI3z/jYgaL8PcwYjKPe/RTwz3rYmiBBOdVxVgqJkj+FWOK
         m/kfldvRoSgyBKmas8FxBTX+Xhjy061f+bZI5TA5tlxMCeq3iNAl8+AraL2KHetvSW
         J0PWb5huCqtK1f72NZc3wHnX4/ebjSosi6RfTsu1Wcd3iCA/l+gp6MpNEZNlW0JbFE
         SuYiAQz4sSIHBKEUkkLjqBIWhAL8xARYmCOp1KVpghzvHqWUtKKsRCnVdC8uJ0BI01
         E4P7V+vNfwzrg==
Date:   Mon, 23 Oct 2023 17:19:26 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 1/7] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: document RZ/G3S
Message-ID: <20231023-snuff-dish-3b9df076a82c@spud>
References: <20231023102223.1309614-1-claudiu.beznea.uj@bp.renesas.com>
 <20231023102223.1309614-2-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xG0STj7p0zR8eqpn"
Content-Disposition: inline
In-Reply-To: <20231023102223.1309614-2-claudiu.beznea.uj@bp.renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xG0STj7p0zR8eqpn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 01:22:17PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Document RZ/G3S (R9108G045) interrupt controller. This has few extra
> functionalities compared with RZ/G2UL but the already existing driver
> could still be used.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../bindings/interrupt-controller/renesas,rzg2l-irqc.yaml    | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renes=
as,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller=
/renesas,rzg2l-irqc.yaml
> index 2ef3081eaaf3..d3b5aec0a3f7 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2=
l-irqc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2=
l-irqc.yaml
> @@ -26,6 +26,7 @@ properties:
>            - renesas,r9a07g043u-irqc   # RZ/G2UL
>            - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
>            - renesas,r9a07g054-irqc    # RZ/V2L
> +          - renesas,r9a08g045-irqc    # RZ/G3S
>        - const: renesas,rzg2l-irqc
> =20
>    '#interrupt-cells':
> @@ -167,7 +168,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: renesas,r9a07g043u-irqc
> +            enum:
> +              - renesas,r9a07g043u-irqc
> +              - renesas,r9a08g045-irqc
>      then:
>        properties:
>          interrupts:
> --=20
> 2.39.2
>=20

--xG0STj7p0zR8eqpn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTadDgAKCRB4tDGHoIJi
0nhyAP9SX2WimXDhWIXmlpXodQDFM9Ac9Cx28m1XUil6xBpgaAEA7i4+bh6j8a7g
pi+v0G2iUHncBtDHx7yE/n+l7wP1MAA=
=vzkc
-----END PGP SIGNATURE-----

--xG0STj7p0zR8eqpn--
