Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27417FA7CC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbjK0ROv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjK0ROh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:14:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926D019D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:14:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BE1C433C7;
        Mon, 27 Nov 2023 17:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701105284;
        bh=94eA5a3oVs1VTguMTV9OICnFtDjCrfp2/1bumD9OBZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fa/wQuX929+5dckPfYpUstS/A0PYi6ycn5TAH8wdbjF3R0MA8NWtU2JDzQKolgyvt
         LIdAMaLbIwy2Zu22qZ4AiKrl8xoGIPudfiWX3PEkYFK+QtJlKtkfzTYluMf0QWdGOV
         rRTYnLkT4j+kxALg0gAOSgRNdV+e0XLBSwO3fFds8seHEL31R3+4wLr/nnS1QEkDFF
         EnLkTCojnQeygYnmU1SUSfHV50HWG3zRY+jFN0sYWexHhR1217i5PnnTN5KT3Urdo4
         Ua+TSAMOSCqB4LApFdAHQX6MJDa5+Mr46b8GfdKndENulAzNbrtsz1vXe+k9m+NNO1
         1ybXs76rFt0fA==
Date:   Mon, 27 Nov 2023 17:14:36 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Roland Hieber <rhi@pengutronix.de>
Cc:     Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 1/2] dt-bindings: display: bridge: samsung-dsim: Add
 i.MX7D support
Message-ID: <20231127-sessions-publisher-d15b28966646@spud>
References: <20231127-b4-imx7-mipi-dsi-v1-0-7d22eee70c67@pengutronix.de>
 <20231127-b4-imx7-mipi-dsi-v1-1-7d22eee70c67@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eEkdIYeTY4jIHAux"
Content-Disposition: inline
In-Reply-To: <20231127-b4-imx7-mipi-dsi-v1-1-7d22eee70c67@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eEkdIYeTY4jIHAux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 05:12:28PM +0100, Roland Hieber wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
>=20
> Add support for the "fsl,imx7d-mipi-dsim" compatible used on i.MX7D.
>=20
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Roland Hieber <rhi@pengutronix.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../devicetree/bindings/display/bridge/samsung,mipi-dsim.yaml         | =
4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/bridge/samsung,mip=
i-dsim.yaml b/Documentation/devicetree/bindings/display/bridge/samsung,mipi=
-dsim.yaml
> index 4ed7a799ba26..e43fec560941 100644
> --- a/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.=
yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.=
yaml
> @@ -27,7 +27,9 @@ properties:
>            - fsl,imx8mm-mipi-dsim
>            - fsl,imx8mp-mipi-dsim
>        - items:
> -          - const: fsl,imx8mn-mipi-dsim
> +          - enum:
> +              - fsl,imx7d-mipi-dsim
> +              - fsl,imx8mn-mipi-dsim
>            - const: fsl,imx8mm-mipi-dsim
> =20
>    reg:
>=20
> --=20
> 2.39.2
>=20

--eEkdIYeTY4jIHAux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWTOfAAKCRB4tDGHoIJi
0gR3AQC/uU0C6yQnjFTOi3VAkiumHD8Z665Xqv9I+8g62eUrFgEAyZ2kzmH3FFHh
D1CWuyb+hcb2UhlGWyV3b4HuLNpq8QQ=
=ysHQ
-----END PGP SIGNATURE-----

--eEkdIYeTY4jIHAux--
