Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649EF7B099B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjI0QHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjI0QH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:07:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960F091
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:07:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CADC433C8;
        Wed, 27 Sep 2023 16:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695830847;
        bh=vREQr+TR53h6caEkfQ4IrnqEtO45twz+uZ9hCc2obu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YLiMB/CF/b7ES5Ch2rtb1yTyMNVz4fc6XLByrXzpRVoo3XAVJ/3Dp276EU2D+aXjW
         cBTYq16kabwv0jrrygFKoBIdQ2vLK+XShJ1LjYEmVXRU3y/M9MSwmD6YWM8PQ2yRZJ
         KCQOyk7kwcBLWNjaKBqrqd/fc6AnqZdntyN86zqCOgknH9HgKJTIBhX2eMwEp7V8gH
         aeUXHWoKgGh4TpBOYrSiuA7dWIoVN6LzvdpxIwGALhl16LteDgrnhofQNZmCuvwBjC
         wF8JwC3B4uWk/1Y4aR/mj+gNC1RjeTF1QVduJA25Rs4sYAHmxuSw04TSAnkfV8VAta
         pMvchpJ7Fdjwg==
Date:   Wed, 27 Sep 2023 17:07:21 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com,
        Inochi Amaoto <inochiama@outlook.com>,
        Chen Wang <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH v3 09/11] riscv: dts: add initial Sophgo SG2042 SoC
 device tree
Message-ID: <20230927-alone-unknown-ae3f2f79378e@spud>
References: <cover.1695804418.git.unicornxw@gmail.com>
 <e71955fb3a7bb9ed9b6cab0cc81fd60d05d3310a.1695804418.git.unicornxw@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U5cY2nKFUhtXEW0P"
Content-Disposition: inline
In-Reply-To: <e71955fb3a7bb9ed9b6cab0cc81fd60d05d3310a.1695804418.git.unicornxw@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U5cY2nKFUhtXEW0P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Sep 27, 2023 at 05:02:26PM +0800, Chen Wang wrote:
> Milk-V Pioneer motherboard is powered by SG2042.
>=20
> SG2042 is server grade chip with high performance, low power
> consumption and high data throughput.
> Key features:
> - 64 RISC-V cpu cores
> - 4 cores per cluster, 16 clusters on chip
> - More info is available at [1].
>=20
> Link: https://en.sophgo.com/product/introduce/sg2042.html [1]

Link: tags go into the signoff/trailers block below.

> Currently only support booting into console with only uart,
> other features will be added soon later.
>=20
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Acked-by: Chao Wei <chao.wei@sophgo.com>
> Co-developed-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Co-developed-by: Inochi Amaoto <inochiama@outlook.com>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> Signed-off-by: Chen Wang <unicornxw@gmail.com>
> ---
>  MAINTAINERS                                 |    1 +
>  arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi | 1880 +++++++++++++++++++
>  arch/riscv/boot/dts/sophgo/sg2042.dtsi      |  325 ++++
>  3 files changed, 2206 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
>  create mode 100644 arch/riscv/boot/dts/sophgo/sg2042.dtsi
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3fed8e3d273f..08f8fabb54b1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20067,6 +20067,7 @@ SOPHGO DEVICETREES
>  M:	Chao Wei <chao.wei@sophgo.com>
>  M:	Chen Wang <unicornxw@gmail.com>
>  S:	Maintained
> +F:	arch/riscv/boot/dts/sophgo/
>  F:	Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-=
clint-mswi.yaml
>  F:	Documentation/devicetree/bindings/riscv/sophgo.yaml
>  F:	Documentation/devicetree/bindings/timer/sophgo,sg2042-clint-mtimer.ya=
ml
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi b/arch/riscv/boo=
t/dts/sophgo/sg2042-cpus.dtsi
> new file mode 100644
> index 000000000000..d2348acea527
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> @@ -0,0 +1,1880 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2022 Sophgo Technology Inc. All rights reserved.
> + */
> +
> +/*
> + * c920 declares "rv64gcv", but the version of it's v-ext
> + * is 0.7.1. It's not supported by kernel so we remove "v".
> + */

This is incorrect, v needs to be removed because the version of vector
does not match that in the ratified standard, as defined by the
dt-binding. Even if the comment was correct, it'd be a statement of
the obvious and should be removed.

> +#define ISA_BASE	"rv64i"
> +#define ISA_EXTENSIONS	\
> +	"i", "m", "a", "f", "d", "c", "zicntr", "zicsr", "zifencei", "zihpm"

Why do these as macros but leave the riscv,isa property not as one? TBH,
I'd rather these were not macros to make my life easier while grepping
through stuff etc.

Cheers,
Conor.

> +		cpu0: cpu@0 {
> +			compatible =3D "thead,c920", "riscv";
> +			device_type =3D "cpu";
> +			riscv,isa =3D "rv64imafdc";
> +			riscv,isa-base =3D ISA_BASE;
> +			riscv,isa-extensions =3D ISA_EXTENSIONS;
> +			reg =3D <0>;
> +			i-cache-block-size =3D <64>;
> +			i-cache-size =3D <65536>;
> +			i-cache-sets =3D <512>;
> +			d-cache-block-size =3D <64>;
> +			d-cache-size =3D <65536>;
> +			d-cache-sets =3D <512>;
> +			next-level-cache =3D <&l2_cache0>;
> +			mmu-type =3D "riscv,sv39";
> +
> +			cpu0_intc: interrupt-controller {
> +				compatible =3D "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +			};
> +		};

--U5cY2nKFUhtXEW0P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRRTOQAKCRB4tDGHoIJi
0tuuAQDLkuOIMgSTkDqdEzlhV9cUgxCWJjvRW7p6NMKaLb+4lQD+POy4IPtSAsle
sg4/VmVfMhRWEOlHvRoHAU1jS+TgNwQ=
=xdKV
-----END PGP SIGNATURE-----

--U5cY2nKFUhtXEW0P--
