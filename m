Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8031A80F2DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346541AbjLLQfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjLLQfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:35:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2F6E9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:35:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FC4C433CA;
        Tue, 12 Dec 2023 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702398911;
        bh=mMmJmC+q52Hml5ofl8CP4lRLUI3hn5sN9ppbWyRuzNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EGoV0FXbAwukl1l0MwB7ef/rsDx1WCzrP4ggfOmlRwwdxSkUnuZh6YzYwzUSbHYE/
         BqAR5kZoq7vFg+i7G3qIVF5ytIOTXKgj/TAVssnIRm7pdCp8C1h2lgbggJiJSPvrBJ
         K4qvuJFQQhJ+Z2+u1XNuaSvXgx0c6zgJusk+foLwo1KqNoJgd4e8jCUa1DfJDni3xm
         wlu+HGThEnNQ0wai/MuSA9lkd+l4gJ05UHRHNmpYB0l7wr0T6tkJzHx1R6EW9NDOLG
         IA38nd1lLu4lAJ+DjyG8M0apsLG19cPwN5KE09/hY2pJnSvbvUiXkdCnmhAXUIKY4U
         tQizSL2wR2KLA==
Date:   Tue, 12 Dec 2023 16:35:07 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: rng: starfive: Add jh8100 compatible
 string
Message-ID: <20231212-freely-familiar-f19c2e14c417@spud>
References: <20231212032527.1250617-1-jiajie.ho@starfivetech.com>
 <20231212032527.1250617-2-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wKaAqqtx0HcURug5"
Content-Disposition: inline
In-Reply-To: <20231212032527.1250617-2-jiajie.ho@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wKaAqqtx0HcURug5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 11:25:26AM +0800, Jia Jie Ho wrote:
> Add compatible string for StarFive JH8100 trng.
>=20
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../devicetree/bindings/rng/starfive,jh7110-trng.yaml       | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/rng/starfive,jh7110-trng.y=
aml b/Documentation/devicetree/bindings/rng/starfive,jh7110-trng.yaml
> index 2b76ce25acc4..4639247e9e51 100644
> --- a/Documentation/devicetree/bindings/rng/starfive,jh7110-trng.yaml
> +++ b/Documentation/devicetree/bindings/rng/starfive,jh7110-trng.yaml
> @@ -11,7 +11,11 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    const: starfive,jh7110-trng
> +    oneOf:
> +      - items:
> +          - const: starfive,jh8100-trng
> +          - const: starfive,jh7110-trng
> +      - const: starfive,jh7110-trng
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.34.1
>=20

--wKaAqqtx0HcURug5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXiLuwAKCRB4tDGHoIJi
0uEMAP49L1RqAzELTRn4hY+Ff+rzCrdw6w5GIjrpiqAIxF4yyAEA3Aq4Vbym8J2L
4Z/yc6Qm/2bLhA2ICyLVlC/hCPfDTQo=
=0CMW
-----END PGP SIGNATURE-----

--wKaAqqtx0HcURug5--
