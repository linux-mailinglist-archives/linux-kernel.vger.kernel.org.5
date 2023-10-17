Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBC27CB740
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjJQAB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjJQABZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:01:25 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A6792;
        Mon, 16 Oct 2023 17:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697500882;
        bh=Mqci4ybMlTPZeaqYRmIwYUtggsalwRpyV58KmvOxUlg=;
        h=Date:From:To:Cc:Subject:From;
        b=kqLXsot2rzaj4+0YJqOtHA+2PHhVzjvnDDwE3vK/jYLDMrrIHLn7evUDXy+N+en5l
         rgIDRt1uGG3zFbNAsYw/z2Vfr5dM2dFrHbC7TP86VIDsVMLwnmE9LYabceuRvVLssV
         egUpdNg3sHSzl6nWWj6TG8nE2t5HfOJ7U6aEPSmtlum9p2nARgMcv7v8hk2wYG8QNj
         h3QUgRMtLJWSPk03LsGKS12daBvkLvDGNQbV9hrOOk9bHz1MhWTp+0tJoAGblDQpgd
         rlsxqV6/FSb/yhVBjbR3XlAYZ0WppEXCWMSjVbGSo66yDQDKETEgUmBblnsnoo1D+O
         GUhX4SytCqBfQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S8Yzh3FxFz4xNh;
        Tue, 17 Oct 2023 11:01:20 +1100 (AEDT)
Date:   Tue, 17 Oct 2023 11:01:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUs=?= =?UTF-8?B?w7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the samsung-krzk tree
Message-ID: <20231017110118.3712e78e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+=WKpqMhUOl+=t1.jdySmmm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+=WKpqMhUOl+=t1.jdySmmm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the arm-soc tree as a different commit
(but the same patch):

  0da7c05d232d ("soc: samsung: exynos-chipid: Convert to platform remove ca=
llback returning void")

This is commit

  55fa358ca89f ("soc: samsung: exynos-chipid: Convert to platform remove ca=
llback returning void")

in the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/+=WKpqMhUOl+=t1.jdySmmm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUtzs4ACgkQAVBC80lX
0GzVtQf/QWDHejIJjwhfIastLcs+rkfW0q2Ld0ID4Scpx+lfDTeA3sDQiGC9nTsJ
9mAcmvwNdPHNhqe2R5TPioq58MM/OnLMZCfqpYq7gmt48ZdKLVftlId5vwOh91Ww
SjvHQYrtLvcn97LPubpErM4Z8w7z7YA1DVE1QugEAslBOAyeBp2rna++Ir1oEp0O
nRL7Sg/pN5z0+jR3Ns+WoAPz3+j7tjI3hsTE6d+M3aef0KB8aj/KJWS1s9tdZg7U
CCnfX7T2vzn4Zbr32K0EahEEPTdcQkYmxKACuXgAIDUy+G+Had4ijsQsjZ7vXVHO
Gn5Z4r/sRF1+NBAiL5cnXeGBGVIz4g==
=/0Hw
-----END PGP SIGNATURE-----

--Sig_/+=WKpqMhUOl+=t1.jdySmmm--
