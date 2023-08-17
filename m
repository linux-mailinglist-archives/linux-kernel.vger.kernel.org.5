Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6852377F48C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350040AbjHQKy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243780AbjHQKyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:54:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C86D2D4A;
        Thu, 17 Aug 2023 03:54:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB252639AD;
        Thu, 17 Aug 2023 10:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C380C433C8;
        Thu, 17 Aug 2023 10:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692269648;
        bh=B2TtcfD8DgHSarpK0UHDsmnpRH+gYIewBTOs8qq34CE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QZOO2ewr5cLOEnMu+iTWKj2tNFf2Yks7dJLb3FthvDEAXQCCMMnlERijrriLnogmS
         UhqAh+XRX5ElJjW5rzyEeJob9rk8ZMXy8Rmc/muAO0Q6LvXnL0GGyuSu/hdvncRZgr
         n+S/PE6Et8BB1CByrZMWCPAsTs0XqM4GIVeYJhwOzBEmpsbnY/QHphKGx4SDfGTtjj
         K6YQoO9smH/ZcHWQy+Z3oHmYsh2nGOkEYaAJjzppBC9hRFAgeJJ+/xD9/88xX5E1t9
         zWImGSxzYmcp6Tl1EUY3hbM/ez060M2vBszxAfsF/76TepaeA33dj9PabuEt0AegIz
         0opTCvqKBvn8g==
Date:   Thu, 17 Aug 2023 12:54:05 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     nm@ti.com, vigneshr@ti.com, afd@ti.com, rogerq@kernel.org,
        s-vadapalli@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        a-bhatia1@ti.com, r-ravikumar@ti.com, sabiya.d@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 3/5] arm64: dts: ti: k3-j784s4-main: Add DSS and
 DP-bridge node
Message-ID: <aqfx7fj446gkyirhsiwijiuilhoao4hexmpjfxu4gojpujhbib@2wqzjuh3yz46>
References: <20230803080441.367341-1-j-choudhary@ti.com>
 <20230803080441.367341-4-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lqw2sj7oetk76z5f"
Content-Disposition: inline
In-Reply-To: <20230803080441.367341-4-j-choudhary@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lqw2sj7oetk76z5f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 03, 2023 at 01:34:39PM +0530, Jayesh Choudhary wrote:
> From: Rahul T R <r-ravikumar@ti.com>
>=20
> Add DSS and DP-bridge node for J784S4 SoC. DSS IP in J784S4 is
> same as DSS IP in J721E, so same compatible is being used.
> The DP is Cadence MHDP8546.
>=20
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> [j-choudhary@ti.com: move dss & mhdp node together in main, fix dss node]
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot=
/dts/ti/k3-j784s4-main.dtsi
> index 446d7efa715f..824312b9ef9f 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -1741,4 +1741,67 @@ c71_3: dsp@67800000 {
>  		resets =3D <&k3_reset 40 1>;
>  		firmware-name =3D "j784s4-c71_3-fw";
>  	};
> +
> +	mhdp: bridge@a000000 {
> +		compatible =3D "ti,j721e-mhdp8546";
> +		reg =3D <0x0 0xa000000 0x0 0x30a00>,
> +		      <0x0 0x4f40000 0x0 0x20>;
> +		reg-names =3D "mhdptx", "j721e-intg";
> +		clocks =3D <&k3_clks 217 11>;
> +		interrupt-parent =3D <&gic500>;
> +		interrupts =3D <GIC_SPI 614 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains =3D <&k3_pds 217 TI_SCI_PD_EXCLUSIVE>;
> +		status =3D "disabled";
> +
> +		dp0_ports: ports {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +	};
> +
> +	dss: dss@4a00000 {
> +		compatible =3D "ti,j721e-dss";

As far as I can see, this compatible limits the (DPI) pixel clock to
160MHz, but the TRM seems to mention that it's 600MHz?

Is it expected?

Maxime

--lqw2sj7oetk76z5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZN38TQAKCRDj7w1vZxhR
xdlfAP9njqMypScML1Ykj875V84t1+5ow6mZmYOpRyeoDeT1xQEA04z8y2wc3kZJ
un7PaGDaHunD03IIUHZFHcK2vImQvAc=
=D1tr
-----END PGP SIGNATURE-----

--lqw2sj7oetk76z5f--
