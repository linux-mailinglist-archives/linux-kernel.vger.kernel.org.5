Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC7F76B631
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjHANsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjHANsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:48:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB005ED;
        Tue,  1 Aug 2023 06:48:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61BF7615B0;
        Tue,  1 Aug 2023 13:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CBCC433C7;
        Tue,  1 Aug 2023 13:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690897709;
        bh=yBCVhMlvIlShUF7vexVldIJJJDKdGoCO+kY/QWgk+y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LEOsTFaPuSkOXKXis4cSvPwJH4oJS/olSV3RAfl00cz/5RO/7LBToy5zGVrRhlAoJ
         cPuFKLfu5NIYRCpeX30pbTJOBHfhmdYGqgdxFWqVJ69/eLbsHmH2UVAZrUAebgxi7M
         CKCfWsxFSIhn1QOpieuRHDJiXfN49DhTCP8JMq8oEFIw0TJk/y6pmCwRhPfmnI9tKM
         QieJVJ290CaLDW/b1nVjqLG+NMheNvZSmhtq18m01j+/6uwuDEyO/M2HF3kHU+iJe2
         RXOkSQCDn1E44ny2XzbvN/XsadqL+c9c8KqdtjpqteAhxkd7FlfyBoZVk8sLJpVmfr
         vhmpuZH4v4JIw==
Date:   Tue, 1 Aug 2023 14:48:21 +0100
From:   Conor Dooley <conor@kernel.org>
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
        Maxime Ripard <mripard@kernel.org>,
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
Subject: Re: [PATCH v1 v1 1/7] MAINTAINERS: Update starfive maintainers
Message-ID: <20230801-reviver-clip-5d1a8d22edab@spud>
References: <20230801101030.2040-1-keith.zhao@starfivetech.com>
 <20230801101030.2040-2-keith.zhao@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IVqccmOPnJ1WnFlO"
Content-Disposition: inline
In-Reply-To: <20230801101030.2040-2-keith.zhao@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IVqccmOPnJ1WnFlO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 06:10:24PM +0800, Keith Zhao wrote:
> update starfive maintainers
>=20
> Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>

Why is this a standalone patch, before you've even added any of the
files in question?

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3be1bdfe8..daadd1707 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6760,6 +6760,13 @@ S:	Supported
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	drivers/gpu/drm/udl/
> =20
> +DRM DRIVERS FOR STARFIVE
> +M:	Keith Zhao <keith.zhao@starfivetech.com>
> +L:	dri-devel@lists.freedesktop.org
> +S:	Maintained
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +F:	Documentation/devicetree/bindings/display/starfive/
> +
>  DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
>  M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
>  M:	Melissa Wen <melissa.srw@gmail.com>
> --=20
> 2.34.1
>=20

--IVqccmOPnJ1WnFlO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMkNJQAKCRB4tDGHoIJi
0lC7AP0fuE7TbAcoI8Ol6wcV1gi8Wbfl+gmu5cTOS7xJbEy+PgD+IEg0kjZSlNlt
PYRMDt5Lz1ZoFzNdZ8Dew5xtfjk8oAY=
=0VQt
-----END PGP SIGNATURE-----

--IVqccmOPnJ1WnFlO--
