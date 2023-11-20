Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52B57F1F57
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjKTVkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjKTVkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:40:02 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9D9CB;
        Mon, 20 Nov 2023 13:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700516394;
        bh=ZUHtKmWY+81XhelBP73qoHs8AeB/zM3hJJ3dafxVNj8=;
        h=Date:From:To:Cc:Subject:From;
        b=FCYhYiK41ZvwgxO6TaIDf5s3/PJnUI6Wh19jpad0X+fxNpT7nKeldI0r3hvoDZWuX
         7ZaE5HkdSaSoGb35Kj+KvBZQJ0nNuKUlnthasHKL6RqwF9fa4AIYZd1NFqNSLhgtS6
         uT3yAy8242CFYU2/lMo0zaCA6ge0C3L4ZgaR9kKrVHDu9uLtNAmn9saZBF3A4sGQO2
         IHHOGJ10RV7jkFYMROWG9lFC4SKHJkguZUP1Xv+JnLHeKuKgpDNGHOUt8mBrbVIMYD
         g5PdXrgiEBqlu56FaRSneow2f1nXbPE7YSwyVxeeQO7pWE3GzcCVPm1ip9x6q9h3Wt
         e9vje/Oz1kQXw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SZ1BK6ZP2z4wdB;
        Tue, 21 Nov 2023 08:39:53 +1100 (AEDT)
Date:   Tue, 21 Nov 2023 08:39:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Fabio De Francesco <fabio.maria.de.francesco@intel.com>,
        "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mm tree
Message-ID: <20231121083951.5b314a98@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Vh=cqXW67=TJWI=_58Lys6z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Vh=cqXW67=TJWI=_58Lys6z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  b2419063123e ("mm/util: use kmap_local_page() in memcmp_pages()")

is missing a Signed-off-by from its author.

Well, not actually, but it helps if the Author of the commit and the
Signed-off-by use the same email address (or slightly more similar
than this:

Author: Fabio De Francesco <fabio.maria.de.francesco@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.=
com>

--=20
Cheers,
Stephen Rothwell

--Sig_/Vh=cqXW67=TJWI=_58Lys6z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVb0icACgkQAVBC80lX
0GzlAwf7BZMi0XRFj7e5+2bRYhN4y77JCfGPhEcQlmylA+b002gzy9A0iNcYA4yo
U4vkbNMq6Vw6BZrGJoZSK/e4O6CgCpOwyXmuoLX0juxAIn05OwmuVmp2OIH5QkII
GaYrIq8CWRmZFmrHq6584xZEnvJjGQZuMT8Wy83btCbkvq7KDgTrqYzMuf5rjhux
MF7BofyP5A5isDi04qGjmgY5I+GxW/H5oB+BNWd6Z9phBFmvOuduPuFzH6036f0D
5LSwt6o1MBuQDHRv9o37BlfBHHKBeqdo9N/klB5sc+hdIgb1JxvBYdVjrmsfe5aX
AKQFBClorMjzDM87y4nwM6cgt1iNpQ==
=SNG0
-----END PGP SIGNATURE-----

--Sig_/Vh=cqXW67=TJWI=_58Lys6z--
