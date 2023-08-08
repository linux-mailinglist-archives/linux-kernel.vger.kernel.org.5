Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96242773C90
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjHHQHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjHHQFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:05:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBB06EB4;
        Tue,  8 Aug 2023 08:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3AE4624E0;
        Tue,  8 Aug 2023 12:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B62AC433C8;
        Tue,  8 Aug 2023 12:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691496591;
        bh=FzbOxvvcT3an8By+bOHp6cyHrQ87WItM2HAHMx6IoRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ehP1b2bkLNUXjEjaxc9cidCuqOTS3i+S6muIu9INtZkx1y6sVWTjl+QavfkjrEYVq
         HA6is88xBCIS1czwcdQ+k7n+w+COyEE9KFtUe+p6tQ9OlbvvyOIrpKF1Npq1iUW1oJ
         IHgeXhk2p9BCrmqZ3zE9bGlGaiZ+J03Fpuzg020HdHm5xiFJ+snsH1+9mibbag9LH/
         CpHIP06gSzr4sQe0q+NcdTRHhnr7IImA0JB0r5B3Q+ZsrqRGpdaRVl9vek6EKhKqk5
         VMEbDlcA+pd3x2ty5TfxfyTituVj7OChW4msMrBtf46iHAGvON4mgI96DdF9XWS2ed
         eH8f0o+EU3Jzg==
Date:   Tue, 8 Aug 2023 13:09:45 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>
Cc:     narmstrong@baylibre.com, neil.armstrong@linaro.org,
        olivia@selenic.com, herbert@gondor.apana.org.au,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, f.fainelli@gmail.com,
        hkallweit1@gmail.com, lists@kaiser.cx,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v2 2/3] dt-bindings: rng: meson: add meson-rng-s4
 compatible
Message-ID: <20230808-calcium-smasher-5f6c410fb226@spud>
References: <20230807130611.63914-1-avromanov@sberdevices.ru>
 <20230807130611.63914-3-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1ZSDXZ0SsvgeKJ0O"
Content-Disposition: inline
In-Reply-To: <20230807130611.63914-3-avromanov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1ZSDXZ0SsvgeKJ0O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 04:06:10PM +0300, Alexey Romanov wrote:
> Now the driver has a separate algo for S4 SoC.
>=20
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml=
 b/Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml
> index 457a6e43d810..afa52af442a7 100644
> --- a/Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml
> +++ b/Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml
> @@ -14,6 +14,7 @@ properties:
>    compatible:
>      enum:
>        - amlogic,meson-rng
> +      - amlogic,meson-s4-rng
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.38.1
>=20

--1ZSDXZ0SsvgeKJ0O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNIwiAAKCRB4tDGHoIJi
0pUgAP9HDWOZ1G7GCTkcQUybdiI2/jI/AvEAXJI563GCRiQ3ygEAooo5442ZSKKj
zRJUywsZ62WcXhxLA1v+F2JzZdeAtAM=
=yk/+
-----END PGP SIGNATURE-----

--1ZSDXZ0SsvgeKJ0O--
