Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4782076B3AC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjHALqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbjHALqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:46:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F2F170D;
        Tue,  1 Aug 2023 04:45:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 484DB61564;
        Tue,  1 Aug 2023 11:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFC4C433C8;
        Tue,  1 Aug 2023 11:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690890357;
        bh=bwYNSqKRC0R+674VMqvdQly3Gz4NVnq8bIwpgip/fMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WqmyPFmmeSmegi+a0SHRqS5oZwD76X7tmgjW+ljezELQ+8Wb26NIznCKG5haaLEAF
         keLzY9Dl8Y+2PRS4UlZ8ig2z8HcVeGXW/vRnTDqvxhcbdPkmGGF9yy4p9pzqPN7wS+
         FFXXOlRZtzQYDHcY+rsp0zBC3hN0unDTsBHEmpQee2vUeuUg7aVq68vZkK0bEws6RD
         Mz6rV7Sbxc9Jp9L/kGOLPldmyPAaPk4+2R6tiGhkyuhOxYSmC7FYox9b4nAEKP+5e/
         oDa0SURRY28NGjaPdq7IsswE5tgKPdMuv/aHJdiypo99SdjAWWGEC/EzBu1rz+eck0
         GdGIMGvXRAUuQ==
Date:   Tue, 1 Aug 2023 13:45:54 +0200
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
Subject: Re: [PATCH v1 v1 4/7] drm/fourcc: Add drm/vs tiled modifiers
Message-ID: <clxexkf4wjx5sxlxz3znbxehgxob2vw56v4pn63vuu6kfffyxo@bek3dvzsz5id>
References: <20230801101030.2040-1-keith.zhao@starfivetech.com>
 <20230801101030.2040-5-keith.zhao@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yslrfwhuh7l3ursl"
Content-Disposition: inline
In-Reply-To: <20230801101030.2040-5-keith.zhao@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yslrfwhuh7l3ursl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 06:10:27PM +0800, Keith Zhao wrote:
> These are mainly used internally in vs-drm,
> I'm not sure if the new modifiers can be used with the existing ones.
> If there is a problem, I will improve it further.
>=20
> Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
> ---
>  include/uapi/drm/drm_fourcc.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 8db7fd3f7..0b884cf50 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -419,6 +419,7 @@ extern "C" {
>  #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
>  #define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
>  #define DRM_FORMAT_MOD_VENDOR_AMLOGIC 0x0a
> +#define DRM_FORMAT_MOD_VENDOR_VS      0x0b

Please don't use any acronym there.

Maxime

--yslrfwhuh7l3ursl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZMjwcgAKCRDj7w1vZxhR
xXHaAP9IH1zIQb62ZyQMhxixSEF8riImLMdkmCdKEGrFpkEFWQD+PXDOQ/6x3wG1
4wF4AjgAQYTN8OUvFxlHHLqmlcYYDA8=
=rlbJ
-----END PGP SIGNATURE-----

--yslrfwhuh7l3ursl--
