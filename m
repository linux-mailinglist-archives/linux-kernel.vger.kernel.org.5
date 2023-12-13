Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB98981113B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjLMMnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjLMMnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:43:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356ACA4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:43:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4DAC433C8;
        Wed, 13 Dec 2023 12:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702471387;
        bh=FjDgTJb3iN+IW1iAF5vDMCIbbGw0B3symE2ANlrDB5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SkigjsFv2x+gC7EpuxdQxnywJ4suCEtmoH+ePSuVjVkflsKPbVS+huHzufrgTjrjo
         3RrlcuVx1GTL3bskd5v5WCO092kIZQLlluttUivdP4LB1zQVFR/Kx3U3pm5gogdwRH
         WEJHJKX5m3E5VGuY5BA4IFLd6bdgvtoPkjxJgN7/OB0Hub1gkir9kVmHmgQbKfovod
         DJAFm7NAj+00iDIPJS7n95K2Z+6sUYLaLcMy0K7Q8fAN+k+x9NDTWm05zSXAC5KnVb
         j8wMrORBndfOPcPaHy8wcYtPiAg5Iw63J+1n0yvJ9ppLOJ3xE2L/LSdupZX1DJ5jA6
         e3b8y6wd5J77w==
Date:   Wed, 13 Dec 2023 12:43:01 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc:     kernel@esmil.dk, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzk@kernel.org,
        conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, daniel.lezcano@linaro.org,
        tglx@linutronix.de, anup@brainfault.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        michal.simek@amd.com, michael.zhu@starfivetech.com,
        drew@beagleboard.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        leyfoon.tan@starfivetech.com,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 2/6] dt-bindings: riscv: Add StarFive JH8100 SoC
Message-ID: <20231213-imminent-favorable-a7d25e6555af@spud>
References: <20231201121410.95298-1-jeeheng.sia@starfivetech.com>
 <20231201121410.95298-3-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zXeS7EP6Yj4II9Wy"
Content-Disposition: inline
In-Reply-To: <20231201121410.95298-3-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zXeS7EP6Yj4II9Wy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 08:14:06PM +0800, Sia Jee Heng wrote:
> Add device tree bindings for the StarFive JH8100 RISC-V SoC.
>=20
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/riscv/starfive.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Docu=
mentation/devicetree/bindings/riscv/starfive.yaml
> index cc4d92f0a1bf..12d7844232b8 100644
> --- a/Documentation/devicetree/bindings/riscv/starfive.yaml
> +++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
> @@ -30,6 +30,10 @@ properties:
>                - starfive,visionfive-2-v1.3b
>            - const: starfive,jh7110
> =20
> +      - items:
> +          - enum:
> +              - starfive,jh8100-evb

Hmm, reading some of the other threads it appears that the evaluation
platform that you guys have is actually just an FPGA? Could you please
provide more information as to what this "evb" actually is?

If it is just an FPGA-based evaluation platform I don't think that we
want to merge patches for the platform. I'm fine with patches adding
peripheral support, but the soc/board dts files and things like pinctrl
or clock drivers I am not keen on.
Perhaps Emil also has an opinion on this.

Thanks,
Conor.

> +          - const: starfive,jh8100
>  additionalProperties: true
> =20
>  ...
> --=20
> 2.34.1
>=20
>=20

--zXeS7EP6Yj4II9Wy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXmm1QAKCRB4tDGHoIJi
0q72AQDhgF9fijVdRhbKeMyERN4WLOL/D6o7cI1DU92ChEiNoQEAq6oZD+7p/il+
dgQb7NS+xXKd9Q3hwC949WAUiDm63A8=
=PqAD
-----END PGP SIGNATURE-----

--zXeS7EP6Yj4II9Wy--
