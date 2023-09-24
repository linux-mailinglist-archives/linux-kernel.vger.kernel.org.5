Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6337ACC6C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 00:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjIXWGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 18:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXWGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 18:06:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44296E8;
        Sun, 24 Sep 2023 15:06:43 -0700 (PDT)
Received: from mercury (cust-west-par-46-193-56-210.cust.wifirst.net [46.193.56.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8990D66072E5;
        Sun, 24 Sep 2023 23:06:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695593201;
        bh=sFjeHHLZbZiPI+RXlBUmPi02ydOBLFaAfIzsmR0k31c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLQjZrQVEQGKVRB84GXjFrXvdnlXmDcST9nC9kN1YIOADkTZNxLoJeT5XVNmjOTYj
         WwBCXglGUVUQeN6825yUXOjeqe0z93vDIDy7dr6SupIzDUnoGKFJwhkzHpZpGll7uZ
         MLl1fRTwvCnRwEalfyw7eXp4uSScphzO18mwVmkOLl+CYjd+6er1Q90LtmQUJuQ+Hj
         pfb8ZiwmXqwdLZY6eL4XPlgyPvX8oZNbCIM5dn2uU+0qMCaOuci1jQJeUDK9xRjJg5
         FzKMYPiA7gMZoPrsUj/5lJYoqDgDUjOKBVzm1JacXyhR6wlfTqmVo2XAzJBIXXeJUl
         MhXPpPMdT4S7g==
Received: by mercury (Postfix, from userid 1000)
        id D63E410611D9; Mon, 25 Sep 2023 00:06:39 +0200 (CEST)
Date:   Mon, 25 Sep 2023 00:06:39 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@protonmail.ch>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        FUKAUMI Naoki <naoki@radxa.com>, Jagan Teki <jagan@edgeble.ai>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add sdio node to rock-5b
Message-ID: <20230924220639.pmlm2ivktxqtvk55@mercury.elektranox.org>
References: <20230924203740.65744-1-tszucs@protonmail.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="evd46iowas6r6r5v"
Content-Disposition: inline
In-Reply-To: <20230924203740.65744-1-tszucs@protonmail.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--evd46iowas6r6r5v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Sep 24, 2023 at 08:37:45PM +0000, Tam=C3=A1s Sz=C5=B1cs wrote:
> Enable SDIO on Radxa ROCK 5 Model B M.2 Key E. Add sdio node and alias as=
 mmc2.
> Add regulator for the 3.3 V rail bringing it up during boot. Make sure EK=
EY_EN
> is muxed as GPIO.
>=20
> Signed-off-by: Tam=C3=A1s Sz=C5=B1cs <tszucs@protonmail.ch>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  .../boot/dts/rockchip/rk3588-rock-5b.dts      | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64=
/boot/dts/rockchip/rk3588-rock-5b.dts
> index 8ab60968f275..d1c3f9e10b3d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -12,6 +12,7 @@ / {
>  	aliases {
>  		mmc0 =3D &sdhci;
>  		mmc1 =3D &sdmmc;
> +		mmc2 =3D &sdio;
>  		serial2 =3D &uart2;
>  	};
> =20
> @@ -76,6 +77,21 @@ vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
>  		regulator-max-microvolt =3D <1100000>;
>  		vin-supply =3D <&vcc5v0_sys>;
>  	};
> +
> +	vcc3v3_wf: vcc3v3-wf-regulator {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc3v3_wf";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		enable-active-high;
> +		gpios =3D <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&vcc3v3_wf_en>;
> +		startup-delay-us =3D <50000>;
> +		vin-supply =3D <&vcc5v0_sys>;
> +	};
>  };
> =20
>  &cpu_b0 {
> @@ -222,6 +238,12 @@ vcc5v0_host_en: vcc5v0-host-en {
>  			rockchip,pins =3D <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
>  	};
> +
> +	m2e {
> +		vcc3v3_wf_en: vcc3v3-wf-en {
> +			rockchip,pins =3D <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
>  };
> =20
>  &pwm1 {
> @@ -258,6 +280,27 @@ &sdmmc {
>  	status =3D "okay";
>  };
> =20
> +&sdio {
> +	max-frequency =3D <200000000>;
> +	no-sd;
> +	no-mmc;
> +	non-removable;
> +	bus-width =3D <4>;
> +	cap-sdio-irq;
> +	disable-wp;
> +	keep-power-in-suspend;
> +	wakeup-source;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	vmmc-supply =3D <&vcc3v3_wf>;
> +	vqmmc-supply =3D <&vcc_1v8_s3>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&sdiom0_pins>;
> +	status =3D "okay";
> +};
> +
>  &spi2 {
>  	status =3D "okay";
>  	assigned-clocks =3D <&cru CLK_SPI2>;
> --=20
> 2.40.1
>=20
>=20

--evd46iowas6r6r5v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUQsuwACgkQ2O7X88g7
+po7tA/9GVojHnrT4ofeu/2nOa8IG0Szx1UBwyUgqqMqHi9AVyZWWAFv0Z2lm/T+
dh12mhSaIMYoCnq997/QGbnZOmnTxp2hZpoDb+Fostz/BvF8LARLaU375lEKWfxK
ufCYe54vI0mGArwPb/U99G1eIxFT0FxuzgOIqrLXHXVE+tHYqHI6hscuvVwwVhA3
ls9mfjeH8cYRkF+9ZWiASkioLFhbnkfnbN5coAPiBotQn6O36eIVfmmvxqvvRUOs
doDnR9qruAYeiYBvOFGlCDVe8hmQvCoZ1G1e2pEs/2P8Wxv6JtejiRSOEJmj4Nnf
TSpEKk506x8bFV4utcGDmjqa5LtKtXr6PvaWU1vKt5cUS6Co4/7DgEooJszeYpF/
KsILtnXmKvnSWvh6Awnx+lsZh4J4RqQRToQm3RuwG3Dpa5CBWS9z+s5CB5bbUOI2
pgevywuhaiwrS6j9WxjHDyI7+n6YHpvtBqsvOK1hxfTFfPiJEfYq/UO0gsz+0H/P
kzAPDcTA0+hSPnSR6FScMHlm7UKOTPKXStN3MEvWyS1DLRdhhXS325uVBE/LayND
ZNGn/gmXjETjGWzw3jHf0oPnk1++tGgXpOQ+PyHuVhiqmShCnMnBiWoKkRKRh4Im
LXYOG1hNIYSCqAfzXJlDuSViL4Hxv0IpbmLWHQ6Sa3nvBuuN5tM=
=Qg0D
-----END PGP SIGNATURE-----

--evd46iowas6r6r5v--
