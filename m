Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155167558BF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 02:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjGQALV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 20:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGQALU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 20:11:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6D11B7;
        Sun, 16 Jul 2023 17:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689552676;
        bh=0eh9mLcCnmhtstnt2+LP/cV1bnzSrbIRKigvAhr4cmI=;
        h=Date:From:To:Cc:Subject:From;
        b=WASBRIRvNEi1w+DLTMnajJUDKad7XZh3uHXMKQi1o63ANkuScIvlQql+hph8KtV4+
         RpBRmHDpXatXgRWEP9UR7daoRKoQUXGrBps2e+xiznyWY03SIRH/w40YpY33GcObT9
         FFvSpkGP3XO04zQt+AdlX+OhjlLeb29sxbBzeYys6Erx4lVbuCfkwxqkWSF5aHp+SA
         MWHCyrF8/TWRls4MKYBjc3iJYnWXjYAAtFcLyafUDUE48k77F2uimA9iUJB1dTP7xH
         BP+3Icaks+kY29w44GFN5O0fGLZDaHJnsZlTRb+oBr/hbvzLzG+ri22glIietQh70f
         V0B29Y3WcB5yQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R42Yc1645z4wjG;
        Mon, 17 Jul 2023 10:11:16 +1000 (AEST)
Date:   Mon, 17 Jul 2023 10:11:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        Tyler Hicks <code@tyhicks.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the vfs-brauner tree
Message-ID: <20230717101114.5add1194@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7PJn9NynN/tdFQNxL9gL9qo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7PJn9NynN/tdFQNxL9gL9qo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the ecryptfs tree as a different commit
(but the same patch):

  8b70deb8ca90 ("fs/ecryptfs: Replace kmap() with kmap_local_page()")

This is commit

  031a0300f2c9 ("ecryptfs: Replace kmap() with kmap_local_page()")

in the ecryptfs tree (where it has been since Sept, 2022).

--=20
Cheers,
Stephen Rothwell

--Sig_/7PJn9NynN/tdFQNxL9gL9qo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS0hyIACgkQAVBC80lX
0GzPxgf/TLzGbwcX/VBQAut8340oV93AjSG1aNyDT+cmT+i204SQRmhrI4nikRxw
UHqWPT3uRs0sgTFkgzFnK9isjAeHTs/ljl9ECKRWdI3VW4MMxpXDo3uJ1kQLRQgI
KC5n80FOwG6sfPsjbUyClSBx9YqF7xO2vQ/DGtrymaGq8I9/jqQ1hO04Zn+95Jpl
m6N1pOEO6bQO+lfvntv1UYYAkQV1bpEzA1cd2DXOSxeiFZ0Bu3HYLzI6GKtyHe51
SA7Kd7Svx8g08WWJMCxeIqvjjKDpYGhxJBkVqorsFZyKeWlb3QvQJsoJ5+M0kYQc
AURAv31KNzScHStvhtIAzRPJKL4J7Q==
=+7R9
-----END PGP SIGNATURE-----

--Sig_/7PJn9NynN/tdFQNxL9gL9qo--
