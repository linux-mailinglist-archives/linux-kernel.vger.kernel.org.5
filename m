Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C557ED651
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343621AbjKOVyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjKOVyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:54:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26818195;
        Wed, 15 Nov 2023 13:54:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E85AC433C7;
        Wed, 15 Nov 2023 21:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700085257;
        bh=HNdL+Be6cMlMkW4vDhJAvj7UWUwF0byt9crJztV3lyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uuUklBQ0B/CTCk0nFXbhW8lC3h087uMYaSyhnyTxcDjjo05NoFHRTxCsf+K3hP2SC
         HA7aqD+mPmtWsMirc0/Q3VlWZNTSx1vCuEdAgBxm6hI1OtSGe26oCEWWt0h8tZZMQ8
         Kr8FrFtXZwKxnxh2h8uudv9WpK4euUj9kscV2GlymFLqce8HBRSDaTafn8r38UtQyG
         0TDEE3rZaQZQGM8gmluT3YqOxkcMgHxeabQrqScGxGJK4E3EZUjh+Z0ZYgPuVNF3NE
         xpG3XmKSPfLH10ibWUInlQUJ22O2/Mhp4vNZn5PULLc5AvxwDFmjfrVmwdeuGM6JcY
         yJdmpGpOBwM3Q==
Date:   Wed, 15 Nov 2023 21:54:14 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] ASoC: dt-bindings: renesas,rz-ssi: Document RZ/Five SoC
Message-ID: <20231115-support-hankering-907c9f496a52@squawk>
References: <20231115213358.33400-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5vok2DPxacar78Hn"
Content-Disposition: inline
In-Reply-To: <20231115213358.33400-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vok2DPxacar78Hn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 09:33:58PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The SSI block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-ssi" compatible string will be used on the RZ/Five
> SoC so to make this clear and to keep this file consistent, update the
> comment to include RZ/Five SoC.
>=20
> No driver changes are required as generic compatible string
> "renesas,rz-ssi" will be used as a fallback on RZ/Five SoC.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor,

> ---
>  Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml =
b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
> index 3b5ae45eee4a..8b9695f5decc 100644
> --- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
> +++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
> @@ -16,7 +16,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> -          - renesas,r9a07g043-ssi  # RZ/G2UL
> +          - renesas,r9a07g043-ssi  # RZ/G2UL and RZ/Five
>            - renesas,r9a07g044-ssi  # RZ/G2{L,LC}
>            - renesas,r9a07g054-ssi  # RZ/V2L
>        - const: renesas,rz-ssi
> --=20
> 2.34.1
>=20

--5vok2DPxacar78Hn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVU+AgAKCRB4tDGHoIJi
0u9xAQCy6Ri2/SWQe6N9pq0RvPqF9PoATlrxkwPve5pN0sw1QwEAuu5eaYnksBkj
LccHnxnG5WeHC80HRTULAmQagAAjiQw=
=THQ4
-----END PGP SIGNATURE-----

--5vok2DPxacar78Hn--
