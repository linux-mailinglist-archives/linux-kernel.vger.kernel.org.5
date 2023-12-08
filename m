Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9612A80A5D7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574002AbjLHOpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573984AbjLHOpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:45:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1D61720
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:45:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B30BC433C7;
        Fri,  8 Dec 2023 14:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702046711;
        bh=alMIVXtN0++wgPE7Yj1ylmvd8+9QvE9E1C3+NnY8d9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E5T0C5dxahWbKqUUR68JF6jiGuJfU32NXq04SIiPNtveDTAmklWwhM9kqhQLhF93g
         xXy7na58IPtgGZs+h5f4LZf+NwJUBFmPKAzBzcRLEkucfRe64wTFtVcFwjE8gmk+Ke
         YlyS0mcbhOeti4H1RbEIpXVgCzeGf+wKV8El+Xseu9eliukVW8HUr7BOV/uHs1FMJr
         kRnyF+XAb+qj3xcVRSYbzNxVlEPyAGwEahd3cdOFbsGbh9U30ReR4C/ruk5D80clvo
         uQt6HakEIDFikQ+bfiUpqQadc+1XoFEmAD9nlj66/xow3E5jxXPQcxojob0BXtWYqr
         Ocgb7MItOM27A==
Date:   Fri, 8 Dec 2023 14:45:05 +0000
From:   Conor Dooley <conor@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hal Feng <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v9 1/4] dt-bindings: pwm: Add bindings for OpenCores PWM
 Controller
Message-ID: <20231208-stunned-ploy-2a9e73933ae8@spud>
References: <20231208094209.1910934-1-william.qiu@starfivetech.com>
 <20231208094209.1910934-2-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VqHdBtEYxkgaGrmF"
Content-Disposition: inline
In-Reply-To: <20231208094209.1910934-2-william.qiu@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VqHdBtEYxkgaGrmF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 05:42:06PM +0800, William Qiu wrote:
> Add bindings for OpenCores PWM Controller.
>=20
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../bindings/pwm/opencores,pwm.yaml           | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/opencores,pwm.y=
aml
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml b/D=
ocumentation/devicetree/bindings/pwm/opencores,pwm.yaml
> new file mode 100644
> index 000000000000..0b85dd861dfd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/opencores,pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OpenCores PWM controller
> +
> +maintainers:
> +  - William Qiu <william.qiu@starfivetech.com>
> +
> +description:
> +  The OpenCores PTC ip core contains a PWM controller. When operating in=
 PWM
> +  mode, the PTC core generates binary signal with user-programmable low =
and
> +  high periods. All PTC counters and registers are 32-bit.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - starfive,jh7100-pwm
> +          - starfive,jh7110-pwm
> +      - const: opencores,pwm-v1
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwm@12490000 {
> +        compatible =3D "starfive,jh7110-pwm", "opencores,pwm-v1";
> +        reg =3D <0x12490000 0x10000>;
> +        clocks =3D <&clkgen 181>;
> +        resets =3D <&rstgen 109>;
> +        #pwm-cells =3D <3>;
> +    };
> --=20
> 2.34.1
>=20

--VqHdBtEYxkgaGrmF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXMr7gAKCRB4tDGHoIJi
0n1/AQCqxJkSJDrOMIPKQae1c1CejkKWCIbkI6ee1RCIAcEtZgEA6Qa1IO1dkM4G
cYL6KMxjp8nbExzyXKIz4dUJ1XNNZAE=
=1aUw
-----END PGP SIGNATURE-----

--VqHdBtEYxkgaGrmF--
