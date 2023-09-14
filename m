Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775C47A11EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjINXkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjINXkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:40:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F29E1FE5;
        Thu, 14 Sep 2023 16:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694734795;
        bh=Oftqlra5+L0UF7TlRW5OqbVVp2zkDqzWSgYBnTWEhlc=;
        h=Date:From:To:Cc:Subject:From;
        b=RwUd8DbzBHIHo7rM1KsTD9qu821va5Rfwc/r5ItZOCV+HJPDRIoAfVTKbjv4w/PqN
         cPHB5WknMT3cnZPv/mjZR7zCgI5awitG+FRLvXEQ3D4xdKApo+0EPNv+uzVnEzHNqG
         4fhtP8Y79Z3sd0hgML30gUKT3orTrwp+vj9A0pvKAIlCYHQSqhsypYieeM2k9NqNqH
         6IB8tyVJeUTbNqnl2lxON0iZUrOUzOR4asQgGUmSt2HghhLrwuA3ERwbMqkipKvouD
         YvWgd7sbjNA2xjRoFUiO8M/lkPn6nzHywlwjkwvZpr3eid2yS9aKq5naKOAxHDFUNM
         1cPx5Ak5Wg3Cw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rmv1l0LpQz4wxR;
        Fri, 15 Sep 2023 09:39:55 +1000 (AEST)
Date:   Fri, 15 Sep 2023 09:39:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the vfs-brauner tree
Message-ID: <20230915093953.310503ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ckbdstq8Oq./mbEPhHVSXb+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ckbdstq8Oq./mbEPhHVSXb+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the iomap tree as a different commit
(but the same patch):

  de5b0b257ee3 ("iomap: handle error conditions more gracefully in iomap_to=
_bh")

This is commit

  4aa8cdd5e523 ("iomap: handle error conditions more gracefully in iomap_to=
_bh")

in the iomap tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ckbdstq8Oq./mbEPhHVSXb+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUDmckACgkQAVBC80lX
0GyysQf8D8i8IvsSRYrafT1lXPMg385MyqNA/1Xzqumv5CvtHvWtnT//3ZnDzYkx
Yb2GlLHxxDyZrhT42yrlooILpgcDMpu6YoNazlWk3Sd9BPRPYs+ZUCA871C9Apqx
wgtbs7dRXsur/iwIuhKNuin6pW+HPNSnZThwUd3psg/uU2qPvsw0OEq3dT0Ha8Tq
xhOErcUj+uohLZysndF9s37PjrVHCEOebj1OQwQa6a/UhNP42KyPBcDn7GXNWlFX
QgDL6l7qOC/FeNp4J6+vSwYM8+0dADm5F2Y3DCofUyNDASKHZiXzopC76e7dj8yr
FT0tOKhduf9XZcDIJv7tu97yh6MU3w==
=9A79
-----END PGP SIGNATURE-----

--Sig_/ckbdstq8Oq./mbEPhHVSXb+--
