Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80309810E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbjLMJ4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbjLMJz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:55:59 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31362A5;
        Wed, 13 Dec 2023 01:56:02 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BD9tsv3035793;
        Wed, 13 Dec 2023 03:55:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702461354;
        bh=i9JxcjajiZIqaXhdDVPAsNjWaUMuYvf7aLDjliyNCDM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=tZhOF3he43wkGQr6fmJpcDoVu/k7vRspSDVuF3x7FCDFG/NWUjlhHahT3qlcUPspc
         Zn3iqfFYwtrUnDiBufxeIw3Y2qkmuO0vGwIy7WUPFkkqvOQ58CxKlM/rphRzX/j/qY
         oKSltMfNbFK9JeYK7EUgrLnXb7tmTx53KSUt6czo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BD9tsav069528
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Dec 2023 03:55:54 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 03:55:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 03:55:54 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.12])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BD9trZD027827;
        Wed, 13 Dec 2023 03:55:54 -0600
Date:   Wed, 13 Dec 2023 15:25:47 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>, <m-chawdhry@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-j7*: Add additional regs for DMA
 components
Message-ID: <go65ysuu74xsg6xuqozlp4f6iqyxluxpxbafrizrj3xk5nkexk@uihz45d7wst3>
References: <20231212111634.3515175-1-vigneshr@ti.com>
 <20231212111634.3515175-3-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cecej26b2bbrda5u"
Content-Disposition: inline
In-Reply-To: <20231212111634.3515175-3-vigneshr@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--cecej26b2bbrda5u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Manorit/Vignesh,

Please recheck the addresses match each SoCs TRM.

On Dec 12, 2023 at 16:46:33 +0530, Vignesh Raghavendra wrote:
> From: Manorit Chawdhry <m-chawdhry@ti.com>
>=20
> Add additional reg properties for UDMA and RingAcc nodes which are
> mostly used by bootloader components before Device Manager firmware
> services are available, in order to setup DMA transfers.
>=20
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi        | 8 ++++++--
>  arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi  | 8 ++++++--
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi        | 8 ++++++--
>  arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi  | 8 ++++++--
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi       | 8 ++++++--
>  arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 8 ++++++--
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi       | 8 ++++++--
>  arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 8 ++++++--
>  8 files changed, 48 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/=
dts/ti/k3-j7200-main.dtsi
> index 264913f83287..97b90f4d09dd 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -281,8 +281,12 @@ main_udmap: dma-controller@31150000 {
>  			compatible =3D "ti,j721e-navss-main-udmap";
>  			reg =3D <0x00 0x31150000 0x00 0x100>,
>  			      <0x00 0x34000000 0x00 0x100000>,
> -			      <0x00 0x35000000 0x00 0x100000>;
> -			reg-names =3D "gcfg", "rchanrt", "tchanrt";
> +			      <0x00 0x35000000 0x00 0x100000>,
> +			      <0x00 0x30b00000 0x00 0x20000>,
> +			      <0x00 0x30c00000 0x00 0x8000>,
> +			      <0x00 0x30d00000 0x00 0x4000>;
> +			reg-names =3D "gcfg", "rchanrt", "tchanrt",
> +				    "tchan", "rchan", "rflow";
>  			msi-parent =3D <&main_udmass_inta>;
>  			#dma-cells =3D <1>;
> =20
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64=
/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index 3fc588b848c6..576ed7494521 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -346,8 +346,12 @@ mcu_udmap: dma-controller@285c0000 {
>  			compatible =3D "ti,j721e-navss-mcu-udmap";
>  			reg =3D <0x00 0x285c0000 0x00 0x100>,
>  			      <0x00 0x2a800000 0x00 0x40000>,
> -			      <0x00 0x2aa00000 0x00 0x40000>;
> -			reg-names =3D "gcfg", "rchanrt", "tchanrt";
> +			      <0x00 0x2aa00000 0x00 0x40000>,
> +			      <0x00 0x284a0000 0x00 0x4000>,
> +			      <0x00 0x284c0000 0x00 0x4000>,
> +			      <0x00 0x28400000 0x00 0x2000>;
> +			reg-names =3D "gcfg", "rchanrt", "tchanrt",
> +				    "tchan", "rchan", "rflow";
>  			msi-parent =3D <&main_udmass_inta>;
>  			#dma-cells =3D <1>;
> =20
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/=
dts/ti/k3-j721e-main.dtsi
> index 746b9f8b1c64..f1e995d12d74 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -382,8 +382,12 @@ main_udmap: dma-controller@31150000 {
>  			compatible =3D "ti,j721e-navss-main-udmap";
>  			reg =3D <0x0 0x31150000 0x0 0x100>,
>  			      <0x0 0x34000000 0x0 0x100000>,
> -			      <0x0 0x35000000 0x0 0x100000>;
> -			reg-names =3D "gcfg", "rchanrt", "tchanrt";
> +			      <0x0 0x35000000 0x0 0x100000>,
> +			      <0x0 0x30b00000 0x0 0x20000>,
> +			      <0x0 0x30c00000 0x0 0x8000>,

Above don't match J721E TRM, which says TCHAN has size 0x10000.

> +			      <0x00 0x30d00000 0x00 0x4000>;

Same here, TRM says 0x8000.
I did not check J7200/J721S2 TRMs, please do.

> +			reg-names =3D "gcfg", "rchanrt", "tchanrt",
> +				    "tchan", "rchan", "rflow";
>  			msi-parent =3D <&main_udmass_inta>;
>  			#dma-cells =3D <1>;
> =20
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64=
/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index f7ab7719fc07..011d93e32238 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -468,8 +468,12 @@ mcu_udmap: dma-controller@285c0000 {
>  			compatible =3D "ti,j721e-navss-mcu-udmap";
>  			reg =3D <0x0 0x285c0000 0x0 0x100>,
>  			      <0x0 0x2a800000 0x0 0x40000>,
> -			      <0x0 0x2aa00000 0x0 0x40000>;
> -			reg-names =3D "gcfg", "rchanrt", "tchanrt";
> +			      <0x0 0x2aa00000 0x0 0x40000>,
> +			      <0x0 0x284a0000 0x0 0x4000>,
> +			      <0x0 0x284c0000 0x0 0x4000>,
> +			      <0x0 0x28400000 0x0 0x2000>;
> +			reg-names =3D "gcfg", "rchanrt", "tchanrt",
> +				    "tchan", "rchan", "rflow";
>  			msi-parent =3D <&main_udmass_inta>;
>  			#dma-cells =3D <1>;
> =20
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot=
/dts/ti/k3-j721s2-main.dtsi
> index b03731b53a26..2ed469d36f1d 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
> @@ -1086,8 +1086,12 @@ main_udmap: dma-controller@31150000 {
>  			compatible =3D "ti,j721e-navss-main-udmap";
>  			reg =3D <0x0 0x31150000 0x0 0x100>,
>  			      <0x0 0x34000000 0x0 0x80000>,
> -			      <0x0 0x35000000 0x0 0x200000>;
> -			reg-names =3D "gcfg", "rchanrt", "tchanrt";
> +			      <0x0 0x35000000 0x0 0x200000>,
> +			      <0x0 0x30b00000 0x0 0x8000>,
> +			      <0x0 0x30c00000 0x0 0x20000>,
> +			      <0x0 0x30d00000 0x0 0x4000>;
> +			reg-names =3D "gcfg", "rchanrt", "tchanrt",
> +				    "tchan", "rchan", "rflow";
>  			msi-parent =3D <&main_udmass_inta>;
>  			#dma-cells =3D <1>;
> =20
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm6=
4/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> index 7254f3bd3634..75c6931480dd 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> @@ -471,8 +471,12 @@ mcu_udmap: dma-controller@285c0000 {
>  			compatible =3D "ti,j721e-navss-mcu-udmap";
>  			reg =3D <0x0 0x285c0000 0x0 0x100>,
>  			      <0x0 0x2a800000 0x0 0x40000>,
> -			      <0x0 0x2aa00000 0x0 0x40000>;
> -			reg-names =3D "gcfg", "rchanrt", "tchanrt";
> +			      <0x0 0x2aa00000 0x0 0x40000>,
> +			      <0x0 0x284a0000 0x0 0x4000>,
> +			      <0x0 0x284c0000 0x0 0x4000>,
> +			      <0x0 0x28400000 0x0 0x2000>;
> +			reg-names =3D "gcfg", "rchanrt", "tchanrt",
> +				    "tchan", "rchan", "rflow";
>  			msi-parent =3D <&main_udmass_inta>;
>  			#dma-cells =3D <1>;
> =20
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot=
/dts/ti/k3-j784s4-main.dtsi
> index d89bcddcfe3d..827328450f96 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -1188,8 +1188,12 @@ main_udmap: dma-controller@31150000 {
>  			compatible =3D "ti,j721e-navss-main-udmap";
>  			reg =3D <0x00 0x31150000 0x00 0x100>,
>  			      <0x00 0x34000000 0x00 0x80000>,
> -			      <0x00 0x35000000 0x00 0x200000>;
> -			reg-names =3D "gcfg", "rchanrt", "tchanrt";
> +			      <0x00 0x35000000 0x00 0x200000>,
> +			      <0x00 0x30b00000 0x00 0x20000>,
> +			      <0x00 0x30c00000 0x00 0x8000>,
> +			      <0x00 0x30d00000 0x00 0x4000>;
> +			reg-names =3D "gcfg", "rchanrt", "tchanrt",
> +				    "tchan", "rchan", "rflow";
>  			msi-parent =3D <&main_udmass_inta>;
>  			#dma-cells =3D <1>;
> =20
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm6=
4/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> index adb5ea6b9732..0eebb92e6a72 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> @@ -478,8 +478,12 @@ mcu_udmap: dma-controller@285c0000 {
>  			compatible =3D "ti,j721e-navss-mcu-udmap";
>  			reg =3D <0x00 0x285c0000 0x00 0x100>,
>  			      <0x00 0x2a800000 0x00 0x40000>,
> -			      <0x00 0x2aa00000 0x00 0x40000>;
> -			reg-names =3D "gcfg", "rchanrt", "tchanrt";
> +			      <0x00 0x2aa00000 0x00 0x40000>,
> +			      <0x00 0x284a0000 0x00 0x4000>,
> +			      <0x00 0x284c0000 0x00 0x4000>,
> +			      <0x00 0x28400000 0x00 0x2000>;
> +			reg-names =3D "gcfg", "rchanrt", "tchanrt",
> +				    "tchan", "rchan", "rflow";
>  			msi-parent =3D <&main_udmass_inta>;
>  			#dma-cells =3D <1>;
> =20
> --=20
> 2.43.0
>=20
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--cecej26b2bbrda5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmV5f6IACgkQQ96R+SSa
cUWB2g/+Pn4bYg6ZxVuGYNUTdzoGmSQ63nDvLblxr0PcQOTr8xwwhgcUA2zOlGxo
0ASQCv+UNxTNEmT8D/ZUiVCn88IMEITwl6z9vdIAP0KQSLwb1JLKJhP+NmZLZnpa
of7efbsTF4j39oog2xqQEQgbt0hB9mlgkIhxzBTX3ePzcJBR2vLWv+bLDut2nPKV
qp488pwewc5L3CAZFz9jrwzofUO5ivtaUTs41FrTo5MrynFj3fSW9YMXDJU6F6+q
c0Mz46WZDoCcRmMem+fgdqW7GM+tUYw+NZLLnn3YpiA5lj7BY92VVMgONbqzBzMp
j94w+KodS+jJETwyHupv7ouaCk8O2vz21AbWsFZt/QVc5TjPYAmuRz8fb7wAhivN
M7oClvdDSv5cfJGgffdwNZJ9dKZjDLI5EuCP56gkD5CPnRcCqfs2A3JC55bcByU7
rVYAAUDtrGxYoNElNydM5mHzDwMx/I9QYMgRCXrq6TqxakEDBbsKDeI2dnWpyo63
Ul4MtR/YVcXzCYTPxPSkn//qQuxcba1MIM9YNDTz7DE4FPdLcQ6hEw7z5KCxs3fP
Stv7tT/TsyovKD0ouRqOVSj5gF870dO5Zay8XX+UPtHMOj38BTRHdgyy9s2s7r2M
6WVq3D1V+/3DeOf1Ng2c3brbe+8RlwOaVWLfDldpLkeH97LSUzE=
=dcWE
-----END PGP SIGNATURE-----

--cecej26b2bbrda5u--
