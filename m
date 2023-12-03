Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637E48022AE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjLCLUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjLCLUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:20:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07064CB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:20:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7427C433C8;
        Sun,  3 Dec 2023 11:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701602443;
        bh=/NTGULGpy2g2ovireCjJM0D09EDli3mHSEMJDzchZ64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hsqL7lj5zCq6kpuOWvbc80hbFe2R9R4Eew4D7sxnfIoGDGpHUBk+SVFQMhPktTBq0
         Zfz4bujycpGVLHNkQQRYfY2COEFAiSRF+EP/FztuNZwZs5/F5/mCyyqQiY024MiwZg
         7iEjgR9d+cYiGKC8hbwUKXMEGJNFZ7jg865hM1VPdt4gPuMuRnHBpKOaIIcD8qv2D1
         ZGCEWjbe8Ef7l7+0qhnIZPq8PIXJud4H4LdLMKAZZbLDoWHdznXkB9Vlf6xQdZX7Vc
         aoTDiGLFEEBrEkLhVbbIZ4osX3p2Iq0NN4uugJ3JQ8OpshZ2DLWDG7heLNxzyFB/wW
         O4mKXKLUfFzRA==
Date:   Sun, 3 Dec 2023 11:20:37 +0000
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
Subject: Re: [PATCH v3 2/5] dt-bindings: input/touchscreen: Add compatible
 for IST3038B
Message-ID: <20231203-outskirts-reformat-e0a833903841@spud>
References: <20231202125948.10345-1-karelb@gimli.ms.mff.cuni.cz>
 <20231202125948.10345-3-karelb@gimli.ms.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6caWOJCI2vW+9aPg"
Content-Disposition: inline
In-Reply-To: <20231202125948.10345-3-karelb@gimli.ms.mff.cuni.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6caWOJCI2vW+9aPg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2023 at 01:48:33PM +0100, Karel Balej wrote:
> From: Markuss Broks <markuss.broks@gmail.com>
>=20
> Imagis IST3038B is a variant (firmware?) of Imagis IST3038 IC,
> add the compatible for it to the IST3038C bindings.

This one is better, but would be well served by mentioning what
specifically is different (register addresses or firmware commands?)

Cheers,
Conor.

>=20
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
>  .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml   | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,i=
st3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,i=
st3038c.yaml
> index 0d6b033fd5fb..b5372c4eae56 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c=
=2Eyaml
> @@ -18,6 +18,7 @@ properties:
> =20
>    compatible:
>      enum:
> +      - imagis,ist3038b
>        - imagis,ist3038c
> =20
>    reg:
> --=20
> 2.43.0
>=20

--6caWOJCI2vW+9aPg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWxkhQAKCRB4tDGHoIJi
0lSaAQCCXeTJp1KVWGirHD7j+2SSQbVzgYBH/OCml23PLQVLxgD/bg9V/Fb+ZhuK
eozhGuWxjThmtH5+WdaZmg3pMw6SXwg=
=RYnA
-----END PGP SIGNATURE-----

--6caWOJCI2vW+9aPg--
