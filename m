Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7447DE32F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjKAOyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjKAOyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:54:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1218DC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 07:54:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4F8C433C8;
        Wed,  1 Nov 2023 14:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698850478;
        bh=9gY3lKUIFxEXKcPbqPGYBJf4V5VDH8CACMCI1oLaASE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=amBqoWbgT9bePCEr3VIThqn1Aoe+Y4GQK2cQBs4GTba5C8988bWCU/jd5duG+gNaT
         hHxDFgS82VHitlKG89HBNq5WKuVzw3NbxNEqEsx0YjMGfqxW0fJO9fMpqpoVu3Zyj5
         SHnBDfQmehJ68nYTennTFHdcOuS3fOtN6wF1rcURPTGzz3ztEmNp0gYtYrt3Znikkf
         bAvZNNqRe24sfBbzykQtiNzE9WEeAx3BfBhkEzBXDm/CLY8hAoA1DUHs56KXr//YIs
         0LSS6C9IqMdeqLPMNvBAjpVsnPE+rMiEkw5yr0rAJqfMLT0KJtcoZIwPHYlEKtNt/w
         U6HHv7MwIf+tw==
Date:   Wed, 1 Nov 2023 14:54:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: add rve
Message-ID: <20231101-maimed-email-4decd11f1d52@spud>
References: <20231101144057.2653271-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ke7F+ZQ+zKizgPnB"
Content-Disposition: inline
In-Reply-To: <20231101144057.2653271-1-hugo@hugovil.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ke7F+ZQ+zKizgPnB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 10:40:57AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> Add vendor prefix for Recharge V=E9hicule =C9lectrique (RVE), which
> manufactures electric vehicle chargers infrastructure components.
>=20
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>


Where is the user for this?

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index e48b0a02827a..8455d7f5cfae 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1161,6 +1161,8 @@ patternProperties:
>      description: Shenzhen Roofull Technology Co, Ltd
>    "^roseapplepi,.*":
>      description: RoseapplePi.org
> +  "^rve,.*":
> +    description: Recharge V=E9hicule =C9lectrique (RVE) inc.
>    "^saef,.*":
>      description: Saef Technology Limited
>    "^samsung,.*":
>=20
> base-commit: 8bc9e6515183935fa0cccaf67455c439afe4982b
> --=20
> 2.39.2
>=20

--ke7F+ZQ+zKizgPnB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUJmqgAKCRB4tDGHoIJi
0kNAAQCUohq48EWzQa8q0n366LJ2AtnzLSSz+nrPHA92oWiXuAEA5FYC4Bm/FnIU
Lm2smNuuR4Gdph8JAN1oU9fG5rdy6gw=
=2x37
-----END PGP SIGNATURE-----

--ke7F+ZQ+zKizgPnB--
