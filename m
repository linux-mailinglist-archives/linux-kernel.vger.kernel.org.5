Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF107A28A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237715AbjIOUuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237765AbjIOUtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:49:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1132D48;
        Fri, 15 Sep 2023 13:49:18 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 324126600B9D;
        Fri, 15 Sep 2023 21:49:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694810957;
        bh=vLgY8rCiM5Qt+aHqvAkM8PPmsp9niBHALfFONENovW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1wGH56Z0WS8OhEY8S0k8nySdlcbENukcNliDWh8ttwcqWmEaVn/UZpzQrt9TOFMB
         xgXzt2cnBNSf3pt2Ud+3nl7eGK0RUka5UroNLHx5ph8Bxw4fJM6DugVx+pcLV5Ktdv
         bdwqrBpLd0UmMTGWvmcW+yo25U+uc5Vwgtftgba5bRN3eyHDkLNyZ/kXzIXobP6cvZ
         2GtZTCDq3UfWsBVgakQbxy+hGirAjBuguuqxjtEfbQShqZ8RCKRMTKYPwPEGp6cbfW
         44P7hs8Yyns3MUP70SCqK/rPF/53qeGKjowW60z2g35szc+VRlCtVNLVkrmm7+vPsg
         tGqRYPkHOxsZA==
Received: by mercury (Postfix, from userid 1000)
        id 5B719106044B; Fri, 15 Sep 2023 22:49:14 +0200 (CEST)
Date:   Fri, 15 Sep 2023 22:49:14 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Varshini Rajendran <varshini.rajendran@microchip.com>
Cc:     claudiu.beznea@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/50] dt-bindings: power: reset: atmel,sama5d2-shdwc:
 add sam9x7
Message-ID: <20230915204914.5ydicuwkiwmsuop4@mercury.elektranox.org>
References: <20230728102407.265617-1-varshini.rajendran@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4rmbok64xucswjqi"
Content-Disposition: inline
In-Reply-To: <20230728102407.265617-1-varshini.rajendran@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4rmbok64xucswjqi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 28, 2023 at 03:54:07PM +0530, Varshini Rajendran wrote:
> Add shutdown controller DT bindings.
>=20
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  .../devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml   | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-=
shdwc.yaml b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-sh=
dwc.yaml
> index 8c58e12cdb60..0735ceb7c103 100644
> --- a/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.y=
aml
> +++ b/Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.y=
aml
> @@ -22,6 +22,9 @@ properties:
>        - enum:
>            - atmel,sama5d2-shdwc
>            - microchip,sam9x60-shdwc
> +      - items:
> +          - const: microchip,sam9x7-shdwc
> +          - const: microchip,sam9x60-shdwc
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.25.1
>=20

--4rmbok64xucswjqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUEw0oACgkQ2O7X88g7
+pqMaQ//fRpW3IAmANjZp1vqMTaLUVucVuRl9o6bRdbKxWdE52Vb11f44Q27IkdK
eBECNresd47jrMxzMc5I2GrUmQP31aAfr1gtAWO2tmIoctf1gEvoFWOPnLmrBN7U
tlnHfAGkgKd9fZocN5J9r3QBGrb+y9wWDnjgdxMcU6pg0UnVZS6cbx765W1jjbTi
exjLlh4k7BvIaqIrQg19gbbofVbsn0PeFCW7nFXiO5Fqux8Z2xxHTNTD9x+Jjnzw
ISOHEy/2F1PvOk5Ih/Zr3mRr7FQBHAVTqj9BLriMTUc0xiJeycClc5olw5+hn7Aa
MD/F2orU9U1lEUdAJrXfPBw3kxqjjUupDfP1+/866W0+/5JrnTCDNN15HSaCmfHV
wjsSOtf3o0UTdjQbWlycomzGsh95DVUPfhy1J81dOlgPbX2newx8PeyXqPuDfB5/
aVlllGqUi71J/FJnYNm3lkbvg2o5sz67fmvimj3T8vYQ27+rCiG+t6RTKyROrJx0
9FrmxpybxpWkY4MIfuqsg+DAoZXn+ECa+t3+ScwClG0HY+61dk08XRA+ySe0mmk2
XxV8ZI6VWlsratzwlcHJJQFNEgkEbWdh3gYTAx5EspcXd/EP7hApWTGeEavL1OIV
vYqSNJAvPyV7+jBfW0xim6YsUjp+qM0XtbkpOxL7G9ePlImSb34=
=deto
-----END PGP SIGNATURE-----

--4rmbok64xucswjqi--
