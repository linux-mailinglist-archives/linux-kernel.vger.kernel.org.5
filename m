Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EC3810E07
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjLMJjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMJjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:39:48 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D8FA4;
        Wed, 13 Dec 2023 01:39:52 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BD9dhir085627;
        Wed, 13 Dec 2023 03:39:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702460383;
        bh=keK70TMfAzRZ9fQFbCwr3/WKxuyPl7w+gqqhjXBaF+o=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=dL9S1UnId+6oLEC/nWRfqj5r5fTMdsBmqwsdF7q0qjp/MKkyJyytt1sEZTEwRvWHq
         gNKhlP7J/srRMzaSxe5SojMWPFOFSTxLtxHrSxYFqrdur25/a+8XrgszYsXoaZAWf5
         fk8gNyY7m5s80lBhlQ7uwLVIHS3/R7SMP2SkS7zI=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BD9dhwq074915
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Dec 2023 03:39:43 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 03:39:43 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 03:39:43 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.12])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BD9dgGE009018;
        Wed, 13 Dec 2023 03:39:42 -0600
Date:   Wed, 13 Dec 2023 15:09:35 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-am6*: Add additional regs for DMA
 components
Message-ID: <rtvhpdfxap73gbpxjungp3kcexwfqao3drfrolkwcjdrin3cyb@3lyy3xhspml7>
References: <20231212111634.3515175-1-vigneshr@ti.com>
 <20231212111634.3515175-4-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="72ifukys5se4casi"
Content-Disposition: inline
In-Reply-To: <20231212111634.3515175-4-vigneshr@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--72ifukys5se4casi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vignesh,

Thanks for the patch, PKTDMA address region sizes don't seem to match=20
the TRM. Not sure if the patch is wrong or TRM is wrong.

On Dec 12, 2023 at 16:46:34 +0530, Vignesh Raghavendra wrote:
> Add additional reg properties for BCDMA and PKTDMA nodes which are
> mostly used by bootloader components before Device Manager firmware
> services are available, in order to setup DMA transfers.
>=20
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 18 ++++++++++++++----
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 18 ++++++++++++++----
>  arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 18 ++++++++++++++----
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi  | 18 ++++++++++++++----
>  4 files changed, 56 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/d=
ts/ti/k3-am62-main.dtsi
> index e5c64c86d1d5..4514a140ad38 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -121,8 +121,13 @@ main_bcdma: dma-controller@485c0100 {
>  			      <0x00 0x4c000000 0x00 0x20000>,
>  			      <0x00 0x4a820000 0x00 0x20000>,
>  			      <0x00 0x4aa40000 0x00 0x20000>,
> -			      <0x00 0x4bc00000 0x00 0x100000>;
> -			reg-names =3D "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt";
> +			      <0x00 0x4bc00000 0x00 0x100000>,
> +			      <0x00 0x48600000 0x00 0x8000>,
> +			      <0x00 0x484a4000 0x00 0x2000>,
> +			      <0x00 0x484c2000 0x00 0x2000>,
> +			      <0x00 0x48420000 0x00 0x2000>;
> +			reg-names =3D "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
> +				    "ring", "tchan", "rchan", "bchan";

BCDMA ranges LGTM, but PDMA ranges below are not matching with the TRM.

>  			msi-parent =3D <&inta_main_dmss>;
>  			#dma-cells =3D <3>;
> =20
> @@ -138,8 +143,13 @@ main_pktdma: dma-controller@485c0000 {
>  			reg =3D <0x00 0x485c0000 0x00 0x100>,
>  			      <0x00 0x4a800000 0x00 0x20000>,
>  			      <0x00 0x4aa00000 0x00 0x40000>,
> -			      <0x00 0x4b800000 0x00 0x400000>;
> -			reg-names =3D "gcfg", "rchanrt", "tchanrt", "ringrt";
> +			      <0x00 0x4b800000 0x00 0x400000>,
> +			      <0x00 0x485e0000 0x00 0x20000>,

PKTDMA RING region range 0x10000 in the TRM.

> +			      <0x00 0x484a0000 0x00 0x4000>,

PKTDMA TCHAN region range is 0x2000 in the TRM.

> +			      <0x00 0x484c0000 0x00 0x2000>,

This matches TRM.

> +			      <0x00 0x48430000 0x00 0x4000>;

PKGTMA RFLOW region range is 0x1000 in the TRM.

> +			reg-names =3D "gcfg", "rchanrt", "tchanrt", "ringrt",
> +				    "ring", "tchan", "rchan", "rflow";
>  			msi-parent =3D <&inta_main_dmss>;
>  			#dma-cells =3D <2>;
> =20
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/=
dts/ti/k3-am62a-main.dtsi
> index 4ae7fdc5221b..36947d9d644d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> @@ -101,8 +101,13 @@ main_bcdma: dma-controller@485c0100 {
>  			      <0x00 0x4c000000 0x00 0x20000>,
>  			      <0x00 0x4a820000 0x00 0x20000>,
>  			      <0x00 0x4aa40000 0x00 0x20000>,
> -			      <0x00 0x4bc00000 0x00 0x100000>;
> -			reg-names =3D "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt";
> +			      <0x00 0x4bc00000 0x00 0x100000>,
> +			      <0x00 0x48600000 0x00 0x8000>,
> +			      <0x00 0x484a4000 0x00 0x2000>,
> +			      <0x00 0x484c2000 0x00 0x2000>,
> +			      <0x00 0x48420000 0x00 0x2000>;
> +			reg-names =3D "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
> +				    "ring", "tchan", "rchan", "bchan";
>  			msi-parent =3D <&inta_main_dmss>;
>  			#dma-cells =3D <3>;
>  			ti,sci =3D <&dmsc>;
> @@ -117,8 +122,13 @@ main_pktdma: dma-controller@485c0000 {
>  			reg =3D <0x00 0x485c0000 0x00 0x100>,
>  			      <0x00 0x4a800000 0x00 0x20000>,
>  			      <0x00 0x4aa00000 0x00 0x40000>,
> -			      <0x00 0x4b800000 0x00 0x400000>;
> -			reg-names =3D "gcfg", "rchanrt", "tchanrt", "ringrt";
> +			      <0x00 0x4b800000 0x00 0x400000>,
> +			      <0x00 0x485e0000 0x00 0x20000>,
> +			      <0x00 0x484a0000 0x00 0x4000>,
> +			      <0x00 0x484c0000 0x00 0x2000>,
> +			      <0x00 0x48430000 0x00 0x4000>;

Same issue as AM62, the TRM mentions a different size for these regions.

> +			reg-names =3D "gcfg", "rchanrt", "tchanrt", "ringrt",
> +				    "ring", "tchan", "rchan", "rflow";
>  			msi-parent =3D <&inta_main_dmss>;
>  			#dma-cells =3D <2>;
>  			ti,sci =3D <&dmsc>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/=
dts/ti/k3-am62p-main.dtsi
> index 963758c7d377..21981489b4db 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> @@ -101,8 +101,13 @@ main_bcdma: dma-controller@485c0100 {
>  			      <0x00 0x4c000000 0x00 0x20000>,
>  			      <0x00 0x4a820000 0x00 0x20000>,
>  			      <0x00 0x4aa40000 0x00 0x20000>,
> -			      <0x00 0x4bc00000 0x00 0x100000>;
> -			reg-names =3D "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt";
> +			      <0x00 0x4bc00000 0x00 0x100000>,
> +			      <0x00 0x48600000 0x00 0x8000>,
> +			      <0x00 0x484a4000 0x00 0x2000>,
> +			      <0x00 0x484c2000 0x00 0x2000>,
> +			      <0x00 0x48420000 0x00 0x2000>;
> +			reg-names =3D "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
> +				    "ring", "tchan", "rchan", "bchan";
>  			msi-parent =3D <&inta_main_dmss>;
>  			#dma-cells =3D <3>;
> =20
> @@ -119,8 +124,13 @@ main_pktdma: dma-controller@485c0000 {
>  			reg =3D <0x00 0x485c0000 0x00 0x100>,
>  			      <0x00 0x4a800000 0x00 0x20000>,
>  			      <0x00 0x4aa00000 0x00 0x40000>,
> -			      <0x00 0x4b800000 0x00 0x400000>;
> -			reg-names =3D "gcfg", "rchanrt", "tchanrt", "ringrt";
> +			      <0x00 0x4b800000 0x00 0x400000>,
> +			      <0x00 0x485e0000 0x00 0x20000>,
> +			      <0x00 0x484a0000 0x00 0x4000>,
> +			      <0x00 0x484c0000 0x00 0x2000>,
> +			      <0x00 0x48430000 0x00 0x4000>;

Same here as well.

> +			reg-names =3D "gcfg", "rchanrt", "tchanrt", "ringrt",
> +				    "ring", "tchan", "rchan", "rflow";
>  			msi-parent =3D <&inta_main_dmss>;
>  			#dma-cells =3D <2>;
>  			bootph-all;
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/d=
ts/ti/k3-am64-main.dtsi
> index 0be642bc1b86..bcdfd61c7d98 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -138,8 +138,13 @@ main_bcdma: dma-controller@485c0100 {
>  			      <0x00 0x4c000000 0x00 0x20000>,
>  			      <0x00 0x4a820000 0x00 0x20000>,
>  			      <0x00 0x4aa40000 0x00 0x20000>,
> -			      <0x00 0x4bc00000 0x00 0x100000>;
> -			reg-names =3D "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt";
> +			      <0x00 0x4bc00000 0x00 0x100000>,
> +			      <0x00 0x48600000 0x00 0x8000>,
> +			      <0x00 0x484a4000 0x00 0x2000>,
> +			      <0x00 0x484c2000 0x00 0x2000>,
> +			      <0x00 0x48420000 0x00 0x2000>;
> +			reg-names =3D "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
> +				    "ring", "tchan", "rchan", "bchan";
>  			msi-parent =3D <&inta_main_dmss>;
>  			#dma-cells =3D <3>;
> =20
> @@ -155,8 +160,13 @@ main_pktdma: dma-controller@485c0000 {
>  			reg =3D <0x00 0x485c0000 0x00 0x100>,
>  			      <0x00 0x4a800000 0x00 0x20000>,
>  			      <0x00 0x4aa00000 0x00 0x40000>,
> -			      <0x00 0x4b800000 0x00 0x400000>;
> -			reg-names =3D "gcfg", "rchanrt", "tchanrt", "ringrt";
> +			      <0x00 0x4b800000 0x00 0x400000>,
> +			      <0x00 0x485e0000 0x00 0x20000>,
> +			      <0x00 0x484a0000 0x00 0x4000>,
> +			      <0x00 0x484c0000 0x00 0x2000>,
> +			      <0x00 0x48430000 0x00 0x4000>;

Did not check TRM for AM64, might need a fix here as well.

> +			reg-names =3D "gcfg", "rchanrt", "tchanrt", "ringrt",
> +				    "ring", "tchan", "rchan", "rflow";
>  			msi-parent =3D <&inta_main_dmss>;
>  			#dma-cells =3D <2>;
> =20
> --=20
> 2.43.0
>=20
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--72ifukys5se4casi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmV5e8kACgkQQ96R+SSa
cUVKaw/+L/VlEwQWxas26FDBdMs4Icufi9oYTi2+SG7kLrk8FALytjWYKJACCWSD
6i2qmL5XPzMgALgv80pH5x5r7EYKpD7r0pvMbaoz+LqGxxqQzg2bkw3Nkrf/RB7M
j4JY4jkZOcGk9d7NF6XrpgibArXHZ/ouvpLh8owIOMnXBYKfV5g1xc5Jvy+yRbPe
7S6jEcpZzSnyT4Qy06mBFGDNYZkemGf9msSmMGV5KeWAxREunOD9l6HDcwJ07SN1
mW8dyndefZvHFOIAWmlue3lUqKrcIhOVMPM5b1e+TrNXIF1mgIm613TMb9phgQfT
n3chHd8gAo/IbGJMbI/Gvo0oABFXZKYGlwIi0ErunLeWHfKDYKUVJDfwBQC1UL6L
rg5PZWsmXUHnszLtQ6GfqfpgPKS0NuLHyMkk2hPKvHIhQ0JL9mq4Sv9T+kJkjeTM
TmlnZdaWuJSOVS9AyEaan4UZ07Dv0LmfPgOhBrcqtsTQwB5UdNLA0vBPUdqqOWv5
jHWuM6Rr6iPJD/Hazjzyv0sQfSXvoGLggbri05ltTE8yBTTZ3EPkFnoz/tMJ7/Bf
vBlyJbpwwM4z6wXzVQNAHRVg3jjS6kbdQ277KQXRo96v0cgReJVQBpoijV6rduKo
vH6AT3a2H3Ki1T1aEBApWHwkHZQ0qOvlDc5yGRXHcNgjM+ipoDM=
=RT0t
-----END PGP SIGNATURE-----

--72ifukys5se4casi--
