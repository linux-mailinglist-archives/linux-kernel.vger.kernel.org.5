Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350AD7D547D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343660AbjJXO4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbjJXOz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:55:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61219CC;
        Tue, 24 Oct 2023 07:55:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F191C433C8;
        Tue, 24 Oct 2023 14:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698159355;
        bh=vuJgsrEAfHidl/LC9Nby8frF6rGsOt8evp6na8amWoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pMHpAmKrY5a40YB98zv5cEhynF8IqCDt6qfDAfb4kCtLCcfEYiL9OAmfF0K9kSNT+
         clGdZ70etIcvNEdH2kzEw5bwQDNFjBHvkvfP9Itq2TQYT8D1QKfiqkEbf1BwkpqLFy
         P5LPZ3OsWVFSCEQakmvXwsYGP5Mj7Zv31WCg25pWhUrQlVq/DfnKY2rLYSa46lMayq
         hg9xs5ZcwRpPJGohlI6wyZ+eHzYdY8iF8gKMBVkawAQcJiBeqGyG6GBrBfKCRaR3tx
         KlG7TKZtCzTF3M8xsU42Gr+snuZpjW8Dz+IZxw+9i9PJXd+Rb3aUFTMCdzDJA0SDCT
         jRkRP0B0T7wjw==
Date:   Tue, 24 Oct 2023 15:55:50 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nylon Chen <nylon.chen@sifive.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, emil.renner.berthing@canonical.com,
        vincent.chen@sifive.com, greentime.hu@sifive.com,
        zong.li@sifive.com, nylon7717@gmail.com
Subject: Re: [v5 1/2] riscv: dts: sifive: unleashed/unmatched: Remove PWM
 controlled LED's active-low properties
Message-ID: <20231024-yin-coliseum-11f5e06fec14@spud>
References: <20231024101902.6689-1-nylon.chen@sifive.com>
 <20231024101902.6689-2-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H7Zl3g4CczEwNK1s"
Content-Disposition: inline
In-Reply-To: <20231024101902.6689-2-nylon.chen@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H7Zl3g4CczEwNK1s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Oct 24, 2023 at 06:19:01PM +0800, Nylon Chen wrote:
> This removes the active-low properties of the PWM-controlled LEDs in
> the HiFive Unmatched device tree.
>=20
> The reference is hifive-unleashed-a00.pdf[0] and hifive-unmatched-schemat=
ics-v3.pdf[1].
>=20
> Link: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf845=
3f8698_hifive-unleashed-a00-schematics-1.pdf [0]
> Link: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce7=
6f4192_hifive-unmatched-schematics-v3.pdf [1]

>=20

This blank line should be removed if there is a follow-up.

> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>

What did Vincent contribute to this patch? Are you missing a
co-developed-by tag, perhaps?

> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

I expect this to go via the pwm tree since this is going to "break" (in
the loosest possible sense) existing systems if merged separately.

Cheers,
Conor.

> ---
>  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  8 ++++----
>  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 12 ++++--------
>  2 files changed, 8 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/r=
iscv/boot/dts/sifive/hifive-unleashed-a00.dts
> index 900a50526d77..11e7ac1c54bb 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> @@ -49,7 +49,7 @@ led-controller {
>  		compatible =3D "pwm-leds";
> =20
>  		led-d1 {
> -			pwms =3D <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
> +			pwms =3D <&pwm0 0 7812500 0>;
>  			active-low;
>  			color =3D <LED_COLOR_ID_GREEN>;
>  			max-brightness =3D <255>;
> @@ -57,7 +57,7 @@ led-d1 {
>  		};
> =20
>  		led-d2 {
> -			pwms =3D <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
> +			pwms =3D <&pwm0 1 7812500 0>;
>  			active-low;
>  			color =3D <LED_COLOR_ID_GREEN>;
>  			max-brightness =3D <255>;
> @@ -65,7 +65,7 @@ led-d2 {
>  		};
> =20
>  		led-d3 {
> -			pwms =3D <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
> +			pwms =3D <&pwm0 2 7812500 0>;
>  			active-low;
>  			color =3D <LED_COLOR_ID_GREEN>;
>  			max-brightness =3D <255>;
> @@ -73,7 +73,7 @@ led-d3 {
>  		};
> =20
>  		led-d4 {
> -			pwms =3D <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
> +			pwms =3D <&pwm0 3 7812500 0>;
>  			active-low;
>  			color =3D <LED_COLOR_ID_GREEN>;
>  			max-brightness =3D <255>;
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/r=
iscv/boot/dts/sifive/hifive-unmatched-a00.dts
> index 07387f9c135c..b328ee80693f 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> @@ -51,8 +51,7 @@ led-controller-1 {
>  		compatible =3D "pwm-leds";
> =20
>  		led-d12 {
> -			pwms =3D <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
> -			active-low;
> +			pwms =3D <&pwm0 0 7812500 0>;
>  			color =3D <LED_COLOR_ID_GREEN>;
>  			max-brightness =3D <255>;
>  			label =3D "d12";
> @@ -68,20 +67,17 @@ multi-led {
>  			label =3D "d2";
> =20
>  			led-red {
> -				pwms =3D <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
> -				active-low;
> +				pwms =3D <&pwm0 2 7812500 0>;
>  				color =3D <LED_COLOR_ID_RED>;
>  			};
> =20
>  			led-green {
> -				pwms =3D <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
> -				active-low;
> +				pwms =3D <&pwm0 1 7812500 0>;
>  				color =3D <LED_COLOR_ID_GREEN>;
>  			};
> =20
>  			led-blue {
> -				pwms =3D <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
> -				active-low;
> +				pwms =3D <&pwm0 3 7812500 0>;
>  				color =3D <LED_COLOR_ID_BLUE>;
>  			};
>  		};
> --=20
> 2.42.0
>=20

--H7Zl3g4CczEwNK1s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTfa9gAKCRB4tDGHoIJi
0uwlAQCAZQx27sPA2UXRQiyGM6Fg+CQ3RWgDqFwXmisNYn/2GwEAqc5VaZVLOB01
ub63XDQoIn8tFuAT1jgi10RRbmKjBw0=
=TgU2
-----END PGP SIGNATURE-----

--H7Zl3g4CczEwNK1s--
