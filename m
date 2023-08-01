Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262AF76B467
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjHAMG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjHAMGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:06:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC496198C;
        Tue,  1 Aug 2023 05:06:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 698D06156E;
        Tue,  1 Aug 2023 12:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D416C433C7;
        Tue,  1 Aug 2023 12:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690891569;
        bh=s6YECtfwRWz+nn+e8dtTgfPFMuDS2G9MlvdIBiOeJvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KqMPTZxlteTlX/vW0spt/IyKiVoPJYdtMr2lPEmfbuQmmwhfCC21GhGz+yQWZ8GEd
         RJW1lK9JN1DnTZJmTBwsvxtaZhWyU6xXWtVcaFKkx5L8z9m/yft5TuURPQh/J+IL7U
         PHvcq8WNXFxjoQvwm9S5/fvJ1NcSpL5MoMmgslMiMQ5qDQ3DsuwUBL05Ll8j2x2V0T
         Fmi+ZB4B+y3YDp+rI657BSpL6UbzABRJfYD+Czas7wkqLfwlQX9ueJGii9FSPJqKBt
         8HPA9376cD/cny4bwakf8t2KopaxquTpFCkgWx5XoRWckS8rxRoyjnuCN7kB9nASW2
         lheIZ7XLLLVog==
Date:   Tue, 1 Aug 2023 14:06:06 +0200
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
Subject: Re: [PATCH v1 v1 6/7] drm/vs: Add KMS crtc&plane
Message-ID: <7sfzkc6b46izrfnhcoajllugfofh7otseocbiiftjx344hxiuf@jkjb5syqwo24>
References: <20230801101030.2040-1-keith.zhao@starfivetech.com>
 <20230801101030.2040-7-keith.zhao@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="duuftomxabqjg5ol"
Content-Disposition: inline
In-Reply-To: <20230801101030.2040-7-keith.zhao@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--duuftomxabqjg5ol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Aug 01, 2023 at 06:10:29PM +0800, Keith Zhao wrote:
> +static int vs_crtc_atomic_set_property(struct drm_crtc *crtc,
> +				       struct drm_crtc_state *state,
> +				       struct drm_property *property,
> +				       uint64_t val)
> +{
> +	struct vs_crtc *vs_crtc = to_vs_crtc(crtc);
> +	struct vs_crtc_state *vs_crtc_state = to_vs_crtc_state(state);
> +
> +	if (property == vs_crtc->sync_mode)
> +		vs_crtc_state->sync_mode = val;
> +	else if (property == vs_crtc->mmu_prefetch)
> +		vs_crtc_state->mmu_prefetch = val;
> +	else if (property == vs_crtc->bg_color)
> +		vs_crtc_state->bg_color = val;
> +	else if (property == vs_crtc->panel_sync)
> +		vs_crtc_state->sync_enable = val;
> +	else if (property == vs_crtc->dither)
> +		vs_crtc_state->dither_enable = val;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int vs_crtc_atomic_get_property(struct drm_crtc *crtc,
> +				       const struct drm_crtc_state *state,
> +				       struct drm_property *property,
> +				       uint64_t *val)
> +{
> +	struct vs_crtc *vs_crtc = to_vs_crtc(crtc);
> +	const struct vs_crtc_state *vs_crtc_state =
> +		container_of(state, const struct vs_crtc_state, base);
> +
> +	if (property == vs_crtc->sync_mode)
> +		*val = vs_crtc_state->sync_mode;
> +	else if (property == vs_crtc->mmu_prefetch)
> +		*val = vs_crtc_state->mmu_prefetch;
> +	else if (property == vs_crtc->bg_color)
> +		*val = vs_crtc_state->bg_color;
> +	else if (property == vs_crtc->panel_sync)
> +		*val = vs_crtc_state->sync_enable;
> +	else if (property == vs_crtc->dither)
> +		*val = vs_crtc_state->dither_enable;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}

Any new property needs to follow these requirements:
https://docs.kernel.org/gpu/drm-kms.html#requirements
https://docs.kernel.org/gpu/drm-uapi.html#open-source-userspace-requirements

Also, most of them are suspicious, like sync_mode, mmu_prefetch,
panel_sync or dither_enable. Why would you want userspace to change
those ?


> +static int vs_crtc_late_register(struct drm_crtc *crtc)
> +{
> +	return 0;
> +}

You can drop that.

> +static int vs_crtc_enable_vblank(struct drm_crtc *crtc)
> +{
> +	struct vs_crtc *vs_crtc = to_vs_crtc(crtc);
> +
> +	vs_dc_enable_vblank(vs_crtc->dev, true);
> +
> +	return 0;
> +}
> +
> +static void vs_crtc_disable_vblank(struct drm_crtc *crtc)
> +{
> +	struct vs_crtc *vs_crtc = to_vs_crtc(crtc);
> +
> +	vs_dc_enable_vblank(vs_crtc->dev, false);
> +}
> +
> +static const struct drm_crtc_funcs vs_crtc_funcs = {
> +	.set_config		= drm_atomic_helper_set_config,
> +	.page_flip		= drm_atomic_helper_page_flip,
> +	.reset			= vs_crtc_reset,
> +	.atomic_duplicate_state = vs_crtc_atomic_duplicate_state,
> +	.atomic_destroy_state	= vs_crtc_atomic_destroy_state,
> +	.atomic_set_property	= vs_crtc_atomic_set_property,
> +	.atomic_get_property	= vs_crtc_atomic_get_property,
> +	.late_register		= vs_crtc_late_register,
> +	.enable_vblank		= vs_crtc_enable_vblank,
> +	.disable_vblank		= vs_crtc_disable_vblank,
> +};
> +
> +static u8 cal_pixel_bits(u32 bus_format)
> +{
> +	u8 bpp;
> +
> +	switch (bus_format) {
> +	case MEDIA_BUS_FMT_RGB565_1X16:
> +	case MEDIA_BUS_FMT_UYVY8_1X16:
> +		bpp = 16;
> +		break;
> +	case MEDIA_BUS_FMT_RGB666_1X18:
> +	case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
> +		bpp = 18;
> +		break;
> +	case MEDIA_BUS_FMT_UYVY10_1X20:
> +		bpp = 20;
> +		break;
> +	case MEDIA_BUS_FMT_BGR888_1X24:
> +	case MEDIA_BUS_FMT_UYYVYY8_0_5X24:
> +	case MEDIA_BUS_FMT_YUV8_1X24:
> +		bpp = 24;
> +		break;
> +	case MEDIA_BUS_FMT_RGB101010_1X30:
> +	case MEDIA_BUS_FMT_UYYVYY10_0_5X30:
> +	case MEDIA_BUS_FMT_YUV10_1X30:
> +		bpp = 30;
> +		break;
> +	default:
> +		bpp = 24;
> +		break;
> +	}
> +
> +	return bpp;
> +}
> +
> +static bool vs_crtc_mode_fixup(struct drm_crtc *crtc,
> +			       const struct drm_display_mode *mode,
> +			       struct drm_display_mode *adjusted_mode)
> +{
> +	struct vs_crtc *vs_crtc = to_vs_crtc(crtc);
> +
> +	return vs_dc_mode_fixup(vs_crtc->dev, mode, adjusted_mode);
> +}

You should be using atomic_check.

Maxime

--duuftomxabqjg5ol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZMj1LgAKCRDj7w1vZxhR
xcuiAQDVAHuCXQLiF4aho3J76b/1omEGtDLrJYqMFou4trNeDQEA9a+4doYz0r8T
e4MChnbgb7U5q3ndReWR8iY6I4VZ/wc=
=sNPG
-----END PGP SIGNATURE-----

--duuftomxabqjg5ol--
