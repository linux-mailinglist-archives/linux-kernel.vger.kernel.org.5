Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF5976CBB9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjHBLYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjHBLYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:24:08 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA62AE70;
        Wed,  2 Aug 2023 04:24:06 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372BNlAv051750;
        Wed, 2 Aug 2023 06:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690975427;
        bh=uSMGR7Vdm2lM9r/d7beJA61be1vAlM4u+oTFvOZ9cGg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=vdEWx89aXmNvqCvkZEZOlUZmwkwFfBGf3aiYsyq0lqyWU/xRqMaJhlhKkS0OdCC8i
         nnNDNK2dtiGt/JZHHc2L4LwxsI20/rpp84bf4Y0UVAcaBIKsqrugbFYN/NwHB5iGL5
         Vhn7eLIIbzrylFlRQNcctKQDN/qcbCzZxl7Bk8Vc=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372BNl1M129611
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 06:23:47 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 06:23:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 06:23:46 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372BNkkC102315;
        Wed, 2 Aug 2023 06:23:46 -0500
Date:   Wed, 2 Aug 2023 16:53:50 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/4] arm64: dts: ti: k3-am62x: Enable AUDIO_REFCLKx
Message-ID: <itvg2zmmapbfmgbwos6c4y5zsc2rb3sffv2znhwz6i2vahe4y6@uu2547kcz5sd>
References: <20230731142135.108477-1-francesco@dolcini.it>
 <20230731142135.108477-2-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v4gamd5lzmdkps2a"
Content-Disposition: inline
In-Reply-To: <20230731142135.108477-2-francesco@dolcini.it>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--v4gamd5lzmdkps2a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Francesco,

Thank you for posting this patch.

On Jul 31, 2023 at 16:21:32 +0200, Francesco Dolcini wrote:
> From: Jai Luthra <j-luthra@ti.com>
>=20
> On AM62-based SoCs the AUDIO_REFCLKx clocks can be used as an input to
> external peripherals when configured through CTRL_MMR, so add the
> clock nodes.
>=20
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 18 ++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 18 ++++++++++++++++++

Given currently none of the AM62A boards are using the refclks, can you=20
drop those or just mark the nodes as disabled. Whoever is the first user=20
can enable them.

With that change, LGTM.
Not sure if I can provide an R-by tag, given I'm the author.

>  2 files changed, 36 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/d=
ts/ti/k3-am62-main.dtsi
> index 33b6aadc9083..3a1b387bbf49 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -60,6 +60,24 @@ epwm_tbclk: clock@4130 {
>  			reg =3D <0x4130 0x4>;
>  			#clock-cells =3D <1>;
>  		};
> +
> +		audio_refclk0: clock@82e0 {
> +			compatible =3D "ti,am62-audio-refclk";
> +			reg =3D <0x82e0 0x4>;
> +			clocks =3D <&k3_clks 157 0>;
> +			assigned-clocks =3D <&k3_clks 157 0>;
> +			assigned-clock-parents =3D <&k3_clks 157 8>;
> +			#clock-cells =3D <0>;
> +		};
> +
> +		audio_refclk1: clock@82e4 {
> +			compatible =3D "ti,am62-audio-refclk";
> +			reg =3D <0x82e4 0x4>;
> +			clocks =3D <&k3_clks 157 10>;
> +			assigned-clocks =3D <&k3_clks 157 10>;
> +			assigned-clock-parents =3D <&k3_clks 157 18>;
> +			#clock-cells =3D <0>;
> +		};
>  	};
> =20
>  	dmss: bus@48000000 {
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/=
dts/ti/k3-am62a-main.dtsi
> index 8397cb80f559..30b163a9b248 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> @@ -60,6 +60,24 @@ epwm_tbclk: clock-controller@4130 {
>  			reg =3D <0x4130 0x4>;
>  			#clock-cells =3D <1>;
>  		};
> +
> +		audio_refclk0: clock@82e0 {
> +			compatible =3D "ti,am62-audio-refclk";
> +			reg =3D <0x82e0 0x4>;
> +			clocks =3D <&k3_clks 157 0>;
> +			assigned-clocks =3D <&k3_clks 157 0>;
> +			assigned-clock-parents =3D <&k3_clks 157 8>;
> +			#clock-cells =3D <0>;
> +		};
> +
> +		audio_refclk1: clock@82e4 {
> +			compatible =3D "ti,am62-audio-refclk";
> +			reg =3D <0x82e4 0x4>;
> +			clocks =3D <&k3_clks 157 10>;
> +			assigned-clocks =3D <&k3_clks 157 10>;
> +			assigned-clock-parents =3D <&k3_clks 157 18>;
> +			#clock-cells =3D <0>;
> +		};
>  	};
> =20
>  	dmss: bus@48000000 {
> --=20
> 2.25.1
>=20
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--v4gamd5lzmdkps2a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmTKPMUACgkQQ96R+SSa
cUV5PhAAw7AayiEwopqqFyzXTXqvB7Ydaib87VNWpoXzhhzSB9EORMpIlY3i2+EZ
iyYfAznYEMgj9h29IJ9C7cCrKdKcYb23FNbEAl52X43XDGqenAnCUjOUFmjmNR6Q
tWf91YOnfGMSa4/Svonwxh87fiuNHTke9TblUsF1rUDYuKWcGZNcSuoOv0i7wfhk
RxER8Lz6Ko/4e2SqYv8anpxKiuvH81zBfdcLcfJLK2dBBzk5dGPkPUpcfiH3KYy8
Ct7efa3q+C1ZfqIwTMq4DEw80AcQpadKgJQ1srnqpaOHJlMz/pv3yzNJ0YcevWaU
BElCbSAq6UmJ4mldDkjyIjqX/zrAhKqXbbdemNJPVaa1mZrTODJMoo+WhVxhNi2X
Pv33STqrpfxE3t7y8sWsdyn0pIBzsDDD+h9IbrrmvwEINO0lxyj/TXZZUjFGdF3m
23GVIyP3ic4u2wGiNYvA8kOewoXYW8T09XN6U0zIic18P/L2vUi8tj1cTcTRAggW
+gMhw4nAuhQtgMlDXxCER5hpgjdvXZOFPet2QxH4ZA3RE4WJbyuAkeyDPLiCpGYj
HV7hrr6mscCWVMtJ0ONDmU+lFYibJwE4Q+3UOimfPTz2cq+arT3efnIw9acd7/pk
PzR4tR/9AWlckiG8Wb8pn83BxKK9ftpoby+6E5+jxo7vApLf/Us=
=VKzc
-----END PGP SIGNATURE-----

--v4gamd5lzmdkps2a--
