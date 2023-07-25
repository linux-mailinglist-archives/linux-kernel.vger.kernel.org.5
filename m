Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E5F76219A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjGYSkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjGYSkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:40:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED992691;
        Tue, 25 Jul 2023 11:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5604761880;
        Tue, 25 Jul 2023 18:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0EAC433C9;
        Tue, 25 Jul 2023 18:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690310413;
        bh=jU4ftRXQP71eH7Z3fN1aTdPt3uWtE7mAseu7U3b+y5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pncxFVXIqXWQeDlVe+Nic4L04M87rorWvi2WLsDqvC67lgc+HxdRY05c8hkLyfiII
         TGnsEYbE+NtZPUZAqfHhEut1LX4TRI54jvrPVGaS3ZnFOZUA4OQDpny4h4y6BuHCA2
         /mBD1D2M2lgnJdU1rpH00DQn4ou6oYgbnXnXzPZetT+z++vMRjFkIUynfTKXx9kyXc
         jIWjxYZmc8alywIarVwIYa9GojCX0OjaEIXfwMArhkNk57eoAHlQjXxKzi49b/7zKB
         VutPcpQpJywljUpWx+ZuQZ++f7kK4/ZWGusVKIFA25D2jgNXQVRDd6iDUsymd7V375
         OHP1bFx+Vb/dw==
Date:   Tue, 25 Jul 2023 19:40:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mchehab@kernel.org, ming.qian@nxp.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, conor+dt@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] dt-bindings: media: amphion,vpu: correct node name
Message-ID: <20230725-marxism-citizen-cf3b97f93da6@spud>
References: <20230725102545.184916-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Z3SS69DvU2w+1FpI"
Content-Disposition: inline
In-Reply-To: <20230725102545.184916-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z3SS69DvU2w+1FpI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 06:25:45PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> The node name should use hyphen(-), not underscore(_).
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/media/amphion,vpu.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/media/amphion,vpu.yaml b/D=
ocumentation/devicetree/bindings/media/amphion,vpu.yaml
> index a9d80eaeeeb6..c0d83d755239 100644
> --- a/Documentation/devicetree/bindings/media/amphion,vpu.yaml
> +++ b/Documentation/devicetree/bindings/media/amphion,vpu.yaml
> @@ -47,7 +47,7 @@ patternProperties:
>      $ref: ../mailbox/fsl,mu.yaml#
> =20
> =20
> -  "^vpu_core@[0-9a-f]+$":
> +  "^vpu-core@[0-9a-f]+$":
>      description:
>        Each core correspond a decoder or encoder, need to configure them
>        separately. NXP i.MX8QM SoC has one decoder and two encoder, i.MX8=
QXP SoC
> @@ -143,7 +143,7 @@ examples:
>          power-domains =3D <&pd IMX_SC_R_VPU_MU_2>;
>        };
> =20
> -      vpu_core0: vpu_core@2d080000 {
> +      vpu_core0: vpu-core@2d080000 {
>          compatible =3D "nxp,imx8q-vpu-decoder";
>          reg =3D <0x2d080000 0x10000>;
>          power-domains =3D <&pd IMX_SC_R_VPU_DEC_0>;
> @@ -154,7 +154,7 @@ examples:
>          memory-region =3D <&decoder_boot>, <&decoder_rpc>;
>        };
> =20
> -      vpu_core1: vpu_core@2d090000 {
> +      vpu_core1: vpu-core@2d090000 {
>          compatible =3D "nxp,imx8q-vpu-encoder";
>          reg =3D <0x2d090000 0x10000>;
>          power-domains =3D <&pd IMX_SC_R_VPU_ENC_0>;
> @@ -165,7 +165,7 @@ examples:
>          memory-region =3D <&encoder1_boot>, <&encoder1_rpc>;
>        };
> =20
> -      vpu_core2: vpu_core@2d0a0000 {
> +      vpu_core2: vpu-core@2d0a0000 {
>          reg =3D <0x2d0a0000 0x10000>;
>          compatible =3D "nxp,imx8q-vpu-encoder";
>          power-domains =3D <&pd IMX_SC_R_VPU_ENC_1>;
> --=20
> 2.37.1
>=20

--Z3SS69DvU2w+1FpI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMAXCQAKCRB4tDGHoIJi
0nwyAQClVERioRKr/O5nSqrfZdqDmzr7qlCy8Z3qmutHO997PgEAjPRaUpSTkRLI
OxdIKK6HLYW/qOdiwR1f4AxY7nu9/wk=
=/MdV
-----END PGP SIGNATURE-----

--Z3SS69DvU2w+1FpI--
