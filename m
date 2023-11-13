Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9A17E9DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjKMNuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKMNuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:50:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9CAD4E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:50:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8833BC433C8;
        Mon, 13 Nov 2023 13:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699883401;
        bh=qhyALmG42/AQmB5Z41yLwINy+Y9Ggr/s8g4n3K7PPig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJ3miYrbR1FHCDQqp99GzBvvh8EqNkjgMmet6VngYo9QVGM0f55xKDs8zRqNz4Aw8
         sGaKujEzuBfjS6FLEJU0zFAT7jyMhk4I+NwdyNYrPos7xhSt2NJYuzkLgbyUrC08fX
         P+M7j4XFhhmHlJe0LB2ysC9SbrI8WvB5E+iT+5+jnyXWGXOoCaoTFY2s4azkTIYAkt
         cCpB/I4rWaLkgvpd4v9I2I7wefuINYiGeZgj6JHjvEsg+MS2MoyV2siveM9twApx0t
         6uMMRz0Js+q35SQrzZgMOvM/wf4yLabEzde+U4YXazR7cOJEWFBVMi+6sOkgE+ejd/
         GO+YxeZulhFxg==
Date:   Mon, 13 Nov 2023 13:49:58 +0000
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
Subject: Re: [PATCH 4/5] dt-bindings: gpu: samsung-g2d: constrain iommus and
 power-domains
Message-ID: <20231113-showbiz-onyx-abaf76317c31@squawk>
References: <20231112184403.3449-1-krzysztof.kozlowski@linaro.org>
 <20231112184403.3449-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wuAMwvZz2Mwnz2Kh"
Content-Disposition: inline
In-Reply-To: <20231112184403.3449-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wuAMwvZz2Mwnz2Kh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 07:44:02PM +0100, Krzysztof Kozlowski wrote:
> Provide specific constraints for iommus and power-domains, based on
> current DTS.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--wuAMwvZz2Mwnz2Kh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVIpgwAKCRB4tDGHoIJi
0utDAQCjLlryiqd4C5tAN7mBPG1Vtfy9ryR5V2NwUzIP1hUgsQEA0YnDszj+kC63
aQVdBf7uSCJ/2QVNbdJYlyJnfCBIxgM=
=3qea
-----END PGP SIGNATURE-----

--wuAMwvZz2Mwnz2Kh--
