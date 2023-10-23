Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2920C7D3DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjJWRij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjJWRii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:38:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7A483;
        Mon, 23 Oct 2023 10:38:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5BDC433C7;
        Mon, 23 Oct 2023 17:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698082716;
        bh=eZlZ0RSR8neaBBF+HvzJKthBOQ2i00NRtc83TDbgb/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GZcoCvRUwfcmv7oI3ZoKRQE+hLDNpdANz8/BDEmtdrSB2ioRBIq6ZoJEeGHZTPrQ6
         gnxXS1y2gCKIIOUH86xYNxb6Cw1d0qkGZ6JYlMefFOdOgsiepFUfajPb+0UdftD+ao
         e7EK2ytUx3z+ij79CECne+/7u91MfFH+FZORhv7ytIhrgJPcSFQ8MwD+wAyWV5nbOP
         FqKH0wpAQmjLNmJr84u1AgLEWBQFaKtk+m+dL+bvfW7mCQjhSpwgNHTXV80gLlneKT
         1nhCgO0oxC5wcJMmyCa1r/z2anONnpe0U+eedfEA7GRxCX1i7O3rvm7G66ryiZ3gCP
         B4q/ik75qZn6A==
Date:   Mon, 23 Oct 2023 18:38:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 11/18] dt-bindings: pwm: add power-domains property
Message-ID: <20231023-oppose-tamper-36d526ece102@spud>
References: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
 <20231023-display-support-v1-11-5c860ed5c33b@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cS4xr49HXM/FpVea"
Content-Disposition: inline
In-Reply-To: <20231023-display-support-v1-11-5c860ed5c33b@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cS4xr49HXM/FpVea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Mon, Oct 23, 2023 at 04:40:11PM +0200, Alexandre Mergnat wrote:
> According to the Mediatek datasheet, the display PWM block has a power
> domain.

Datasheet for which soc? The mt8173? Is it valid for all devices in this
binding?

Cheers,
Conor.

>=20
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml=
 b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> index 153e146df7d4..efe0cacf55b7 100644
> --- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> +++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> @@ -53,6 +53,12 @@ properties:
>        - const: main
>        - const: mm
> =20
> +  power-domains:
> +    maxItems: 1
> +    description: A phandle and PM domain specifier as defined by binding=
s of
> +      the power controller specified by phandle. See
> +      Documentation/devicetree/bindings/power/power-domain.yaml for deta=
ils.
> +
>  required:
>    - compatible
>    - reg
> @@ -67,6 +73,7 @@ examples:
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/clock/mt8173-clk.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/mt8173-power.h>
> =20
>      pwm0: pwm@1401e000 {
>          compatible =3D "mediatek,mt8173-disp-pwm";
> @@ -75,4 +82,5 @@ examples:
>          clocks =3D <&mmsys CLK_MM_DISP_PWM026M>,
>                   <&mmsys CLK_MM_DISP_PWM0MM>;
>          clock-names =3D "main", "mm";
> +        power-domains =3D <&spm MT8173_POWER_DOMAIN_MM>;
>      };
>=20
> --=20
> 2.25.1
>=20

--cS4xr49HXM/FpVea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTavlQAKCRB4tDGHoIJi
0v6MAP9Wb3x+52wloDaXjDqYEnoDpprt4+MalmIoclgMkfOMIQEAhpm3TcXRGiJp
BzZXQcz8bAvgaFDyy5KvWovrZlrFSgE=
=4JSZ
-----END PGP SIGNATURE-----

--cS4xr49HXM/FpVea--
