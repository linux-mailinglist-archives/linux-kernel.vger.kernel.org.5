Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204BC7B3FB2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 11:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjI3Jak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 05:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjI3Jah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 05:30:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507B8CA;
        Sat, 30 Sep 2023 02:30:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4FFC433C7;
        Sat, 30 Sep 2023 09:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696066232;
        bh=tin0U19Nf4ANHDkcJXK1cl2YnmWbZlWUAWYQns6q95A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GrJMGkZXrPIT7StjOmeW+Fl8xwgebNyjtUdAOXRb7MJ/TkKMz13DPx5Qoi0HwXWp1
         Mj2c9yfx7SVQvUXsKfnq2P+RHMAyI6mccAk8fKyDW4gULxhlZPGShSX0WB+iPaLSr7
         mUiK0T0ddtqYsPPd0h1y920r2619heC5HkItOvuIA5vB7ZbXGsO9h6OwebpZKIXYfF
         cpzqp4c9klicbTpjXdFyqmWoSxM1g9gXG3Rv/6g0U6gQbBYq5kpvOkn71X4pJA4cJz
         KBit/mnJ2hHesyHyAhpoqwuKWDve8VIIRBfPJ7YgW7vnqnXZCqNQXymd7meZ+Cwm2y
         ZlR+A2h8PKMfg==
Date:   Sat, 30 Sep 2023 10:30:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.de, balejk@matfyz.cz
Subject: Re: [PATCH RESEND v5 3/8] dt-bindings: clock: Add Marvell PXA1908
 clock bindings
Message-ID: <20230930-purr-catchable-7149ee271df9@spud>
References: <20230929-pxa1908-lkml-v5-0-5aa5a1109c5f@skole.hr>
 <20230929-pxa1908-lkml-v5-3-5aa5a1109c5f@skole.hr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xztbYI3ipS2Vh9bj"
Content-Disposition: inline
In-Reply-To: <20230929-pxa1908-lkml-v5-3-5aa5a1109c5f@skole.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xztbYI3ipS2Vh9bj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 05:41:59PM +0200, Duje Mihanovi=C4=87 wrote:
> Add dt bindings and documentation for the Marvell PXA1908 clock
> controller.
>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/clock/marvell,pxa1908.yaml | 48 ++++++++++++
>  include/dt-bindings/clock/marvell,pxa1908.h        | 88 ++++++++++++++++=
++++++
>  2 files changed, 136 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml=
 b/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
> new file mode 100644
> index 000000000000..4e78933232b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/marvell,pxa1908.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell PXA1908 Clock Controllers
> +
> +maintainers:
> +  - Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> +
> +description: |
> +  The PXA1908 clock subsystem generates and supplies clock to various
> +  controllers within the PXA1908 SoC. The PXA1908 contains numerous clock
> +  controller blocks, with the ones currently supported being APBC, APBCP=
, MPMU
> +  and APMU roughly corresponding to internal buses.
> +
> +  All these clock identifiers could be found in <include/dt-bindings/mar=
vell,pxa1908.h>.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - marvell,pxa1908-apbc
> +      - marvell,pxa1908-apbcp
> +      - marvell,pxa1908-mpmu
> +      - marvell,pxa1908-apmu
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  # APMU block:
> +  - |
> +    clock-controller@d4282800 {
> +      compatible =3D "marvell,pxa1908-apmu";
> +      reg =3D <0xd4282800 0x400>;
> +      #clock-cells =3D <1>;
> +    };
> diff --git a/include/dt-bindings/clock/marvell,pxa1908.h b/include/dt-bin=
dings/clock/marvell,pxa1908.h
> new file mode 100644
> index 000000000000..fb15b0d0cd4c
> --- /dev/null
> +++ b/include/dt-bindings/clock/marvell,pxa1908.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +#ifndef __DTS_MARVELL_PXA1908_CLOCK_H
> +#define __DTS_MARVELL_PXA1908_CLOCK_H
> +
> +/* plls */
> +#define PXA1908_CLK_CLK32		1
> +#define PXA1908_CLK_VCTCXO		2
> +#define PXA1908_CLK_PLL1_624		3
> +#define PXA1908_CLK_PLL1_416		4
> +#define PXA1908_CLK_PLL1_499		5
> +#define PXA1908_CLK_PLL1_832		6
> +#define PXA1908_CLK_PLL1_1248		7
> +#define PXA1908_CLK_PLL1_D2		8
> +#define PXA1908_CLK_PLL1_D4		9
> +#define PXA1908_CLK_PLL1_D8		10
> +#define PXA1908_CLK_PLL1_D16		11
> +#define PXA1908_CLK_PLL1_D6		12
> +#define PXA1908_CLK_PLL1_D12		13
> +#define PXA1908_CLK_PLL1_D24		14
> +#define PXA1908_CLK_PLL1_D48		15
> +#define PXA1908_CLK_PLL1_D96		16
> +#define PXA1908_CLK_PLL1_D13		17
> +#define PXA1908_CLK_PLL1_32		18
> +#define PXA1908_CLK_PLL1_208		19
> +#define PXA1908_CLK_PLL1_117		20
> +#define PXA1908_CLK_PLL1_416_GATE	21
> +#define PXA1908_CLK_PLL1_624_GATE	22
> +#define PXA1908_CLK_PLL1_832_GATE	23
> +#define PXA1908_CLK_PLL1_1248_GATE	24
> +#define PXA1908_CLK_PLL1_D2_GATE	25
> +#define PXA1908_CLK_PLL1_499_EN		26
> +#define PXA1908_CLK_PLL2VCO		27
> +#define PXA1908_CLK_PLL2		28
> +#define PXA1908_CLK_PLL2P		29
> +#define PXA1908_CLK_PLL2VCODIV3		30
> +#define PXA1908_CLK_PLL3VCO		31
> +#define PXA1908_CLK_PLL3		32
> +#define PXA1908_CLK_PLL3P		33
> +#define PXA1908_CLK_PLL3VCODIV3		34
> +#define PXA1908_CLK_PLL4VCO		35
> +#define PXA1908_CLK_PLL4		36
> +#define PXA1908_CLK_PLL4P		37
> +#define PXA1908_CLK_PLL4VCODIV3		38
> +
> +/* apb (apbc) peripherals */
> +#define PXA1908_CLK_UART0		1
> +#define PXA1908_CLK_UART1		2
> +#define PXA1908_CLK_GPIO		3
> +#define PXA1908_CLK_PWM0		4
> +#define PXA1908_CLK_PWM1		5
> +#define PXA1908_CLK_PWM2		6
> +#define PXA1908_CLK_PWM3		7
> +#define PXA1908_CLK_SSP0		8
> +#define PXA1908_CLK_SSP1		9
> +#define PXA1908_CLK_IPC_RST		10
> +#define PXA1908_CLK_RTC			11
> +#define PXA1908_CLK_TWSI0		12
> +#define PXA1908_CLK_KPC			13
> +#define PXA1908_CLK_SWJTAG		14
> +#define PXA1908_CLK_SSP2		15
> +#define PXA1908_CLK_TWSI1		16
> +#define PXA1908_CLK_THERMAL		17
> +#define PXA1908_CLK_TWSI3		18
> +
> +/* apb (apbcp) peripherals */
> +#define PXA1908_CLK_UART2		1
> +#define PXA1908_CLK_TWSI2		2
> +#define PXA1908_CLK_AICER		3
> +
> +/* axi (apmu) peripherals */
> +#define PXA1908_CLK_CCIC1		1
> +#define PXA1908_CLK_ISP			2
> +#define PXA1908_CLK_DSI1		3
> +#define PXA1908_CLK_DISP1		4
> +#define PXA1908_CLK_CCIC0		5
> +#define PXA1908_CLK_SDH0		6
> +#define PXA1908_CLK_SDH1		7
> +#define PXA1908_CLK_USB			8
> +#define PXA1908_CLK_NF			9
> +#define PXA1908_CLK_CORE_DEBUG		10
> +#define PXA1908_CLK_VPU			11
> +#define PXA1908_CLK_GC			12
> +#define PXA1908_CLK_SDH2		13
> +#define PXA1908_CLK_GC2D		14
> +#define PXA1908_CLK_TRACE		15
> +#define PXA1908_CLK_DVC_DFC_DEBUG	16
> +
> +#endif
>=20
> --=20
> 2.42.0
>=20
>=20

--xztbYI3ipS2Vh9bj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRfqsAAKCRB4tDGHoIJi
0jIyAQClD4BtPUpM5qBMvLM7SmIKbmSXy1dLhn3+zWj1ceg1kgD/XLaUdvmI7W0U
Itc9gfrWaDvaBLCZSGLLCFp10gm07AE=
=eaix
-----END PGP SIGNATURE-----

--xztbYI3ipS2Vh9bj--
