Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4027E9DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjKMNtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKMNth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:49:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B7AD51
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:49:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46D5C433C8;
        Mon, 13 Nov 2023 13:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699883374;
        bh=l6fOgzs+gRaEoFTmKLmNpHazwRq9v6934z3SOTaUCyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MMa+rh+k1FLP/dpZGb/+ODoA8QjIaENmmfEToillG80CMfSVwM0qb2laozQ8CMe30
         u0MDyQuxJyY7/0eFkro3u0hHRXWFv7DHoOGiFbL+ew4yB/UAwpVidA86gGLsvrzsbM
         p8eA7qaYqFeIEVsOIierZfSWuU/BoIEwduma5ZiHn8gvHHovpXxzOYS46uLPcy/RuC
         MGoSyIMlVFDvkTzc/nyLshlGoFFvZlZrv1eJkCQ3lbtzyHPpNjqu49vsp/mNVLPz0i
         gVrrDTDVOnJZ9Ftyn/niLZsc8RbAeFjenKyUdZMLAtSNL+jlVsRVbTHbE9QOTuIKTj
         wGxKZ8sTU5yuQ==
Date:   Mon, 13 Nov 2023 13:49:31 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] dt-bindings: gpu: samsung-scaler: constrain iommus
 and power-domains
Message-ID: <20231113-retool-reckless-970ed7808b92@squawk>
References: <20231112184403.3449-1-krzysztof.kozlowski@linaro.org>
 <20231112184403.3449-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vTwnha2EFbEr3bLJ"
Content-Disposition: inline
In-Reply-To: <20231112184403.3449-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vTwnha2EFbEr3bLJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 07:44:03PM +0100, Krzysztof Kozlowski wrote:
> Provide specific constraints for iommus and power-domains, based on
> current DTS.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--vTwnha2EFbEr3bLJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVIpaAAKCRB4tDGHoIJi
0vdsAP9xzBEZfiwgQCchCiSAfgeayon8ZF+VGCkgyFOC7rrwCAEAnN4FItn+dkBg
Xr6OX2JuydUY/+gpRl7ykQ7fiXJRawo=
=da/7
-----END PGP SIGNATURE-----

--vTwnha2EFbEr3bLJ--
