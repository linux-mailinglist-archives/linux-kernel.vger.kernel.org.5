Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263E8811619
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442496AbjLMPXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442472AbjLMPXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:23:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB7BEA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:23:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E72DC433C8;
        Wed, 13 Dec 2023 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702481024;
        bh=EFRc6UVTwIWenNtxGxnM8RzMypWh/l2lfE9FSSBCHws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VUOYHFHIjy03kSSFNFMEdc2Djz773PL8oreL5RyNIuYOHDRkJuFvdw8mg1DB1urzk
         olaPsMkRQJ38qKNEBZk3H5Nn/KZdRhloMDP7ejcvz9GJnYjmNaOejGWC4z6J/+kroN
         qUo51gHGDFKlPcaS1yljqVA/n0OhA0ammjI6es/zfSEKpDYCy3Yw/vAjatGVIhJHzv
         m5Gu3JMAjsxxxyP+Vq8xmO5QQl3HfRRGDBsd4XnBMuP+6qBNuyAiBbbjdrH5okn6OQ
         YIVpVask+OOTPMuXjwskwXHiugCKSVTAwtRu945HyoCGJ16Vgv0RG/5BxwKN/OfADF
         3gFfNW0BRsdRg==
Date:   Wed, 13 Dec 2023 15:23:32 +0000
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
Subject: Re: [PATCH v5 12/16] riscv: dts: sophgo: Add T-Head PMU extension
 for cv1800b
Message-ID: <20231213-creatable-skintight-be6749ec63e5@spud>
References: <20231213070301.1684751-1-peterlin@andestech.com>
 <20231213070301.1684751-13-peterlin@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Jn6e/Uvtr8zl2RKI"
Content-Disposition: inline
In-Reply-To: <20231213070301.1684751-13-peterlin@andestech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Jn6e/Uvtr8zl2RKI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 03:02:57PM +0800, Yu Chien Peter Lin wrote:
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
>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dt=
s/sophgo/cv1800b.dtsi
> index aec6401a467b..8c0143f0a01b 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -29,7 +29,7 @@ cpu0: cpu@0 {
>  			riscv,isa =3D "rv64imafdc";
>  			riscv,isa-base =3D "rv64i";
>  			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zicntr", "zic=
sr",
> -					       "zifencei", "zihpm";
> +					       "zifencei", "zihpm", "xtheadpmu";
> =20
>  			cpu0_intc: interrupt-controller {
>  				compatible =3D "riscv,cpu-intc";
> --=20
> 2.34.1
>=20

--Jn6e/Uvtr8zl2RKI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXnMXwAKCRB4tDGHoIJi
0nfMAQD+JdQJ/3wj3stiTH2LRo8GYWgrPUpFyuVFHlior4g4aQD/bEX0chKiIaFn
EaPiDpwt8shNTKdrqX6XtyHtp/yDoQg=
=NpnV
-----END PGP SIGNATURE-----

--Jn6e/Uvtr8zl2RKI--
