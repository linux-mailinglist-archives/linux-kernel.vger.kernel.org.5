Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376C6790008
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241960AbjIAPjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjIAPjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:39:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE1610E4;
        Fri,  1 Sep 2023 08:39:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 44EC8CE2384;
        Fri,  1 Sep 2023 15:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE435C433C9;
        Fri,  1 Sep 2023 15:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693582747;
        bh=9sXWaul6tCPaCmhBP0FafUSy+vVBebFWa2BqGNOF7oU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tVZKOaVVtNzSC6nIFCoUtLRrSrEuHmzJymh+ojFVESKXP6EffsYGWB2RSoGAmcn0S
         YiGxm9GvXk2og/YtLuguYagi9/EZbTgJJmWpSsFgfs/QanbiL/4hgptdW7X6lF8Vwz
         PcqqO2ZIuyyBGKog1mhFjk0ao8RZKzsTnZ1VPr9T9nvpx1XKPgxPGnebDwOX2b3KwC
         TYWiKFLX4BUAeRgGykV+Mx1DoLur3fgk5z1Jc0NlUl4CFSz9UKTBLYGdJhU6WIZnH4
         Qz3D6KzaiqsouAZ2b/bzaoCWEj/MA6Fjj6jNiVtAfW6tepnFZFLML015ZTUApBUFjC
         AAZ39eQbIcSgw==
Date:   Fri, 1 Sep 2023 16:39:02 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yannic Moog <y.moog@phytec.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, upstream@lists.phytec.de
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: add phyGATE-Tauri-L board
Message-ID: <20230901-easeful-unmovable-5021ff618c99@spud>
References: <20230901-tauri_upstream_support-v1-0-ed30c6df789b@phytec.de>
 <20230901-tauri_upstream_support-v1-1-ed30c6df789b@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="N9YaokBgkjHC9SiT"
Content-Disposition: inline
In-Reply-To: <20230901-tauri_upstream_support-v1-1-ed30c6df789b@phytec.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N9YaokBgkjHC9SiT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 11:26:16AM +0200, Yannic Moog wrote:
> Add dt compatible for the phyGATE-Tauri-L board. It uses the
> phyCORE-i.MX8MM SoM
>=20
> Signed-off-by: Yannic Moog <y.moog@phytec.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index 2510eaa8906d..570794ce2813 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -974,7 +974,9 @@ properties:
> =20
>        - description: PHYTEC phyCORE-i.MX8MM SoM based boards
>          items:
> -          - const: phytec,imx8mm-phyboard-polis-rdk # phyBOARD-Polis RDK
> +          - enum:
> +              - phytec,imx8mm-phyboard-polis-rdk # phyBOARD-Polis RDK
> +              - phytec,imx8mm-phygate-tauri-l    # phyGATE-Tauri-L Gatew=
ay
>            - const: phytec,imx8mm-phycore-som        # phyCORE-i.MX8MM SoM
>            - const: fsl,imx8mm
> =20
>=20
> --=20
> 2.34.1
>=20

--N9YaokBgkjHC9SiT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPIFlgAKCRB4tDGHoIJi
0qjhAP9M3xIayHBSjWZ/OduFu4IIDWA6syKFFcup3/+gGZK+cAD/biqAu2Lg7+y9
oxs2s7ZMyrGEB3KeXbolhaHCRGUwmQk=
=bis8
-----END PGP SIGNATURE-----

--N9YaokBgkjHC9SiT--
