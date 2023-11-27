Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6F57FA7E2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjK0RZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjK0RZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:25:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F7FA5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:25:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728D8C433C7;
        Mon, 27 Nov 2023 17:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701105950;
        bh=lfF7mYOfz1bTjUZRZpi+nzNpv2LWni6xopUZHu5kx+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CcBUHDytfki6Yc03N/Pa9DuIG7urxHBfpSDNPHmG1gmWrRgEXV7+YKEVsi1yTueIX
         KPojgBDUpR+HXL+6+t4DQ60ZbWxbX2cwqEmzjpzhzeEJtm3vxh1I8KACjSVEjpD020
         WczXbca1++KymG7gXAVblCZ15TiGkyeS0+dEoPne1SfIxaORLzYClSJu2ZJks+TPOr
         tK6JY+n8AfSTNWr4C6r6A/FFAAYs4abc7Crl+sUruW+dl7MB17mp/Qm/sf86sxyzII
         YKHVgueKg20YLTuauSMoGDoiHlD+1P0M8M7Q7bT+Iu18q/qsmZzfzNXGC3ccYGErk0
         9VMiD6SO6BnAA==
Date:   Mon, 27 Nov 2023 17:25:45 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Roland Hieber <rhi@pengutronix.de>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] dt-bindings: timer: fsl,imxgpt: Add fsl,imx7d-gpt
 compatible
Message-ID: <20231127-morse-favoring-b76d4a436796@spud>
References: <20231127-b4-dt-bindings-timer-v1-1-e06bd6b2370b@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Bfkf7er0zEK6fHrR"
Content-Disposition: inline
In-Reply-To: <20231127-b4-dt-bindings-timer-v1-1-e06bd6b2370b@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bfkf7er0zEK6fHrR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 04:38:24PM +0100, Roland Hieber wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
>=20
> Add "fsl,imx7d-gpt", "fsl,imx31-gpt", used in imx7s.dtsi, to the list of
> valid compatibles.
>=20
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Roland Hieber <rhi@pengutronix.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Do=
cumentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> index e2607377cbae..2006043b8335 100644
> --- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> +++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> @@ -31,6 +31,7 @@ properties:
>            - enum:
>                - fsl,imx6sl-gpt
>                - fsl,imx6sx-gpt
> +              - fsl,imx7d-gpt
>                - fsl,imx8mp-gpt
>                - fsl,imxrt1050-gpt
>                - fsl,imxrt1170-gpt
>=20
> ---
> base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
> change-id: 20231127-b4-dt-bindings-timer-95462dfd9758
>=20
> Best regards,
> --=20
> Roland Hieber, Pengutronix e.K.          | rhi@pengutronix.de          |
> Steuerwalder Str. 21                     | https://www.pengutronix.de/ |
> 31137 Hildesheim, Germany                | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686         | Fax:   +49-5121-206917-5555 |
>=20

--Bfkf7er0zEK6fHrR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWTRGQAKCRB4tDGHoIJi
0oV2AQD/OUwpWlz4bqYn6JMiz0Az7JfTMTQxmdGF17z3HvM2bwEAt1/hXpI+jz02
94mz7ob5CmgmTN1/rwSJh9/7FAnHkgg=
=40ZV
-----END PGP SIGNATURE-----

--Bfkf7er0zEK6fHrR--
