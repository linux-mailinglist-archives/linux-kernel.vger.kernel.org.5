Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74FC7C604E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376503AbjJKWWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbjJKWWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:22:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD406A9;
        Wed, 11 Oct 2023 15:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697062914;
        bh=gWI3g1sw8HQve/xirN8nScxHDRHDuba6QRYiIsAopGQ=;
        h=Date:From:To:Cc:Subject:From;
        b=WzRg5RXsLycuoCTIG7/uGq/Ix6x5dJjPjejk72eO5IN8WiGYfCo7A9FumamMF4ocw
         rjGDOA5ZVKJAWiiFRq46fbcytn0pEElrNZ9no2j+vNcZP0B2IiTKMxnQ4rxvpNlL0r
         U7KPYcynu+B/0W434x5ReQXAaPjaBJx+qqcbGj0alE4/MbH9zhm41xjUwwiJSeBWsG
         ggLSVFgthtSIdnNYf7tLHE54O3YDriG1Ma/czmPqG0ZvAmoDoM7DBzaAWu08qbsF8v
         qZwxan3GOpa+SNFs2GfG//YXi5k0BeN3BrmLKWotFiSKPazHH4x8i3smxUtmLb4T93
         Nzk9EcYTR+Vyg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S5S1G2lCJz4x1p;
        Thu, 12 Oct 2023 09:21:54 +1100 (AEDT)
Date:   Thu, 12 Oct 2023 09:21:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the btrfs tree
Message-ID: <20231012092011.0b240b3a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FhiKBlA_9Zf9WD_=KAEw6zs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FhiKBlA_9Zf9WD_=KAEw6zs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  182d82b2139b ("btrfs: add __counted_by for struct btrfs_delayed_item and =
use struct_size()")

This is commit

  75f5f60bf7ee ("btrfs: add __counted_by for struct btrfs_delayed_item and =
use struct_size()")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/FhiKBlA_9Zf9WD_=KAEw6zs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUnH+IACgkQAVBC80lX
0GxHQQf9FmKSlVg80dBHrnQOURMZmbThN24e16Dcjoq9l5z5Vydxna55KFZP3WC0
lscAAAVwzOIN5DYkSt20T0H4DcChT7j5sCxGcFxWT7yHgNn29vZKCTnGRcbm9s/D
dmzgUsqf4g+D/thZIVjP/kpDFNvygfVamR5jU0hoy3awN3zr2aIGIUwInKoUY5ei
ehVfg064AErGhIWHu+41pnNQoVDG1waZUnQA5n4PBHLNHEp+nVsZKKqfFgYYfGjT
6AcoBGaHg00rcbppLbv5Iw7wR/OwdvQ8b7XrFzoAXpq1btIQonjcqx4g2LfV028p
3D/84rJQsmPxKaGbfaA3PjbEoUwjLA==
=ov+T
-----END PGP SIGNATURE-----

--Sig_/FhiKBlA_9Zf9WD_=KAEw6zs--
