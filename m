Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78742777C71
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbjHJPl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjHJPlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:41:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ECB26BA;
        Thu, 10 Aug 2023 08:41:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D418066064;
        Thu, 10 Aug 2023 15:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C69C433C8;
        Thu, 10 Aug 2023 15:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691682083;
        bh=Vp2jSuFBWOEKjrQYyDUltwIuqr1IYAiJcOZOO7IAL8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CF9xkZjGiPLQKrEDzGEW+a4Cy0dc/eaAwqdDTuNTbmOMKHVp8Rv9uobIHBSfEfpSa
         W/RK7heCdE9UqBhF6M3kuDm2L8xou9gA7xBFzFDioRXHFGeXgZN5h/+wEzTqrifRkV
         72p/zqwGEjE4v6uZRLRmGPyjUMbC6+CBsyBrmCadaRl8zBCqhgAFjwlcwo6jB6Dz3O
         lZrW5sLI6CRSa7p/5lCe7BKrjTpWeMe+7+8PZ42j0OpZ3Y79Rh0Tv4FiUT6w9KZMMd
         9y6K/FpIeEYL4ZviD3bEy2DilDAWSddUFoVB2DFntwMIa+OGVE3SmbQ62m/l8mszyL
         klg4oChDuBpaQ==
Date:   Thu, 10 Aug 2023 16:41:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        kernel@puri.sm, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v1 1/5] dt-bindings: sound: gtm601: Add description
Message-ID: <20230810-decay-pelican-e0de3e95a72a@spud>
References: <cover.1691606520.git.agx@sigxcpu.org>
 <b6e85fdfaa87d7684a120ccedc1e07d8fe87957f.1691606520.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fm5BdTz7t06Oo3Tp"
Content-Disposition: inline
In-Reply-To: <b6e85fdfaa87d7684a120ccedc1e07d8fe87957f.1691606520.git.agx@sigxcpu.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fm5BdTz7t06Oo3Tp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2023 at 08:50:10PM +0200, Guido G=FCnther wrote:
> This allows to us to document the channel and sampling
> rate requirements.
>=20
> Signed-off-by: Guido G=FCnther <agx@sigxcpu.org>
> ---
>  Documentation/devicetree/bindings/sound/option,gtm601.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/option,gtm601.yaml b=
/Documentation/devicetree/bindings/sound/option,gtm601.yaml
> index 69c2ccc79dc5..ff813d97fc59 100644
> --- a/Documentation/devicetree/bindings/sound/option,gtm601.yaml
> +++ b/Documentation/devicetree/bindings/sound/option,gtm601.yaml
> @@ -16,10 +16,12 @@ description: >
>  properties:
>    compatible:
>      oneOf:
> -      - items:  # 48 kHz stereo
> +      - description: Broadmobi BM818 (48Khz stereo)
> +        items:
>            - const: broadmobi,bm818
>            - const: option,gtm601
> -      - const: option,gtm601  # 8 kHz mono
> +      - description: GTM601 (8kHz mono)
> +        const: option,gtm601

Makes little odds IMO which way it is done.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--fm5BdTz7t06Oo3Tp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNUFGwAKCRB4tDGHoIJi
0gOOAPoDAcz/ZqmjrpjlwQLTuapShIGvjmjfn2rzc+KxUXS5dgEAlgM1rxLHXiGG
Ej8O7ewGrTrObyfb9ZKlKcpZzz9sWQI=
=KmJs
-----END PGP SIGNATURE-----

--fm5BdTz7t06Oo3Tp--
