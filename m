Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398757D1172
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377551AbjJTOVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377541AbjJTOVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:21:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05321D5D;
        Fri, 20 Oct 2023 07:21:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFABC433C7;
        Fri, 20 Oct 2023 14:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697811680;
        bh=Sec4O0KSkSkahb8ChGos0WpVoRI0WMt1czHDEPGpGl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fk1B4SIJRfOw6CSnTzkzYMkE/x3c54CLHy1M83x5hJJ5ZfslOTX1kXRRSOvLHJQO/
         jgxu4wkEJu8lU78QW8/QNbFbw22eIloRiTiDupXbkJlfTI+gwvMd7D51AiTgkTtCId
         7jL9cNcC6jSDWDo+yYAqx2NoQMC89OpGL997DufNCox/0GYQvcSKpMPSlwg2UT09gw
         +4pY6+5LfIZGrvRhMmQvOi1xE68es+XFGsnAW/ZD9w6QVtR6lXqj4QTQnCQL6JLUhu
         Zr+ftbCPS/R7MTC+bCcIdefvZk2xc0SBSAU2M2sajUZEfOGjNOKn0uj7j1ZJA2xtGa
         QHmEnqWalNKTg==
Date:   Fri, 20 Oct 2023 15:21:15 +0100
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
Subject: Re: [PATCH v6 1/4] dt-bindings: pwm: Add OpenCores PWM module
Message-ID: <20231020-barley-rosy-92c3688cd515@spud>
References: <20231020103741.557735-1-william.qiu@starfivetech.com>
 <20231020103741.557735-2-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c0ct6Bl9DHRpBcKH"
Content-Disposition: inline
In-Reply-To: <20231020103741.557735-2-william.qiu@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c0ct6Bl9DHRpBcKH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Krzysztof, William,

On Fri, Oct 20, 2023 at 06:37:38PM +0800, William Qiu wrote:
> Add documentation to describe OpenCores Pulse Width Modulation
> controller driver.
>=20
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../bindings/pwm/opencores,pwm-ocores.yaml    | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/opencores,pwm-o=
cores.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/opencores,pwm-ocores.y=
aml b/Documentation/devicetree/bindings/pwm/opencores,pwm-ocores.yaml
> new file mode 100644
> index 000000000000..0f6a3434f155
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/opencores,pwm-ocores.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/opencores,pwm-ocores.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OpenCores PWM controller
> +
> +maintainers:
> +  - William Qiu <william.qiu@starfivetech.com>
> +
> +description:
> +  OpenCores PTC ip core contains a PWM controller. When operating in PWM=
 mode, the PTC core
> +  generates binary signal with user-programmable low and high periods. A=
ll PTC counters and
> +  registers are 32-bit.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - opencores,pwm-ocores

What does the extra "ocores" suffix add, when it just repeats the vendor
prefix?

> +      - starfive,jh71x0-pwm

Krzysztof, did you approve this generic compatible?

And the whole thing looks like it should really be something like

items:
  - enum:
      - starfive,jh7100-pwm
      - starfive,jh7110-pwm
  - const: opencores,pwm

Cheers,
Conor.

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
> +        compatible =3D "opencores,pwm-ocores";
> +        reg =3D <0x12490000 0x10000>;
> +        clocks =3D <&clkgen 181>;
> +        resets =3D <&rstgen 109>;
> +        #pwm-cells =3D <3>;
> +    };
> --=20
> 2.34.1
>=20

--c0ct6Bl9DHRpBcKH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTKM2wAKCRB4tDGHoIJi
0mtkAQDneqmAMFoF4jU76TZRB8bFE0/YWyssA6R28Jn1s3HuawEAiae3jINyrJHZ
FyfmraP/Nbf35vRKjhrVBRmITylgPQs=
=uBpZ
-----END PGP SIGNATURE-----

--c0ct6Bl9DHRpBcKH--
