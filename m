Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02A276211C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjGYSOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjGYSOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:14:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D95E9;
        Tue, 25 Jul 2023 11:14:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E744461826;
        Tue, 25 Jul 2023 18:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83D9C433C8;
        Tue, 25 Jul 2023 18:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690308845;
        bh=WmpVtUDAaFLbImnOsO4tYnjeeSG53usXX5FWGAehNd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T8ezkXSL801Ko1HRqyb2qFQK+UcKw2H641PFM/9vIeVLmyMou0D106OI4NFQEZ1p4
         /DyaNKE7Pu9FX4QwH+vN2thu5DgN8Ve3dcfVdsTAbbAcF8cFvgNG7tcVZYGbcD1t9G
         6Smtu8orEyPEEtHy2IvTwqzpX2nDqTPRbppjr56cFMvBvmC6cJvl95eXVzMmkijGJS
         WBfCddw8V6I5gL/NKfbrUHm+EWR1cWx4UiKo3hzuTBTAsTxqIxIlzMRart3cB6u0qw
         XGW6A39OoBneYneYBP2svNPamPUHWn2T3O5Mf58gx+eYVfHx5ZjnVUbNdVkwrWDLYd
         lh/xvOv3VWQ3w==
Date:   Tue, 25 Jul 2023 19:13:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>
Cc:     narmstrong@baylibre.com, neil.armstrong@linaro.org,
        olivia@selenic.com, herbert@gondor.apana.org.au,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v1 2/3] dt-bindings: rng: meson: add meson-rng-s4
 compatible
Message-ID: <20230725-transport-pension-533b598260d0@spud>
References: <20230725141252.98848-1-avromanov@sberdevices.ru>
 <20230725141252.98848-3-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ns9HxazCpuYhnvR0"
Content-Disposition: inline
In-Reply-To: <20230725141252.98848-3-avromanov@sberdevices.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ns9HxazCpuYhnvR0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 05:12:51PM +0300, Alexey Romanov wrote:
> Now the driver has a separate algo for S4 SoC.
>=20
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> ---
>  Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml=
 b/Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml
> index 457a6e43d810..6f51506c0f65 100644
> --- a/Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml
> +++ b/Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml
> @@ -14,6 +14,7 @@ properties:
>    compatible:
>      enum:
>        - amlogic,meson-rng
> +      - amlogic,meson-rng-s4

Usually, the "s4" would come before the peripheral's name, as s4 is the
name of the SoC.

> =20
>    reg:
>      maxItems: 1
> --=20
> 2.38.1
>=20

--ns9HxazCpuYhnvR0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMAQ5wAKCRB4tDGHoIJi
0jQbAQD8az1AUWrNfWLQKH1A3YTesxjJXWzaUqgk5/77Cs01kAD/V9hsEIFEGFh3
KyJSju0f1Motr7Y45NVuek+l3js+DgI=
=LMAU
-----END PGP SIGNATURE-----

--ns9HxazCpuYhnvR0--
