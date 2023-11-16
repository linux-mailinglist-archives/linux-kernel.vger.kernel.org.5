Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE987EE211
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345289AbjKPOBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345280AbjKPOBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:01:12 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C662B12F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=VjTK
        hEJKFxBOzIOPUeGVw1mOj5EUaqPgAJjVG/989Z8=; b=lnN9EgIQxAYtsn1nfDPH
        txlpAQyOe7ElBMIWn/NLfVPy+GtGnpobwBRw2xTKRM7hLAmVyossxbLY4cun2n/p
        OxLMZQp2r7gRa4i/am6ZFgrIWOwDecDsglC+bJ3Fg97XstNXilY4vSVJ1V9tKJhs
        6cG0I/vChvK9/t8UxsH9OIXX4Stxsui5ofaq0yeGponGRBemPhxUsngZBnZAHl7e
        x5nq/LcJLgxM3fp2HUwAHgJFHNDmmkO6bSVHV5yvmtxxk9mMtHhFMISxwJZQnJR+
        V8Bl8l3DizfP+ra9DCn3N8k8/XHbgEw0QoLFgyFinU4bkrRh51CGFB3CFelv1qZZ
        QQ==
Received: (qmail 539594 invoked from network); 16 Nov 2023 15:01:00 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Nov 2023 15:01:00 +0100
X-UD-Smtp-Session: l3s3148p1@n8kMc0UK7NcMur4C
Date:   Thu, 16 Nov 2023 09:00:58 -0500
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Document RZ/Five SoC
Message-ID: <ZVYgmtxZP7/jGWAt@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231115203254.30544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="96E3kriXuufB2vQk"
Content-Disposition: inline
In-Reply-To: <20231115203254.30544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--96E3kriXuufB2vQk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 08:32:54PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The SDHI block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,sdhi-r9a07g043" compatible string will be used on the
> RZ/Five SoC so to make this clear and to keep this file consistent, update
> the comment to include RZ/Five SoC.
>=20
> No driver changes are required as generic compatible string
> "renesas,rcar-gen3-sdhi" will be used as a fallback on RZ/Five SoC.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--96E3kriXuufB2vQk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmVWIJUACgkQFA3kzBSg
KbYKkw/+M0CdqOrnWjDnKX35jk3CPokP12hBzNNr/dLgwqHhAW2ztEH6Z58+oEWQ
OesI9IPl5HU+2Y+lEUNAzGuTwDolMa0zCNa0T8yoSO1gTuxizKZWmBo5F6HQdu6g
qY7jg+z8hJ57bamkXazo8U0jHu6UIGD/jvgYESBI3pKiYkDhwqTf93ZtNuJbh1Y0
Tz67UpwElEfbEneiVz6JFYMTiQAquu9DAW0Ye27P4TbnjYXYKH38hHvPEtI5VhYE
2RGSUooksiXlzR46/3/4OhqvCvzbrDflRaipixrA/YprrD9dAs+6xJWis2OHu1mS
QeS11uuDpp+EhLZHzhYWn7aJcjw0KJdoO4iNpJUKndJBHH6WyFswAkl0/XU1G5s5
43i6fKsOsg9sqDNjEzkbCKHzf/UgA//mGgSzp8WgoJ2mznm/fRy6ngEr/+bJ5xZ3
7Gf1SCTYR9qnisxyn//v7TA7BzPFHtz7A7/Cwio7qUGKe6aC6O9a2pMs8onoHPCZ
TjDM0HQ+HSVsCzNcPYg3nl2ApUnlivKixS23u+hGhJ/2afG2O8rT6ciAzd80crTb
ezbSmSszLItj4zMfwLA4r5NqtpINk7IQnWjr2DiIIli889U/clpX+08nLryOYfsh
XDwnL+hdhLyWD3jOG1DB73xGYOUUgb/hk3KLv6kBdoARshYESaY=
=0kzE
-----END PGP SIGNATURE-----

--96E3kriXuufB2vQk--
