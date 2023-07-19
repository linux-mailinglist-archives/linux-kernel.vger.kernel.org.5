Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4FC75A04A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjGSVBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGSVA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:00:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E5B1BF0;
        Wed, 19 Jul 2023 14:00:57 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D2CFC660707B;
        Wed, 19 Jul 2023 22:00:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689800455;
        bh=JZc8T7ioV/cJFnqDSexkT6DvNL6Jzk6G0WW9rlfuHDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JzIuEBr81YqvI9U4PXIxE4AMEpbCY37Ds7QEhRC2g5FkfvgmKF4pB1OzpDuWbJT9a
         TBPDqbSlZAQkTMaNBKfp7GffncS/7/hvCc5rPMxxqIZqht38VFB6k87anvcm9JYoZA
         kKnbxvRUs2gCKtcg8dlDHcpobiVXWxmRgDYnmH8hC1agFKmLw9NruIee1eLva8NOyy
         ZTWZoAoEegNv4JHaKUTLM5+ryL7Z0/LKR6qiohdqn5+HBtlw8ka26kz9gUJ+6f2un1
         wKLkSxNEIVwLsU/neUfusgiDk5/QniekVHfs+nnN5wkd7McXcU8hcqyHTloSmKpYTR
         I5danS94KOjKw==
Received: by mercury (Postfix, from userid 1000)
        id 3969F10613A9; Wed, 19 Jul 2023 23:00:53 +0200 (CEST)
Date:   Wed, 19 Jul 2023 23:00:53 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: mfd: Un-support Maxim and Samsung PMIC
 drivers
Message-ID: <20230719210053.fmcaotetmt2ydydx@mercury.elektranox.org>
References: <20230714050313.8424-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qsxp4w5rz3a6tynw"
Content-Disposition: inline
In-Reply-To: <20230714050313.8424-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qsxp4w5rz3a6tynw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 14, 2023 at 07:03:13AM +0200, Krzysztof Kozlowski wrote:
> Since few years no one is really paid to support drivers for: Maxim
> MUICs/PMICs for Exynos based boards and Samsung PMICs.  Correct the
> status to keep them as maintained.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

I assume this will go via MFD. FWIW,

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ab839af24fc3..0b8cd03f5e52 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12840,7 +12840,7 @@ F:	drivers/power/supply/max77976_charger.c
>  MAXIM MUIC CHARGER DRIVERS FOR EXYNOS BASED BOARDS
>  M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>  L:	linux-pm@vger.kernel.org
> -S:	Supported
> +S:	Maintained
>  B:	mailto:linux-samsung-soc@vger.kernel.org
>  F:	Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
>  F:	Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
> @@ -12851,7 +12851,7 @@ MAXIM PMIC AND MUIC DRIVERS FOR EXYNOS BASED BOAR=
DS
>  M:	Chanwoo Choi <cw00.choi@samsung.com>
>  M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>  L:	linux-kernel@vger.kernel.org
> -S:	Supported
> +S:	Maintained
>  B:	mailto:linux-samsung-soc@vger.kernel.org
>  F:	Documentation/devicetree/bindings/*/maxim,max14577.yaml
>  F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
> @@ -18809,7 +18809,7 @@ SAMSUNG MULTIFUNCTION PMIC DEVICE DRIVERS
>  M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>  L:	linux-kernel@vger.kernel.org
>  L:	linux-samsung-soc@vger.kernel.org
> -S:	Supported
> +S:	Maintained
>  B:	mailto:linux-samsung-soc@vger.kernel.org
>  F:	Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml
>  F:	Documentation/devicetree/bindings/mfd/samsung,s2m*.yaml
> --=20
> 2.34.1
>=20

--qsxp4w5rz3a6tynw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmS4TwQACgkQ2O7X88g7
+ppf5g/+K7pCMCIm2AJmnRVXqYTBxtAnxbKztimxS/EuObifkbVteASi3I8AUHSk
SQaRoFPMKukeMfvggMTE+Z1jYtOOVlB3cYQoH//f8AESXg94ygem+FXIrb0aXSD6
qJx2cYMrw2yxLjNdweflSYLYGPFbL0zmFl+Ls2fWsZWILYV6IYq8mZmvcEQ2Ox2R
TU0+MOfnyt1xlSMUvZPUOylXKLO3cWNaLY/DCnu5dYauH5S3hKyWb8pHDxEwbsDn
+eAxJv155VS4F4V6h61FcipHGoLqxoUtIzEtgXUpNwATo6CBZPKMdIRoIlchbMeJ
SrXIBDcxEuANZHO1cU5dHhiwrb1TvjNxN9rWeaZdDQAkg9qO3Rks64/oWl0DgqNL
cTw1p9X/yYb8h2b4v/DZwd92mosyGrC100TrXYJUWtswIlt9gZV/iXIvC5URaaZM
sQZ3Ot/gCygoCLjb3XGZpU4jYttrhn5rck4TaMd4AQP8ngnS3JxTyVoMfbl1QVlo
vlJ2P1uWluogEfFa3EhR7DrGsrHtXJw6XCSp1UZ905g7Awt5Q0D0V5TRuhVI94+I
BsaVEDVHCbr03bR3t791h/SuIsUmNU7FTZkUssSbcFcUXwYR1CZAVlFsz2hQsKKG
ancH5AJ2GUkG3zHYwyhV3wHfiyFgB3FWOlJ1DiqphKVlJqxR0hU=
=zH2e
-----END PGP SIGNATURE-----

--qsxp4w5rz3a6tynw--
