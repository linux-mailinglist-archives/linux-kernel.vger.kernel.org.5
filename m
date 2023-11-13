Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24957E9DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjKMNsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjKMNsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:48:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14607D5C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:48:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14389C433C7;
        Mon, 13 Nov 2023 13:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699883294;
        bh=S+BII0lE1mTZkmkOFjntV8LOWnLbudBzFyYaS2jB4XU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XR3IgvnnOYiqaaGsI0hcnNhaEOQ/IWRlGbgqV4v7ZUOZIgyGAYV+llMhsQenXOo5p
         LcsXh1qXDQXgJsjqS0jMw0t13TaFzEG5xhlRz9aV+1FqiCy6IsW3LV6on4Xlf2gvL+
         lelK22BMDOMa/z/ix/HF9jvOCaKv6UpFcp6u4yAqHQbWQJ2Q3O4q5Gk+mcx7UmY4S2
         ZAppf8cS7R+aO6kgk4z2VBTQBsA3f8xFA+GBAusgbm6oXUpdOhuck8QPle9jJimTUR
         fTb59lSeGTyVzBPwk9wPgHGYfXUaDvSEuFJrCvPHtvWD+DuKjhwl0CakdS6Ifsl6aw
         LjVUZCvKV07yw==
Date:   Mon, 13 Nov 2023 13:48:11 +0000
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
Subject: Re: [PATCH 1/5] dt-bindings: gpu: samsung-rotator: drop redundant
 quotes
Message-ID: <20231113-overlying-blinker-55125b473d03@squawk>
References: <20231112184403.3449-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r+qbcDb3ot55ZKTs"
Content-Disposition: inline
In-Reply-To: <20231112184403.3449-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r+qbcDb3ot55ZKTs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 07:43:59PM +0100, Krzysztof Kozlowski wrote:
> Compatibles should not use quotes in the bindings.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers=E2=80=A6
Conor.

> ---
>  .../devicetree/bindings/gpu/samsung-rotator.yaml         | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml b=
/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
> index d60626ffb28e..18bf44e06e8f 100644
> --- a/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
> +++ b/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
> @@ -12,10 +12,11 @@ maintainers:
>  properties:
>    compatible:
>      enum:
> -      - "samsung,s5pv210-rotator"
> -      - "samsung,exynos4210-rotator"
> -      - "samsung,exynos4212-rotator"
> -      - "samsung,exynos5250-rotator"
> +      - samsung,s5pv210-rotator
> +      - samsung,exynos4210-rotator
> +      - samsung,exynos4212-rotator
> +      - samsung,exynos5250-rotator
> +
>    reg:
>      maxItems: 1
> =20
> --=20
> 2.34.1
>=20

--r+qbcDb3ot55ZKTs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVIpGAAKCRB4tDGHoIJi
0pYSAPwObE5o/3/P32x9ua+T+1BFXrWkjWksiMViZJ+U1sEOHwEAnQHFAy7VIMEV
1wmGpuEzv/hkm8lvFkeliASQI7ttYgg=
=dAYP
-----END PGP SIGNATURE-----

--r+qbcDb3ot55ZKTs--
