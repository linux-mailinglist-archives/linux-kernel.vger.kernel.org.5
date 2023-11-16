Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75607EE2EF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjKPOfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjKPOfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:35:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09607130
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:35:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F44AC433C8;
        Thu, 16 Nov 2023 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700145339;
        bh=6Kn1U+qn6gfoSwPBsMGk4/t2qHphIqBsJSwlIIZY8gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PBOw/9G2SLAkF927tJeI+f3v8LKCQZYB2RYsHiYEjm7ffMmfgbnB8/hb+pA66tboP
         oWKkGhGuopbW5XyCOz6j0dum2GayeFQnH54N55kKo4nqZ/Hui1xl3XJedCeUizeLhV
         3Nq37FJ5z5En1vqK92bOusuuZq2WZVIg9UWWorQYg5JtLYklM+MEKxSYHJwldfdklw
         vwTmSPUi3VzT+2FNv4v/MEcmzMkALxzKfR5bn0vk2SSCkE6kIyGdHnelKEINifLsmd
         m2jp5ULHanBjOIWvS8EDbNLNW2AB77WIxDF2SDCruX9z8F0QYnuzIcaM+h5R00IKyA
         I1fIF0qc5AItA==
Date:   Thu, 16 Nov 2023 14:35:36 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Chester Lin <clin@suse.com>
Cc:     linus.walleij@linaro.org, Ghennadi.Procopciuc@oss.nxp.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Chester Lin <chester62515@gmail.com>,
        NXP S32 Linux Team <s32@nxp.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: s32g2: change a maintainer email
 address
Message-ID: <20231116-anything-statistic-0410278a2cbe@squawk>
References: <20231116001913.16121-1-clin@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XFHd10fz0iWRKVxR"
Content-Disposition: inline
In-Reply-To: <20231116001913.16121-1-clin@suse.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XFHd10fz0iWRKVxR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 08:19:13AM +0800, Chester Lin wrote:
> I am leaving SUSE so the current email address <clin@suse.com> will be
> disabled soon. <chester62515@gmail.com> will be my new address for handli=
ng
> emails, patches and pull requests from upstream and communities.

Consider also updating mailmap.

>=20
> Cc: Chester Lin <chester62515@gmail.com>
> Cc: NXP S32 Linux Team <s32@nxp.com>
> Cc: Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Signed-off-by: Chester Lin <clin@suse.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pi=
nctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinc=
trl.yaml
> index d49aafd8c5f4..a24286e4def6 100644
> --- a/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.y=
aml
> +++ b/Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.y=
aml
> @@ -9,7 +9,7 @@ title: NXP S32G2 pin controller
> =20
>  maintainers:
>    - Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
> -  - Chester Lin <clin@suse.com>
> +  - Chester Lin <chester62515@gmail.com>
> =20
>  description: |
>    S32G2 pinmux is implemented in SIUL2 (System Integration Unit Lite2),
> --=20
> 2.40.0
>=20

--XFHd10fz0iWRKVxR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVYotQAKCRB4tDGHoIJi
0jxiAP9qg9oojQRqaMa5oA5FjBPfXBrlQghFQaC637ksKm/TogEApk8zpPB35gXQ
0KHniR6mtOmrL84OcfZTJiqqxWywtQo=
=U5R6
-----END PGP SIGNATURE-----

--XFHd10fz0iWRKVxR--
