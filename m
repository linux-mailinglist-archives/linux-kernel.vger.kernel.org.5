Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B10771734
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 00:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjHFWhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 18:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjHFWhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 18:37:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3484CA2;
        Sun,  6 Aug 2023 15:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691361459;
        bh=1wjw+jSjxokmsbo4zf/QstdPYUS4IgX4bXU3lj2fHkw=;
        h=Date:From:To:Cc:Subject:From;
        b=VS3ZTKainCdWvMWCUARd7Qqz0utyK6WejyZTNhFW5x4KQunD307UA6Zcvu4K11DN/
         OdhSAJo6Ue8DPn7pGLH78Xs4gZ0HMq7YTEgAN5WfawlXDLanKwfBYuZ9saruNVTfdZ
         8pMHrQOOmLnUcbRszJqlmS80poZOqnhx6okOyzphWKcvpt+yItbIsLy/2PEGqcLGnI
         IxzTZTXA2eyBzdLc1PlT1XYESzrWBOiPMTG0ruIaNj2Dsullc0jqnaAZoD+XBhvb0t
         NhQ9ZrVKa9+eJVEguxV5u4VM/EAkAgYs7CCiUzpzsNch5rrqIVDb+DL8ft9eTtxhsB
         hpxLk60luK8MA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RJvTv0P3fz4wxQ;
        Mon,  7 Aug 2023 08:37:39 +1000 (AEST)
Date:   Mon, 7 Aug 2023 08:37:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the vfs-brauner tree
Message-ID: <20230807083723.79f2b06c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MSIqUnaSwQsqYeh_42A1pHo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MSIqUnaSwQsqYeh_42A1pHo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  7c62794bc37f ("open: make RESOLVE_CACHED correctly test for O_TMPFILE")

This is commit

  a0fc452a5d7f ("open: make RESOLVE_CACHED correctly test for O_TMPFILE")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/MSIqUnaSwQsqYeh_42A1pHo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTQIKMACgkQAVBC80lX
0GxQigf+Lk723Tvy7Q2pCYO/HDJnryyMYH3pR39+R3Ylg0uTE91sPsGU9kWRYn9v
jiNOYSAghmUnTN0kuUoTO1AmchiXWnnCUIH8GX8f2TLJOfI+tRZrb8rlQ1lLlw+K
/38+RZn/tv1LkMFha85QdH/ylYPdbw7ZYnoh/rQd8Wl4yWBLjCOdVh7y6qyqw65J
TWNsWwSz11ys3oHu7p91/GnAiBZyq2pqP+0EvB9Nymz9hhrB1JDeHSZa71BCeCqG
bxdOQqFnw8G5J1v1j35Yxoy05mhob1vq2gJWI7EW4TYaTVQZ41+gR43CLBEmR4jV
kAlOZ36M1+0aV5wNo93coMzM7CUtUQ==
=qNdb
-----END PGP SIGNATURE-----

--Sig_/MSIqUnaSwQsqYeh_42A1pHo--
