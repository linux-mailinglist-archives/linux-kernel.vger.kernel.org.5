Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358B476B3A4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjHALpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjHALpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:45:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B2411A;
        Tue,  1 Aug 2023 04:45:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3EA361562;
        Tue,  1 Aug 2023 11:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC05AC433C8;
        Tue,  1 Aug 2023 11:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690890332;
        bh=7tDiTd4TDuNKvPRSv3/p+m31RyZXbyg7abTCZkKLnF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SxV77xpJBISvKsn/J3Rd0xWFdhym10nJYIZsOUjlscvbz/fhlS9zj1uzWuvlefFau
         Rts0JJPLs1/vreoerPbofHR+M5eyKjowFHDTVaBHYVEljiLbd5pfAPYxhzNO/IhgyE
         XoRrPgH/ltc0U6+Qn+f7P0Jg8R/FHU+2AkgsWyQsFd86IZpVIDs3Ga8u/K0MrShK+W
         PmsVlqBQ0mGnq02wT/oSOngWRw31gCAHKnwalM0LRM9RyylzRzJAiOr18Jzqr+/4CM
         +rWkUGZF6DlFP0+gFM4SBIrvcp1GgrNdCFDDPsfTATYGjgR/wyqGEhuW50TcFsE5Po
         R06wPzbRkOP5w==
Date:   Tue, 1 Aug 2023 13:45:29 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Keith Zhao <keith.zhao@starfivetech.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        christian.koenig@amd.com, Bjorn Andersson <andersson@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: Re: [PATCH v1 v1 3/7] riscv: dts: starfive: jh7110: add dc
 controller and hdmi  node
Message-ID: <fin3n5qq2jcejmksjrhi2s4xzfy3jvi264htwzvabzdrdc47wg@6binn7jn2pdv>
References: <20230801101030.2040-1-keith.zhao@starfivetech.com>
 <20230801101030.2040-4-keith.zhao@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="skfe2pxrx4sbzczu"
Content-Disposition: inline
In-Reply-To: <20230801101030.2040-4-keith.zhao@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--skfe2pxrx4sbzczu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 06:10:26PM +0800, Keith Zhao wrote:
> Add the dc controller and hdmi node for the Starfive JH7110 SoC.
>=20
> Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         | 87 +++++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 43 +++++++++
>  2 files changed, 130 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dt=
si b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index de0f40a8b..32e5cc96c 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -31,6 +31,21 @@ memory@40000000 {
>  		reg =3D <0x0 0x40000000 0x1 0x0>;
>  	};
> =20
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		linux,cma {
> +			compatible =3D "shared-dma-pool";
> +			reusable;
> +			size =3D <0x0 0x20000000>;
> +			alignment =3D <0x0 0x1000>;
> +			alloc-ranges =3D <0x0 0x80000000 0x0 0x20000000>;
> +			linux,cma-default;
> +		};
> +	};
> +

You should explain why you need this, either in a comment or in the
commit log.
>

--skfe2pxrx4sbzczu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZMjwWQAKCRDj7w1vZxhR
xfLPAQCg7oQJf+fuhklc8W+YG708G6AdwC21jBHjwoV/gdctOQEA1NuI8i4v+QQh
6uqlf1/mgX7XSembyehbCmGpksTxhQw=
=dBWR
-----END PGP SIGNATURE-----

--skfe2pxrx4sbzczu--
