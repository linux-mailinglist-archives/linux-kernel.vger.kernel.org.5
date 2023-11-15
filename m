Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6C37ED682
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343734AbjKOV7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbjKOV7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:59:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1C519D;
        Wed, 15 Nov 2023 13:59:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CFCC433C8;
        Wed, 15 Nov 2023 21:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700085578;
        bh=e7gQ4gWEv2q/y7H4JMRa3DaY6ldkh+8LPwN+tAmFvQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pJxc6FD94hnD45nsHcsyFzTNehlmAfHtPtfKHrcGxzCVFS+7ZOsWarllKIsfCuYST
         3VJ8qiIUD5AeMdnMsWCvaH2b3JI4row2+NwsamEScyjoW4EYaO/aZr6tXQNRqWD5G2
         NBBVxc0SNOFgQd8QeJx5XbgvtY1p9mI2b49IvpfSmUYwfz1sBkqgGUzZz1rMm1hgqj
         tCsseP5SNCpqfI7sGZtulxr240ReTaJiTWI60qSodlOPxaDGuJXsQAN8V684J+CIwd
         F7Vh+SZ2sGPoUYbhdlfKKpmwegqCe4kIoAJLY+EKSirZczd/MuL44V/WejMMeP1SJZ
         BarhvaA40WM7Q==
Date:   Wed, 15 Nov 2023 21:59:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Document RZ/Five SoC
Message-ID: <20231115-coach-traffic-0db115549fa4@squawk>
References: <20231115203254.30544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AW5hnqxGKYIjc4b7"
Content-Disposition: inline
In-Reply-To: <20231115203254.30544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AW5hnqxGKYIjc4b7
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--AW5hnqxGKYIjc4b7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVU/QgAKCRB4tDGHoIJi
0sPJAQDTRP45zgZCHxtCF7NmDhzc7n+VH4pJHNWPDy2ctVossgD/Yxv/FE3TMR93
/mVJgMKIDv1RwI1mA5E8HHChlRXO3Qk=
=nr00
-----END PGP SIGNATURE-----

--AW5hnqxGKYIjc4b7--
