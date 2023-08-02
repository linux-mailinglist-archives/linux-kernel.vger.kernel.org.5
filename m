Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1520F76CB9A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjHBLS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjHBLS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:18:27 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669091FC3;
        Wed,  2 Aug 2023 04:18:26 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372BI20q112761;
        Wed, 2 Aug 2023 06:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690975082;
        bh=KWon4KBwVWiiG+eUhsI5BTOkGd4UTIHNuh35HdskuGg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=AxrmWu29VUHP46x3C79c3IUpxlqIxeNXZezY1+2eic1TTEZpnLm/RmYHUonjJ06Kk
         twIMc9M11CaNlVBVGJN2Xgazsu8enxIkoFs9/Wo0bu9PMA4daRo4+P/qt9Ah8Kz+sX
         rPGNVQHJCkqmylq/QyYhIolbydgtIKlmFOBvo9+U=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372BI21G126816
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 06:18:02 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 06:18:02 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 06:18:02 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372BI1Et097101;
        Wed, 2 Aug 2023 06:18:02 -0500
Date:   Wed, 2 Aug 2023 16:48:06 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 4/4] arm64: dts: ti: verdin-am62: dahlia: add sound
 card
Message-ID: <zdndm2ifskvxb2x7jjntrsxzzglayzupntmiqk4onlmog66p7j@ss6ns5fsxmws>
References: <20230731142135.108477-1-francesco@dolcini.it>
 <20230731142135.108477-5-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bka3o4bzxg3rd7b2"
Content-Disposition: inline
In-Reply-To: <20230731142135.108477-5-francesco@dolcini.it>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--bka3o4bzxg3rd7b2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 31, 2023 at 16:21:35 +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> Add WM8904 based analog sound card to Dahlia carrier board.
>=20
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Reviewed-by: Jai Luthra <j-luthra@ti.com>

> ---
>  .../boot/dts/ti/k3-am62-verdin-dahlia.dtsi    | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi b/arch/arm=
64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
> index 3abd8d1d6761..e59235d6a8e6 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
> @@ -8,6 +8,43 @@
>   * https://www.toradex.com/products/carrier-board/dahlia-carrier-board-k=
it
>   */
> =20
> +/ {
> +	reg_1v8_sw: regulator-1v8-sw {
> +		compatible =3D "regulator-fixed";
> +		regulator-max-microvolt =3D <1800000>;
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-name =3D "On-carrier +V1.8_SW";
> +	};
> +
> +	sound {
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,bitclock-master =3D <&codec_dai>;
> +		simple-audio-card,format =3D "i2s";
> +		simple-audio-card,frame-master =3D <&codec_dai>;
> +		simple-audio-card,name =3D "verdin-wm8904";
> +		simple-audio-card,routing =3D
> +			"Headphone Jack", "HPOUTL",
> +			"Headphone Jack", "HPOUTR",
> +			"IN2L", "Line In Jack",
> +			"IN2R", "Line In Jack",
> +			"Headphone Jack", "MICBIAS",
> +			"IN1L", "Headphone Jack";
> +		simple-audio-card,widgets =3D
> +			"Microphone", "Headphone Jack",
> +			"Headphone", "Headphone Jack",
> +			"Line", "Line In Jack";
> +
> +		codec_dai: simple-audio-card,codec {
> +			clocks =3D <&audio_refclk1>;
> +			sound-dai =3D <&wm8904_1a>;
> +		};
> +
> +		simple-audio-card,cpu {
> +			sound-dai =3D <&mcasp0>;
> +		};
> +	};
> +};
> +
>  /* Verdin ETHs */
>  &cpsw3g {
>  	status =3D "okay";
> @@ -46,6 +83,22 @@ &main_gpio0 {
>  &main_i2c1 {
>  	status =3D "okay";
> =20
> +	/* Audio Codec */
> +	wm8904_1a: audio-codec@1a {
> +		compatible =3D "wlf,wm8904";
> +		reg =3D <0x1a>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_i2s1_mclk>;
> +		#sound-dai-cells =3D <0>;
> +		clocks =3D <&audio_refclk1>;
> +		clock-names =3D "mclk";
> +		AVDD-supply =3D <&reg_1v8_sw>;
> +		CPVDD-supply =3D <&reg_1v8_sw>;
> +		DBVDD-supply =3D <&reg_1v8_sw>;
> +		DCVDD-supply =3D <&reg_1v8_sw>;
> +		MICVDD-supply =3D <&reg_1v8_sw>;
> +	};
> +
>  	/* Current measurement into module VCC */
>  	hwmon@40 {
>  		compatible =3D "ti,ina219";
> --=20
> 2.25.1
>=20
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--bka3o4bzxg3rd7b2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmTKO20ACgkQQ96R+SSa
cUW7exAAmmDM8Sw8w8EbR1Fn6fq1lJHGu6KGl5Sd6OYbfCI4DbSj3tuFia3xr3L6
KdD6M5F0Gnhkr2hzo3pQQ49AR3NG1DYZ2qz2aPzxHVJk0+oj0ELKO7H92Ds/mOGr
+Anp4ElVYw8gYCQSZfmqbflJyQqYUMenJvXyC7VZgztsBwKQrKCJl/1NjtU8FKu5
hM4cwB9JTypNem+wtDN1BAC4GVUU/MsA67pzQ+tfVKgk9xC+p3k+Wmi3mWfaZF23
iMK6PcihHKpjgHFGQpBjbUYdG9vQi8kAE0gsGflD+XxgoDeFtXA8iEBOvf3u03E6
+ESTGRJBlbVCjXwkhlnpYK0Bge3gI7+hs1Q1utNwYVswlTYkRRWXXglig6um/S4j
NAhOhM50wr/nBEm44mvWG9ZyVXAF3cq0eVy8rjUUg1csQUR56P2DYQ/poKvEnvY2
k2q8CCu+hNClcdksjUvuJ4Lz/eq6qFpc4nPw5CGnqS9x0IuoyTimeIdgEmtgoU8N
i2AD9r3aofM3IEAderblMR4ctQsfXzZuqZEAx7WbqgFgUYeXUz3+okH3UWqKRn/Q
bCJWa+V1yHa7qQRX+sAQUKRzM2KEMmBZvPO0wwezQUDmhTVEp9Crx1G61z7TK6o7
NJvf95kOdp1UR2slN51XxQ4/IzfK/YNsBA6/qBjUq71GWWEH/Hw=
=yRN9
-----END PGP SIGNATURE-----

--bka3o4bzxg3rd7b2--
