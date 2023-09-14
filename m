Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F007A0FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjINV0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjINV0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:26:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D851FD2;
        Thu, 14 Sep 2023 14:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694726803;
        bh=XMEdsYr2iK4azShfUiq3F+FU2zjGXx6T+S5Oa+kszrc=;
        h=Date:From:To:Cc:Subject:From;
        b=Zu5SsbHZ3W+YusVgBgw+Mai9/W4QAscqAzgKpf4CQIX/H/zZ1Hpsuqf6NtK+B+Ha3
         PDnq0Qw2j1C5YwXJy/pRT2bM2mWP2mkkushxdx0O536jJw1krqVa7hqFSHMMnVJHZH
         53way7WRdw0IMeXd2fx0pyd1hs+vSZpeaPrNNsk4RZpCk8yCxpLsmNO3OVmw4GsyZv
         3lVvCMI89Bz/EtwbgrB2jxhw8dEcpxHhMFzQTTsQIIYeGfZGTPxz/iPR+NIWSFBp2A
         zX0xXNrNaEeGauT791hXWtUHeNpt4HkDumxyXCWTQotjPlKAbKsglFjDbLexrI9a5N
         WuVlemAuxCZqQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rmr432Fc6z4x3H;
        Fri, 15 Sep 2023 07:26:43 +1000 (AEST)
Date:   Fri, 15 Sep 2023 07:26:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Veronika Molnarova <vmolnaro@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the perf tree
Message-ID: <20230915072642.74e3c00f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kF4jKAnoc4SxRtPoubbXMqQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kF4jKAnoc4SxRtPoubbXMqQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  19d8ab40f89b ("perf test stat+shadow_stat.sh: Add threshold for rounding =
errors")
  0c4ded92280b ("perf test lock_contention.sh: Skip test if the number of C=
PUs is low")

are missing a Signed-off-by from their author.

--=20
Cheers,
Stephen Rothwell

--Sig_/kF4jKAnoc4SxRtPoubbXMqQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUDepIACgkQAVBC80lX
0GzGjAf+Mp0XiiZyA82gE7jivfIfahAWEWt6JZqGN4qM2ATghSlG0Kz25KCpcYm3
3walfWm3Rjsg5S4XrobrQaatKqDgeAjlXE+O2sNbduAXCd70fy/sa1BOLsxkyiwI
sLS/mBhGSSxc9mjei9kb/awoRQSOrKYE+og305qjW5xPfm/q69QYAPDxihssMT+x
bbaLVEnDe7MpfplU/U6/5HZIg3sR4MELQ1Ss9S8IvjQkOEaGQRqVWorOf/C6szp5
RbesnqU4kkgxmbdUbryyRJ0j82HiqX4eJAdOUsVTdO8Jmo94WBIYT2yGMh+2RRF3
9YtqrYKCDvtBSrE5vjvt24u418lOhg==
=qbWZ
-----END PGP SIGNATURE-----

--Sig_/kF4jKAnoc4SxRtPoubbXMqQ--
