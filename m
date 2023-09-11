Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A50979A422
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbjIKHHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbjIKHHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:07:07 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B268133;
        Mon, 11 Sep 2023 00:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694416022;
        bh=BD0TjRZCxPVgHSq56exNf3R6Zxic3Iob6v8BjB6wE2E=;
        h=Date:From:To:Cc:Subject:From;
        b=qTbX3GM6iZQmUjL7mn0Ofewy89NgHolnf4HquJ1AqaU6G2yms5es6BQdFDMN1rJcA
         0OL8middY8W1trUVpm1JUX4yOtHRgcAWhjLKk1c4KvhVbvGcIt/XmtIiNlvUCklcRG
         EANqqXXg1OZsGNZk3nSHF9ypVyZvyHlsS25TaDpsbON+ynQ60B7y33LVO5m3cxcuNN
         0bYYIAkrOO8dtNJkDS5nBpUuTzUGWMyPeCw6ywvMDI0IHfqSaclWn6VXqV5E59s7R/
         NEl10nH4eLQ0ffloUhniJmeHev1zwRXMA2Ck/LsVcgAz4eRn0j7fVEG7PCmlP7AyK9
         U5bv060NueBUw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rkd7V1qgFz4x5q;
        Mon, 11 Sep 2023 17:07:02 +1000 (AEST)
Date:   Mon, 11 Sep 2023 17:07:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the ext4 tree
Message-ID: <20230911170701.50afc18b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S0CCzKk4zmPqhEAjwqQ9h+7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S0CCzKk4zmPqhEAjwqQ9h+7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  147d4a092e9a ("jbd2: Remove page size assumptions")
  f94cf2206b06 ("buffer: Make bh_offset() work for compound pages")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/S0CCzKk4zmPqhEAjwqQ9h+7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT+vJUACgkQAVBC80lX
0Gy4Tgf/UITI7/9WFbMZ0xx7Vh5hF7KZ5ts9Vca3oLAvD3LF9ETBgCafezjlbDD/
Kx7n0WTR114HnONS/yF2qayAHRVC7M/VX7AUyA/ekJR1Mkefz7XBcKafEomMIMtj
hsY3BPiTJuX3eW2f9clgY8VQQ2NMKSfW1B/ILe57d/A+mKPwGbfkbqM0Ul0deM5d
TEisB8Wf+RtNLYFUVBOEzOo3AHPqzt76BgR8pQmQRM4XoYPqap7FVsQwXX0tenPa
gJ4vNG2fXuW6ls8Lj2oGuwbpKnI1Sc093AcVyws9TpRQH+DGfJuBODmYgqMX2q+8
IKVjtxB5/sEQut1HyvzYhpR6CmrkHg==
=fRVW
-----END PGP SIGNATURE-----

--Sig_/S0CCzKk4zmPqhEAjwqQ9h+7--
