Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACC48022AD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjLCLTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCLT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:19:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8FFA2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:19:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A2DC433C8;
        Sun,  3 Dec 2023 11:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701602375;
        bh=khbZlB+CudlpWOtcypC7aIzJI1JQViaEerLoXBkjgWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jNmBJZNvjRJCnN+ObC8oLMUvyhaVt+0R8AseNwAN+iRBv99qvZeOI5D3CLwYyBTeh
         cyPIuheJ9y1AxJv2ArZyfzVggoM+ipgiEP/QW82jYbzQJQ0qnLEs7uEAEnqoEk8lRb
         V24AlYKPLAwcmAiQadAxTNx3wQvxfK3PDCz2uLyBiXA1krhcWSkc1+YBpUEIFs0Qcm
         XRKOmTVe+rePAA/R/yQd/W49W94uF2BRpaF6G8yYh/tagnNCPf711ENN8oJWVyUklk
         av0Y3/sDQjZyCRs1hn4AL9VNio5GtZ5R0bGo9R53BPMEI9NY0Ba+huHD+H7OIjRz7A
         MkuYtYlpPmi/A==
Date:   Sun, 3 Dec 2023 11:19:30 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Karel Balej <balejk@matfyz.cz>
Subject: Re: [PATCH v3 4/5] dt-bindings: input/touchscreen: imagis: add
 compatible for IST3032C
Message-ID: <20231203-mundane-riches-b6e4ef157384@spud>
References: <20231202125948.10345-1-karelb@gimli.ms.mff.cuni.cz>
 <20231202125948.10345-5-karelb@gimli.ms.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BTVe8SmajlARbciW"
Content-Disposition: inline
In-Reply-To: <20231202125948.10345-5-karelb@gimli.ms.mff.cuni.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BTVe8SmajlARbciW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2023 at 01:48:35PM +0100, Karel Balej wrote:
> From: Karel Balej <balejk@matfyz.cz>
>=20
> Document possible usage of the Imagis driver with the IST3032C
> touchscreen.

Please leave mention of the driver out of the binding patch (we deal
only with the hardware here) and instead describe what is incompatibly
different between these two devices.

Thanks,
Conor.

>=20
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
>  .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml   | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,i=
st3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,i=
st3038c.yaml
> index b5372c4eae56..2af71cbcc97d 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c=
=2Eyaml
> @@ -18,6 +18,7 @@ properties:
> =20
>    compatible:
>      enum:
> +      - imagis,ist3032c
>        - imagis,ist3038b
>        - imagis,ist3038c
> =20
> --=20
> 2.43.0
>=20

--BTVe8SmajlARbciW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWxkQQAKCRB4tDGHoIJi
0uU4AQDTvFOKjE2bh6MzjfwEJnPy0DVF+pBxGiHPa9Xd1r4gMwEAyprc91Hn2MfG
eWzTwFa8NMflUIYdHWmrAXPq84fGVA8=
=7rqZ
-----END PGP SIGNATURE-----

--BTVe8SmajlARbciW--
