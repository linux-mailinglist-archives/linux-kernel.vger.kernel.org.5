Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757877DE414
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjKAPqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbjKAPqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:46:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58098D40;
        Wed,  1 Nov 2023 08:46:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92E9C433C9;
        Wed,  1 Nov 2023 15:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698853561;
        bh=zC6yCSHfmh/5iy8QMdqt6xIA4t9dtbOuSLusujn7SVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mWMB4AvihWsKGWwjurOuzwdRqzNULefFKmUiqmsaHTTL67JKrTUQ7psqTRz3s0YAw
         N5LxbqivEksNvydQh7iElu6/jHL85KAqv6oyXXRlnfdweREq9l2Pd0Lep/uvYJXh2Z
         i1pF2nxyVEKZZpovp2bRnwNm81PovjzNqHnw6waydYvqdNWGllgVe73h+j7uZqx2FT
         zBxVxB5PXfivEMGSQ4Z3+Q4keuSKBOg+JsytpYUPehktjdqW2NAoP2efNjerUVyVqS
         2SlzqkYJNvmdYZRFslAxEkhueliWOFpXZvvxFOgEyHWw8H6CmxJa2YTGcI7x+JAqA8
         X4XQT49Jiggrw==
Date:   Wed, 1 Nov 2023 15:45:56 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 3/5] dt-bindings: spi: add stm32f7-spi compatible
Message-ID: <20231101-pushup-kindle-c1021251807d@spud>
References: <20231101150811.2747455-1-ben.wolsieffer@hefring.com>
 <20231101150811.2747455-4-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o5NKLOVaCjgEnBEo"
Content-Disposition: inline
In-Reply-To: <20231101150811.2747455-4-ben.wolsieffer@hefring.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o5NKLOVaCjgEnBEo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 11:08:08AM -0400, Ben Wolsieffer wrote:

Missing commit body. The information from the driver patch about the
differences between this and other versions of the IP would be suitable.

Cheers,
Conor.

> Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
> ---
>  Documentation/devicetree/bindings/spi/st,stm32-spi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Do=
cumentation/devicetree/bindings/spi/st,stm32-spi.yaml
> index ae0f082bd377..5754d603f34f 100644
> --- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> @@ -23,6 +23,7 @@ properties:
>    compatible:
>      enum:
>        - st,stm32f4-spi
> +      - st,stm32f7-spi
>        - st,stm32h7-spi
> =20
>    reg:
> --=20
> 2.42.0
>=20

--o5NKLOVaCjgEnBEo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUJytAAKCRB4tDGHoIJi
0jOqAP9VAhg5Emh5oBVcWb1OF1NyxbQvPULlwVSEjp+kb6vcaAD8DQHua20iE9dd
t4Ri/6/mMJ3luNjvNDy0TwpSjulGAwk=
=nL8h
-----END PGP SIGNATURE-----

--o5NKLOVaCjgEnBEo--
