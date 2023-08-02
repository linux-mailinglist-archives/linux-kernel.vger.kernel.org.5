Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C6576CB97
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjHBLRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjHBLRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:17:35 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CA41FC3;
        Wed,  2 Aug 2023 04:17:34 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372BHK4G096404;
        Wed, 2 Aug 2023 06:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690975040;
        bh=xr98cOBVABufhiKou8Ro4j3nz0vnzShPwV2KlpXLLnY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xijtB7/hF8Mzvy7O3mku1H5SWLcZNarUA+z8+ceqEQpporHPcz4OjwDns2yyvBN2R
         FWDJ4ZjCNavPPIEeUP18xeBtHGK8c6Dbog/0H2Qo2MA5lvYxViQv7bvbXPbsyQnAnp
         guhlvEcUjt9i+54mr7mD31H0MUgrT9TwypJsysF4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372BHKJ4126470
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 06:17:20 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 06:17:20 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 06:17:20 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372BHJcs099205;
        Wed, 2 Aug 2023 06:17:20 -0500
Date:   Wed, 2 Aug 2023 16:47:24 +0530
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
Subject: Re: [PATCH v1 3/4] arm64: dts: ti: verdin-am62: dev: add sound card
Message-ID: <6vldeh4uhffgkf4zz2jsaliv4nze7ksdd2q2dr4pjdkt4x26ft@c4r6jq5tuxmm>
References: <20230731142135.108477-1-francesco@dolcini.it>
 <20230731142135.108477-4-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lt6h76c2hezqgq7w"
Content-Disposition: inline
In-Reply-To: <20230731142135.108477-4-francesco@dolcini.it>
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

--lt6h76c2hezqgq7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 31, 2023 at 16:21:34 +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> Add NAU8822 based analog sound card to Development carrier board.
>=20
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Reviewed-by: Jai Luthra <j-luthra@ti.com>

> ---
>  .../arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi b/arch/arm64/=
boot/dts/ti/k3-am62-verdin-dev.dtsi
> index 846caee7dfa4..8f4ca7d3cad5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
> @@ -8,6 +8,42 @@
>   * https://www.toradex.com/products/carrier-board/verdin-development-boa=
rd-kit
>   */
> =20
> +/ {
> +	sound {
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,bitclock-master =3D <&codec_dai>;
> +		simple-audio-card,format =3D "i2s";
> +		simple-audio-card,frame-master =3D <&codec_dai>;
> +		simple-audio-card,name =3D "verdin-nau8822";
> +		simple-audio-card,routing =3D
> +			"Headphones", "LHP",
> +			"Headphones", "RHP",
> +			"Speaker", "LSPK",
> +			"Speaker", "RSPK",
> +			"Line Out", "AUXOUT1",
> +			"Line Out", "AUXOUT2",
> +			"LAUX", "Line In",
> +			"RAUX", "Line In",
> +			"LMICP", "Mic In",
> +			"RMICP", "Mic In";
> +		simple-audio-card,widgets =3D
> +			"Headphones", "Headphones",
> +			"Line Out", "Line Out",
> +			"Speaker", "Speaker",
> +			"Microphone", "Mic In",
> +			"Line", "Line In";
> +
> +		codec_dai: simple-audio-card,codec {
> +			clocks =3D <&audio_refclk1>;
> +			sound-dai =3D <&nau8822_1a>;
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
>  	pinctrl-names =3D "default";
> @@ -65,6 +101,15 @@ &main_gpio0 {
>  &main_i2c1 {
>  	status =3D "okay";
> =20
> +	/* Audio Codec */
> +	nau8822_1a: audio-codec@1a {
> +		compatible =3D "nuvoton,nau8822";
> +		reg =3D <0x1a>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_i2s1_mclk>;
> +		#sound-dai-cells =3D <0>;
> +	};
> +
>  	/* IO Expander */
>  	gpio_expander_21: gpio@21 {
>  		compatible =3D "nxp,pcal6416";
> --=20
> 2.25.1
>=20
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--lt6h76c2hezqgq7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmTKO0MACgkQQ96R+SSa
cUX/xQ//ejFbBaHslROLv/4D76KkZwARkj+Zl2C6KCjnoEip6tGerv9zJRrTAHDC
yymSo0SE3/70IeHa/PNliBo+eMsbWnKibhHNGlk+96rxnKRtKi217v/Zogz+uWQU
3j2kdG9IuFMRIO5tMsqFkxYBbSYVdmeyZFY/L7JN4vhxr5jAzoOK0i+JZV7HFf7m
T+dQ2jXZ8kSuY0B1i6Qd+O01GhyTMvUSnG8FGgJagCzOsmQC7gQ9HRW3UjSxbJ/k
Mmuy4KIABuCVm4WJ4JHiMzrlyeQkbIHsZPVLrvcSGYlQa6QnXzR0VsQ5GwiX+fzQ
l/MS1ABCHZ82vwz8vw3X98LmZm52HzZuMkYNol3oyZQKm6fhP2ozUPruPfwgBugD
N6mH+F/tlOSXhVTPK6cnEO/ADbx5TwYKpQxZ80NzRSXyr48WbkKwznLFx7T8Tvdo
UhJgnODQL0Mg9AlxPjShA9wEWSAk72Os8kJGN+b4vg8ozsHyI28UxjKD5r0xuE5n
MNvI0qujtO5S5u4Lhp5FbQfawsF5viVnCEGHqxY1+mXuEtfFcmY+j0qJWewyILJc
gxMjzLnVYgWTNKBdkKyvh9Uzr4+KifdvSuwkmWy07hh+x/RTMwKWXAJVOthWJaSS
BbrPdCBRVnxKHYVn75lMq1Sh8sVXaSf6C5xzU5tUdGBe/XPgGow=
=arFB
-----END PGP SIGNATURE-----

--lt6h76c2hezqgq7w--
