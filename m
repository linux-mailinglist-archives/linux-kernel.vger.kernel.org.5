Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A112755872
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 00:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjGPWFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 18:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjGPWFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 18:05:22 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14C81700;
        Sun, 16 Jul 2023 15:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689544926;
        bh=6GUYDnFcWYtf1lYkZ+G1cpme0+JT07O12EfP9J1OD0o=;
        h=Date:From:To:Cc:Subject:From;
        b=hD+Qzckd3YYHS+dZQW9vDZERXslpI9NbUvGbUvxRA8VRnnZqKWDIHYWgeJenKah+6
         +3RDSVdJnBCwMrzoSo8gNp1Y4JpzMgO4v6ja1LTMJPJ/FAtvKVZk7ZzwNDXBanB48P
         d2UQ/V24VWev0IJwb7A5WybrMTS+dIpu0LUpHbvHnWd9DRTuHrCq9OToRAflhC8ZcI
         /CLaaw5bM7eyF+IF9eM+rjAXnj2J/kJiQoMvHTlQ4Tf4RGQyjuWmLEkAExK1l+0beZ
         nAZMfH+rcx/toxAPclRQXwPzYjk+pjFoWTkYT7/yg0EafmHhKXZIJCDoux6uzwyvd0
         A61ku9zS7SuYg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R3zhY4D2xz4wZw;
        Mon, 17 Jul 2023 08:02:05 +1000 (AEST)
Date:   Mon, 17 Jul 2023 08:02:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the fpga tree
Message-ID: <20230717080204.793d9bf5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qxPL95BwBxSB/HkUGwVq8cJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qxPL95BwBxSB/HkUGwVq8cJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  7617b957c6dd ("fpga: Explicitly include correct DT includes")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/qxPL95BwBxSB/HkUGwVq8cJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS0aNwACgkQAVBC80lX
0GwqNAf/dizOu8oy03sGqKglaoPT24ft/Yz4slM0xnTSX/8qKmSlnyJtl5r2tI3Y
Qii03mKus5KoQ0F97xVlGAHbfD2+OEN7FVUP105+2/lsuJGRWFW9Vl56db/6MuT0
Jc5oSRL+0cZRdXCEUuM6hN70/+yo684W9xnKRD8nvB38TledVmwFAbdythiSz3Ta
pkEMc2FVGNjUtir0/9TpIUSEkP5r1xyN1dbXGCUHI/A1DdDrRaKwc7heVWeMoeGI
GxT9yGNYhyfWVaNYrNNO1x8EftcT4Ij1mwJgZM+F/UpNameC+16nbpzdQysCBiyW
8eIX49i0fWP9w3XuPACR7SnOnSTuRQ==
=fW3T
-----END PGP SIGNATURE-----

--Sig_/qxPL95BwBxSB/HkUGwVq8cJ--
