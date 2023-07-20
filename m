Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EE775B558
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjGTRPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjGTRPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:15:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E6C2722;
        Thu, 20 Jul 2023 10:15:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9586B61B95;
        Thu, 20 Jul 2023 17:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F475C433C7;
        Thu, 20 Jul 2023 17:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689873344;
        bh=LyEjOReqm///zWECKi0duSLe5uxlZvj/+/J2Zi7jsHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sL/s3VafJREaE7x20o2K8a9Z3LOv2OM2HcoXVhBK9qI0R1qjvGS8K/Y2mL+ZRsF6w
         xRmrWt3cFmbxHYKD6NP1ixR5Xs65XiCQfc9e5fRJu2Un7k+TxsWjjcBmagCXgLpiqh
         m6WAkLfhc2UdeeDFQ1Ke/PMWuBj1CvZyO/y/yZC6KBBpga3GXbASo+pEChXw+FcM5V
         QZRnEjTI3LASJkrliw9svrsT/VYthgg/dZEV9nJ9ugvJ1PN04B2sFQnYyUcx2ykZ/I
         LySJU0WSvwd2yk3ZIKQQVwQzO7WUnX3ovoxZ8ErtsQG4xlRkN2sSp2BvgmEF19Rcp1
         rb1Mlbih10qSQ==
Date:   Thu, 20 Jul 2023 18:15:37 +0100
From:   Conor Dooley <conor@kernel.org>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Andreas Kemnade <andreas@kemnade.info>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: arm: fsl: Add VAR-SOM-MX6 SoM
Message-ID: <20230720-subtype-pull-33f36b9ffd84@spud>
References: <20230720131028.3730704-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="io+0YOnpQlmtEO/r"
Content-Disposition: inline
In-Reply-To: <20230720131028.3730704-1-james.hilliard1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--io+0YOnpQlmtEO/r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 07:10:22AM -0600, James Hilliard wrote:
> Add support for Variscite i.MX6Q VAR-SOM-MX6 SoM.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index 2510eaa8906d..a3ab78429799 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -298,6 +298,7 @@ properties:
>                - udoo,imx6q-udoo           # Udoo i.MX6 Quad Board
>                - uniwest,imx6q-evi         # Uniwest Evi
>                - variscite,dt6customboard
> +              - variscite,var-som-imx6q   # i.MX6 Quad Variscite VAR-SOM=
-MX6 module
>                - wand,imx6q-wandboard      # Wandboard i.MX6 Quad Board
>                - ysoft,imx6q-yapp4-crux    # i.MX6 Quad Y Soft IOTA Crux =
board
>                - ysoft,imx6q-yapp4-pegasus # i.MX6 Quad Y Soft IOTA Pegas=
us board
> --=20
> 2.34.1
>=20

--io+0YOnpQlmtEO/r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLlruQAKCRB4tDGHoIJi
0nylAP4hJgOgH/8RnjJac+N3TPy68t17+OK+L/4XVdY1DqVV2AD8DKw2pPQnGYEd
QaOKp9v3DWGEOlQqt2aLP/b3p3jRlQM=
=OW2n
-----END PGP SIGNATURE-----

--io+0YOnpQlmtEO/r--
