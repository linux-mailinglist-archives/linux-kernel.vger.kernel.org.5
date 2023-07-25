Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F5D76219F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjGYSkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjGYSks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:40:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC14213B;
        Tue, 25 Jul 2023 11:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2E8861874;
        Tue, 25 Jul 2023 18:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82935C433C8;
        Tue, 25 Jul 2023 18:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690310443;
        bh=5UFFIksYqJCSWSdZaL4h1CQhC+5qNOBA1gd1X6b/QMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nz4dEgHHfV1eYlVvm92X+9Pek/O0lNZbtFGUDiCF8HDLpmaaZw0Ay0947oHs0JVcw
         G7NIVC58qK5UNsecDiNzn4C9xjBlzPQGxiCuf/9x4wwVqW3NhH11Nu5RSG38ooW6Ns
         OZVVDrDhmgWN+IOvQ3kgaETNmHthvvi6aFmgJS0WcVu1dxudHYw61Upv/uhilHmWnR
         8WAaznHxqNsRQ/F1ztiX+e7mMwLrCTfwQH59bM8anubWKD1sdUNjJ985hoxt1R3hSP
         WNoyKsgGPOEIFSqro+EzidEn6ZnGKz2bxegJWA6ZZ8pkgDRiz5E/FhNGralJQtF+CX
         EVRwakq0O/1wQ==
Date:   Tue, 25 Jul 2023 19:40:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dt-bindings: drop unneeded status from examples
Message-ID: <20230725-purebred-smoked-1dd61c375768@spud>
References: <20230725101625.75162-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vCPhY7jXIfUoINHw"
Content-Disposition: inline
In-Reply-To: <20230725101625.75162-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vCPhY7jXIfUoINHw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 12:16:25PM +0200, Krzysztof Kozlowski wrote:
> Example DTS should not have 'status' property.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--vCPhY7jXIfUoINHw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMAXJgAKCRB4tDGHoIJi
0m5oAQCQr07WWAysBse0Tlk+T7UKrqGBZSNAgyjqozsuedaVCAEArxM/5oUF9iAt
jY9fRiIdvNfm/Z+MHRgkcE9Wn2UTSQs=
=nE7T
-----END PGP SIGNATURE-----

--vCPhY7jXIfUoINHw--
