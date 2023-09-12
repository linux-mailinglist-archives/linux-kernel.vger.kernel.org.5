Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E764D79D671
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbjILQgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236874AbjILQgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:36:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097A610E9;
        Tue, 12 Sep 2023 09:36:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C44DC433C9;
        Tue, 12 Sep 2023 16:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694536600;
        bh=GxKIUea0MR3qucRWRL0Hx83U7cwPGTLCUKUSG5y0gTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2ju+hny7e7p8svy4BT1Z0NWlDaSWqAUMU0jO3tWdOGUwVvOTr5ryi6qKB1r00soR
         6MgqcPWs8U3o80SVJWEZP/K5R0lchPS8+Me+Zpv9QSsqKYlQpMMVd2HACNtZytqfdF
         NtGigKM+tgZZDmmbdhKNWm+43BcRVD5N0dCD3PxKOjLpEDsDS8nE6CF8knFeh2PrWY
         8iLnY+50Ain9WkIk9dFb7Ym/UT0XgLiHBOFDMizqDtfcH6KvXAnZUBW0w7FfFGgWQ7
         P8Pi1T+dbds7cdbZIYKgLuqbsimrLRVpxMZ0R6b7s3jy7/R16ly99fRsE5xC7FbpMA
         BipSJh9HkWnmw==
Date:   Tue, 12 Sep 2023 17:36:32 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Simon Horman <horms@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 06/31] dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc:
 Fix example property name
Message-ID: <20230912-marathon-pecan-a9d001f7e015@spud>
References: <20230912081527.208499-1-herve.codina@bootlin.com>
 <20230912081527.208499-7-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XR0sKUlOqSjiyY1L"
Content-Disposition: inline
In-Reply-To: <20230912081527.208499-7-herve.codina@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XR0sKUlOqSjiyY1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 10:14:57AM +0200, Herve Codina wrote:
> The given example mentions the 'fsl,mode' property whereas the
> correct property name, the one described, is 'fsl,operational-mode'.
>=20
> Fix the example to use the correct property name.
>=20
> Fixes: a9b121327c93 ("dt-bindings: soc: fsl: cpm_qe: Add QMC controller")
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml           | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-sc=
c-qmc.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-=
qmc.yaml
> index ec888f48cac8..450a0354cb1d 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.y=
aml
> +++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.y=
aml
> @@ -137,7 +137,7 @@ examples:
>          channel@16 {
>              /* Ch16 : First 4 even TS from all routed from TSA */
>              reg =3D <16>;
> -            fsl,mode =3D "transparent";
> +            fsl,operational-mode =3D "transparent";
>              fsl,reverse-data;
>              fsl,tx-ts-mask =3D <0x00000000 0x000000aa>;
>              fsl,rx-ts-mask =3D <0x00000000 0x000000aa>;
> @@ -146,7 +146,7 @@ examples:
>          channel@17 {
>              /* Ch17 : First 4 odd TS from all routed from TSA */
>              reg =3D <17>;
> -            fsl,mode =3D "transparent";
> +            fsl,operational-mode =3D "transparent";
>              fsl,reverse-data;
>              fsl,tx-ts-mask =3D <0x00000000 0x00000055>;
>              fsl,rx-ts-mask =3D <0x00000000 0x00000055>;
> @@ -155,7 +155,7 @@ examples:
>          channel@19 {
>              /* Ch19 : 8 TS (TS 8..15) from all routed from TSA */
>              reg =3D <19>;
> -            fsl,mode =3D "hdlc";
> +            fsl,operational-mode =3D "hdlc";
>              fsl,tx-ts-mask =3D <0x00000000 0x0000ff00>;
>              fsl,rx-ts-mask =3D <0x00000000 0x0000ff00>;
>          };
> --=20
> 2.41.0
>=20

--XR0sKUlOqSjiyY1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQCTkAAKCRB4tDGHoIJi
0qkSAQDCtuqFutdZCBawqlE2z8M36+DZG+UYXQsNC7oJKZRkAwD/czQYT6Dla3tv
mNhSBDRL50Z7rrG+GUiJRWBasgZy0Ak=
=+Z+2
-----END PGP SIGNATURE-----

--XR0sKUlOqSjiyY1L--
