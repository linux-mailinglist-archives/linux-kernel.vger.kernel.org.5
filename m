Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451387AF820
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 04:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjI0Cag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 22:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbjI0C0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 22:26:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108727D86;
        Tue, 26 Sep 2023 18:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695779612;
        bh=orjyqxzMipv8kwfgovdAwTG4JPXHD7W6TbqcYQTsunQ=;
        h=Date:From:To:Cc:Subject:From;
        b=YmPUSOYP3wgoXi5881h1dSMMzw+mHK3pAe/w/6MdGday1aVfCw19wv40buXfofOYx
         9+vy1PGCLn/okHy9ddfvNBxpuLG26KaPpwGuIoqASFXHzE4e/zLn8+t8ky3lNyei8j
         dchzhM9JdqAMr4V65MexQCaNru8MSUwgEEB73EG1CTISgF6XG2tJwbhoFmoIMot3Ye
         Yw+I5tSBq7D5dzl23TYD4oF2d1+uxcR7JWraaan3JDd8faH+NalrZy1qjqsROWuKNY
         bJNIwAo9VMZdZDZw9WKsnvzQy1PYfpFyIdsGSpdMqgzquTQhMpjTqurVKk8kkFsl3a
         QVXdRDfJidujw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RwKQM6TZrz4x3k;
        Wed, 27 Sep 2023 11:53:31 +1000 (AEST)
Date:   Wed, 27 Sep 2023 11:53:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the rcu tree
Message-ID: <20230927115330.69ef6671@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TebrxWbqq3O=RqDJD=p.u4X";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TebrxWbqq3O=RqDJD=p.u4X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the ftrace tree as different commits
(but similar patches):

  8f2612479c71 ("doc: Add /proc/bootconfig to proc.rst")
  648c895fda8d ("doc: Update /proc/cmdline documentation to include boot co=
nfig")

These are commits

  5f4028880652 ("doc: Add /proc/bootconfig to proc.rst")
  6eab72b5fea3 ("doc: Update /proc/cmdline documentation to include boot co=
nfig")

in the ftrace tree.  They are causing a conflict due to the differences.

I am guessing that the commits in the ftrace tree are an older verison?

--=20
Cheers,
Stephen Rothwell

--Sig_/TebrxWbqq3O=RqDJD=p.u4X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUTixoACgkQAVBC80lX
0Gw0tgf/QyFlutIlCRtEOD85fbgt2dltTBki5a0F8TBEOxFBfcq/IexM0nXc+0d/
Mxjmaai0xc/bzgWle/LQS492ZVVcss25fV25zpbZyZLKB61zpS9UXEnVRHicqzor
lkbZRgVXmPbz38C4IEfQS8qcuve/YnSMQh2yJeQ+qe967F7Tss06Ga9QvYCA8Pxp
ehrjJ66ePtvySKF+38Me8gulCgVAs/Nm9UyRyyLjJIc6j0s2UjyfTgXhZpneY4k3
PIe0iP1eTbnNVScdUuJuFHtgC6QUQfrqcIMOqeQxJ0HgPoUGGBhv5nYvhnpe+C4t
Iz5fmthjovrYjXmWG7+5FLm4BonbeQ==
=lOu+
-----END PGP SIGNATURE-----

--Sig_/TebrxWbqq3O=RqDJD=p.u4X--
