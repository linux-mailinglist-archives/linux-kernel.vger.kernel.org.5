Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BEB7EE2F5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343878AbjKPOgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjKPOga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:36:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA4D181;
        Thu, 16 Nov 2023 06:36:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10041C433C7;
        Thu, 16 Nov 2023 14:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700145387;
        bh=OyITewxPkxNCTFIYqji7Ivpq0vZare/32nbCo4GuYNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mim3lN82s00lA25X5lCbXXbeKf3sO2lQqSOE3n9TiKH1LmNKp/3BzxVZ4N/78rzZU
         RkebEPoiPwWZBQ353Enf7j6CQaKTqaH9+gcdLgXBQXdsYikNiy7qXfQys4LjdIW45f
         4bS34QP0FcG8tCGqKa5Kv3cPQse3rwLmvVvRD1dc9tVIE6mO3lCLYVX8U7yVfO+WBA
         5j+MYh9OAxx3ClUsk21UvoyIXIjD5GY5SuSZJpv1PkQBqnew31I83Y0xf5CnVihb6y
         P9tifTb+fRqGhKktucKsQ6/F9Jy3iHAPxLzZrBwbJHIYQ767SAHA9iwP/n7+5NSWWD
         ZEAoa9xet75rw==
Date:   Thu, 16 Nov 2023 14:36:24 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Chester Lin <clin@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, Chester Lin <chester62515@gmail.com>,
        NXP S32 Linux Team <s32@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: serial: fsl-linflexuart: change the
 maintainer email address
Message-ID: <20231116-flight-motivate-625a5ab39dad@squawk>
References: <20231115235732.13633-1-clin@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lTcXpuFKDHaLOpGv"
Content-Disposition: inline
In-Reply-To: <20231115235732.13633-1-clin@suse.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lTcXpuFKDHaLOpGv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 07:57:32AM +0800, Chester Lin wrote:
> I am leaving SUSE so the current email address <clin@suse.com> will be
> disabled soon. <chester62515@gmail.com> will be my new address for handli=
ng
> emails, patches and pull requests from upstream and communities.
>=20
> Cc: Chester Lin <chester62515@gmail.com>
> Cc: NXP S32 Linux Team <s32@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Signed-off-by: Chester Lin <clin@suse.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../devicetree/bindings/serial/fsl,s32-linflexuart.yaml         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart=
=2Eyaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> index 920539926d7e..7a105551fa6a 100644
> --- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> +++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> @@ -13,7 +13,7 @@ description: |
>    https://www.nxp.com/webapp/Download?colCode=3DS32V234RM.
> =20
>  maintainers:
> -  - Chester Lin <clin@suse.com>
> +  - Chester Lin <chester62515@gmail.com>
> =20
>  allOf:
>    - $ref: serial.yaml#
> --=20
> 2.40.0
>=20

--lTcXpuFKDHaLOpGv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVYo5QAKCRB4tDGHoIJi
0ukMAP9ct19q7TkUXkNezcsUl6fNCe1XRrZBAvDlHYVfDXv9AAD9EarhPAo3ZxTe
8ymj18fN79puxR+C1Zj+APiRZiJFMg0=
=tDSh
-----END PGP SIGNATURE-----

--lTcXpuFKDHaLOpGv--
