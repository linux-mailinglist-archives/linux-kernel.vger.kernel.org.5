Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CE9752AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjGMTbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjGMTbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:31:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480911989;
        Thu, 13 Jul 2023 12:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB604618B3;
        Thu, 13 Jul 2023 19:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3270C433C8;
        Thu, 13 Jul 2023 19:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689276699;
        bh=Xr1JrHIprji0ukEKi29zvb5WpkvZKQdH5WChRsNQ15s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AlDX6HGaX0LJ38M7+fvYcHgyuhOjkDgV7Fm53HOj6CCsEz/pfPZU49T7t+Pl+0VYV
         wT7jnh5LiR3wgars1BCAvgY2D6Zc0zMgVzgPh40YQHS7Rt0BXAQK3y3w2GJlJkzTST
         uYWReLTOrggsv7D1jOM7+YkZjMR36f+fiBQBUr6AjMS4ddsFQr/xKRj6v+5/BOKy1m
         5xiLWxyhiB+V5PL7fACWwQfK0hECTf41k0gZWaz14ESyhopQrJfKD8aHFS9mRxFhyr
         YTbscvzjXRBqINYVbVx/RSma2Lw9D/9VT60o9e4wOw4H6juOxQtCJHjBuh4+xjRQA/
         UVnMn4u3RCVxA==
Date:   Thu, 13 Jul 2023 20:31:34 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: memory-controllers: ingenic,nemc:
 reference peripheral properties
Message-ID: <20230713-negate-dividend-f38ab42129e1@spud>
References: <20230713152848.82752-1-krzysztof.kozlowski@linaro.org>
 <20230713152848.82752-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bsRu64CPx95BLEjP"
Content-Disposition: inline
In-Reply-To: <20230713152848.82752-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bsRu64CPx95BLEjP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 05:28:46PM +0200, Krzysztof Kozlowski wrote:
> Ingenic NAND / External Memory Controller has children with peripheral
> properties, so it should reference the Memory Controller bus
> Peripheral-specific schema.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--bsRu64CPx95BLEjP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLBRFgAKCRB4tDGHoIJi
0khIAP9IgbmAHM/UT/eETAEQJY62dEbyeeW+zvV7HakoZPQ7EgD8CKDAm0doPxfe
fTWQaP45EPkxkA5pzSrbovLyeNx02AM=
=wnVp
-----END PGP SIGNATURE-----

--bsRu64CPx95BLEjP--
