Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675FF811628
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442520AbjLMPYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442508AbjLMPYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:24:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493AB120
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:24:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03851C433C9;
        Wed, 13 Dec 2023 15:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702481049;
        bh=B5L29gqlycO+tPIZOgKNoV72HJ6XozjWlal3rU7LPKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lVPC/6+XKyyz0tIrqIutuGinsKshmtQX9K9wxTkm3sC1+rQIPyzaW5Cjv4jVXGnH9
         lG0FrO6RJ7FNRNrF4ho41HaV4bgCsb5fi+Puj4KSFCVE41SB2TrIl48EH8pi6l213Z
         oIIgM0F4YQIBnV2z+ONV5tSR4gXdYrVOgx6x88N5/gFRZ1RJP4clRZLd0+5raV1c3E
         mWb7cHLKOtcBgcNNfl6GEtn3PundzviEcUBUwS6Pmh5O1G6icpeA6vK0Thcjaa2M1S
         0lEoeSN+0+1GxrD0xPR2nM3K7KBwiAZFC9IgQfaEKATuKipcEHnT7bPZtlgGkazYTi
         1dZYUH51ac3Kg==
Date:   Wed, 13 Dec 2023 15:23:58 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
        alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        conor+dt@kernel.org, conor.dooley@microchip.com,
        devicetree@vger.kernel.org, dminus@andestech.com,
        evan@rivosinc.com, geert+renesas@glider.be, guoren@kernel.org,
        heiko@sntech.de, irogers@google.com, jernej.skrabec@gmail.com,
        jolsa@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, locus84@andestech.com,
        magnus.damm@gmail.com, mark.rutland@arm.com, mingo@redhat.com,
        n.shubin@yadro.com, namhyung@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, peterz@infradead.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, sunilvl@ventanamicro.com,
        tglx@linutronix.de, tim609@andestech.com, uwu@icenowy.me,
        wens@csie.org, will@kernel.org, ycliang@andestech.com,
        inochiama@outlook.com
Subject: Re: [PATCH v5 14/16] riscv: dts: thead: Add T-Head PMU extension for
 th1520
Message-ID: <20231213-placate-flashily-fa1032e5fbbe@spud>
References: <20231213070301.1684751-1-peterlin@andestech.com>
 <20231213070301.1684751-15-peterlin@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5R35S9X3begUNP/4"
Content-Disposition: inline
In-Reply-To: <20231213070301.1684751-15-peterlin@andestech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5R35S9X3begUNP/4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 03:02:59PM +0800, Yu Chien Peter Lin wrote:
> xtheadpmu stands for T-Head Performance Monitor Unit extension.
> Based on the added T-Head PMU ISA string, the SBI PMU driver
> will make use of the non-standard irq source.
>=20
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
> Changes v4 -> v5:
>   - New patch
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/=
thead/th1520.dtsi
> index ba4d2c673ac8..2dad2b22824a 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -22,7 +22,7 @@ c910_0: cpu@0 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +					       "zifencei", "zihpm", "xtheadpmu";
>  			reg =3D <0>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -46,7 +46,7 @@ c910_1: cpu@1 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +					       "zifencei", "zihpm", "xtheadpmu";
>  			reg =3D <1>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -70,7 +70,7 @@ c910_2: cpu@2 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +					       "zifencei", "zihpm", "xtheadpmu";
>  			reg =3D <2>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> @@ -94,7 +94,7 @@ c910_3: cpu@3 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +					       "zifencei", "zihpm", "xtheadpmu";
>  			reg =3D <3>;
>  			i-cache-block-size =3D <64>;
>  			i-cache-size =3D <65536>;
> --=20
> 2.34.1
>=20

--5R35S9X3begUNP/4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXnMjgAKCRB4tDGHoIJi
0v2NAP4zNu9pr4WPo9WN/ELqPU2GWRrlI7mWHne1++rLjDRSLwD8Da4c43TnGhZq
l90y1Ur6ue8V2btuBqhGss/ahqCyhQs=
=CibF
-----END PGP SIGNATURE-----

--5R35S9X3begUNP/4--
