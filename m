Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D87F78A5C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 08:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjH1GeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 02:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjH1GeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:34:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1075C126;
        Sun, 27 Aug 2023 23:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693204438; x=1724740438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aCl90sVW5QNut/R0WQeqfLh8sCRLNOIav5lRzT5tZqI=;
  b=eP5wgE2maJTN18YXV6gyVEwNgUPgPL02xKbMWpnS2YxAXDhjvnZOGjkq
   KRKP2u9/B1LrF+W2UTIyCxi1RSLW3L8GIaUhmUYJD3AQDExwS2oJxREUe
   G9XbnvK0Ou9WSYdHEUUF8fhe0q9r2WXc+ssDU8SyWv14RWhcbDMlJOBhJ
   cs9sia+d/fvW6olNirdmLkb/I8ZXHq5WKiVij6pjNRXDl7PMr+zn7/vAU
   B3OPthaKLbOyERiiEHgmMjzMIm8vJSDJoEIjklGnx9Y8oMPgXJa7mECpm
   Qu8Z0CSXlnY7GmA5jEn2jHvcpfLwrlSVYdQCKwBdF9wGf0SiwjEUJSGNC
   w==;
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="asc'?scan'208";a="168600219"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Aug 2023 23:33:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 27 Aug 2023 23:33:49 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Sun, 27 Aug 2023 23:33:46 -0700
Date:   Mon, 28 Aug 2023 07:33:04 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Inochi Amaoto <inochiama@outlook.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>, Wei Fu <wefu@redhat.com>,
        Pei Chen <cp0613@linux.alibaba.com>,
        Wenhan Chen <chenwenhan.cwh@alibaba-inc.com>,
        Guo Ren <guoren@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] riscv: dts: allwinner: d1: Add PMU event node
Message-ID: <20230828-cupid-muck-130c4ef218f6@wendy>
References: <IA1PR20MB49534918FCA69399CE2E0C53BBE0A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DSHXjya6oD0FU0CL"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49534918FCA69399CE2E0C53BBE0A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--DSHXjya6oD0FU0CL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 12:30:22PM +0800, Inochi Amaoto wrote:
> D1 has several pmu events supported by opensbi.
> These events can be used by perf for profiling.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Link: https://dl.linux-sunxi.org/D1/Xuantie_C906_R1S0_User_Manual.pdf
> Link: https://github.com/T-head-Semi/openc906/blob/main/C906_RTL_FACTORY/=
gen_rtl/pmu/rtl/aq_hpcp_top.v#L657
> ---
> changed from v3:
> 1. remove wrong event mapping of 0x0000a
> 2. add reference url of c906 events implementation (D1 only support events
> described in R1S0 user manual, but event mapping is the same)

Why'd you drop my ack? There's nothing here that'd invalidate it AFAICT.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> changed from v2:
> 1. move pmu node from /soc to / to avoid warnings when checking.
>=20
> The meaning of T-HEAD events can be found in this pending patch:
> https://lore.kernel.org/linux-perf-users/IA1PR20MB4953DD82D0116EC291C2177=
7BBE2A@IA1PR20MB4953.namprd20.prod.outlook.com
>=20
> The patch above also provides a example that shows how to setup
> environment and use perf with T-HEAD events.
> ---
>  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/b=
oot/dts/allwinner/sun20i-d1s.dtsi
> index 8275630af977..53a984d78e3f 100644
> --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> @@ -73,4 +73,43 @@ plic: interrupt-controller@10000000 {
>  			#interrupt-cells =3D <2>;
>  		};
>  	};
> +
> +	pmu {
> +		compatible =3D "riscv,pmu";
> +		riscv,event-to-mhpmcounters =3D
> +			<0x00003 0x00003 0x00000008>,
> +			<0x00004 0x00004 0x00000010>,
> +			<0x00005 0x00005 0x00000200>,
> +			<0x00006 0x00006 0x00000100>,
> +			<0x10000 0x10000 0x00004000>,
> +			<0x10001 0x10001 0x00008000>,
> +			<0x10002 0x10002 0x00010000>,
> +			<0x10003 0x10003 0x00020000>,
> +			<0x10019 0x10019 0x00000040>,
> +			<0x10021 0x10021 0x00000020>;
> +		riscv,event-to-mhpmevent =3D
> +			<0x00003 0x00000000 0x00000001>,
> +			<0x00004 0x00000000 0x00000002>,
> +			<0x00005 0x00000000 0x00000007>,
> +			<0x00006 0x00000000 0x00000006>,
> +			<0x10000 0x00000000 0x0000000c>,
> +			<0x10001 0x00000000 0x0000000d>,
> +			<0x10002 0x00000000 0x0000000e>,
> +			<0x10003 0x00000000 0x0000000f>,
> +			<0x10019 0x00000000 0x00000004>,
> +			<0x10021 0x00000000 0x00000003>;
> +		riscv,raw-event-to-mhpmcounters =3D
> +			<0x00000000 0x00000001 0xffffffff 0xffffffff 0x00000008>,
> +			<0x00000000 0x00000002 0xffffffff 0xffffffff 0x00000010>,
> +			<0x00000000 0x00000003 0xffffffff 0xffffffff 0x00000020>,
> +			<0x00000000 0x00000004 0xffffffff 0xffffffff 0x00000040>,
> +			<0x00000000 0x00000005 0xffffffff 0xffffffff 0x00000080>,
> +			<0x00000000 0x00000006 0xffffffff 0xffffffff 0x00000100>,
> +			<0x00000000 0x00000007 0xffffffff 0xffffffff 0x00000200>,
> +			<0x00000000 0x0000000b 0xffffffff 0xffffffff 0x00002000>,
> +			<0x00000000 0x0000000c 0xffffffff 0xffffffff 0x00004000>,
> +			<0x00000000 0x0000000d 0xffffffff 0xffffffff 0x00008000>,
> +			<0x00000000 0x0000000e 0xffffffff 0xffffffff 0x00010000>,
> +			<0x00000000 0x0000000f 0xffffffff 0xffffffff 0x00020000>;
> +	};
>  };
> --
> 2.42.0
>=20

--DSHXjya6oD0FU0CL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOw/nQAKCRB4tDGHoIJi
0lubAQDUXtFzd006E4QcDgB8++nyjK7XHOdcyJ8gxq6vr3ozeAEA4kcSKZeNq6ln
Eeq59+bZ7kF7PhKl1/BFMaJVgBv/Rwg=
=Vm8G
-----END PGP SIGNATURE-----

--DSHXjya6oD0FU0CL--
