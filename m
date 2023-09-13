Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4595479EBD0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240611AbjIMO5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbjIMOci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:32:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B9C90;
        Wed, 13 Sep 2023 07:32:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B19FC433C7;
        Wed, 13 Sep 2023 14:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694615554;
        bh=Y53NxREibvYmBz2vfCqHcEx9GPOsX6DY5l6vzt940dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WMeipzYu8L+1XIenZP7DKl+iDaWvafcSekoBCH5P+H5QJd9afsmD8q8yatAdVJN2d
         j18CG1FMVr6PMqZW+XfV9vMtNu8agt223gcWaImixT9LPFZBqEe+syTUvbhxfun+Ym
         RjA86tqGA8/NTLJ2DcCi08FcopZjHOximfIsYxEvPuJLbLUG6jyLBT2oGocwOW5+mG
         n59S4HfUnPHXVhrhGjJOora8EF26lv5uZV4BFj3z2PfDYV4vAdftHx18F2s2InMTBN
         BSa6dGIgHi6qKQxnU+mvJOzNWpbIAaSQZnONLqRzBFqPqlNvRTnN7/2S2NHfsxyPxr
         y5bdWmiawABJQ==
Date:   Wed, 13 Sep 2023 15:32:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        hkallweit1@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: interrupt-controller: Add support for
 Amlogic-T7 SoCs
Message-ID: <20230913-sizing-attest-bc9bf7806306@spud>
References: <20230913080924.3336391-1-huqiang.qin@amlogic.com>
 <20230913080924.3336391-2-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VOmdbYbGR3AGKron"
Content-Disposition: inline
In-Reply-To: <20230913080924.3336391-2-huqiang.qin@amlogic.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VOmdbYbGR3AGKron
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 04:09:22PM +0800, Huqiang Qin wrote:
> Update dt-binding document for GPIO interrupt controller
> of Amlogic-T7 SoCs.
>=20
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml   | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlog=
ic,meson-gpio-intc.yaml b/Documentation/devicetree/bindings/interrupt-contr=
oller/amlogic,meson-gpio-intc.yaml
> index 3d06db98e978..a93744763787 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meso=
n-gpio-intc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meso=
n-gpio-intc.yaml
> @@ -36,6 +36,7 @@ properties:
>                - amlogic,meson-a1-gpio-intc
>                - amlogic,meson-s4-gpio-intc
>                - amlogic,c3-gpio-intc
> +              - amlogic,t7-gpio-intc
>            - const: amlogic,meson-gpio-intc
> =20
>    reg:
> --=20
> 2.37.1
>=20

--VOmdbYbGR3AGKron
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQHH/AAKCRB4tDGHoIJi
0vdLAQDhN+3/ZepNIgLkq5NdctyuWtIFnzY2V898IUjqdLpOFgEA+b4BpWtwDoZl
ZiVZmBgQdzvDgKXokrZZbCfwUvd6Zg4=
=5xuz
-----END PGP SIGNATURE-----

--VOmdbYbGR3AGKron--
