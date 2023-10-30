Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49E47DB271
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 05:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjJ3EKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 00:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjJ3EKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 00:10:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43DEB4;
        Sun, 29 Oct 2023 21:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698639027;
        bh=jDnwEPuPT6okf1H0DsBtgfFU4pcjtLt9Viv/alyDl5Q=;
        h=Date:From:To:Cc:Subject:From;
        b=ajubwtNrEzuWzUNPfWDVAPYi3H7zHRvsoI66bKubtcChf4lBxi0wiMjFvsSZUArf+
         uZ5wNMIiJ0D4zfK+g6natGgagrZS9R2yknihbCj1BvXX3MVyhLfKP2hD3fj+ALdWHO
         Vpi17iVJCQX0MPRVSFD2KhaqJtjHzePaqNA8pMcB12s1f2/IKrLXUDwav2MBHCpb+f
         Mhll78XBxa2qA+o/3/AHtU/duDJWtmxltZluJCROl2hlX3w8/DpWPQ1Gv/DAetgtVp
         JXFS1wE7uEUqK63b4CF/CC92HQ5pWel9jp+ziHRiODrk/2eTn5Htr/9l6LVI/qh78k
         MXp1bEi7uTMkw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SJfv53YRpz4xPc;
        Mon, 30 Oct 2023 15:10:25 +1100 (AEDT)
Date:   Mon, 30 Oct 2023 15:10:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?UmFmYcWC?= =?UTF-8?B?IE1pxYJlY2tp?= <rafal@milecki.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the nvmem tree
Message-ID: <20231030151024.35d0910c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5erm5WPpykXk=yRVzd4osJi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5erm5WPpykXk=yRVzd4osJi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in char-misc tree as a different commit
(but the same patch):

  ca7384334d9b ("Revert "nvmem: add new config option"")

This is commit

  f4cf4e5db331 ("Revert "nvmem: add new config option"")

in the char-misc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/5erm5WPpykXk=yRVzd4osJi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU/LLAACgkQAVBC80lX
0GzQ9QgAkSd+btyqQme/LcsrU+Jg44qd7+G+tU8/+l9sWqy1pQbcxlAUHU2h3mi3
G55aAtP9meL8fOkmGI1EWx8aModq1wgbVBptZjlpxFKPaan1do7D+AJTttGtroOc
WfqRrgY5TD5qDA+SUa1940xRMgbubTlNgSll8I1amrJ+vOJ9nQoNvpIoWwPT7pJo
PTfCH1/VJnVSWvPLyOzZgn0ijvdhTEjR9vnER0tsZaaihiNto2MFw1JQVViFHkSh
powpwcBqvzEGmShv1ajoBLwv1g2I1P820c6qtLFSRAlVDSapHaJoNTSQCuzkzDOf
bzFRXe7ZsSraBJaqps+ke8s/U76rTQ==
=/2sn
-----END PGP SIGNATURE-----

--Sig_/5erm5WPpykXk=yRVzd4osJi--
