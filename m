Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31937530C5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbjGNEyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjGNEyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:54:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6642D5F;
        Thu, 13 Jul 2023 21:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689310446;
        bh=Q5VPDuSpnkX4AZXEJtNaEVfp6+8i17kvWpmb2r4hfOw=;
        h=Date:From:To:Cc:Subject:From;
        b=q2ZwXw+jmLYSRq/NTnOFurfk1yA3bC84iOG5fvxx4IOk/SlTJtCv9J+fzM2w0p2D0
         LdwXv9n1mYsn/cySrm7GNXJ+f8fgEEoYRhP25fB4Y5hI00kws5heH50f+wKNqkgOpu
         GItivWLhFbR0za4B38CRbw7P2wwoVGLKpRMpxP/ub6sLqhEA0mr35PZNfHdCKjGsRp
         dq6OmRSy/GN/REoIZfDjLvIEI8vFISdb/w4LpNCxHl9eTeInB8JgdwpQI25u1xTDEm
         tzsFUw2w0EMfzxYq92VdxvmhZep8yD4bUFRjcHvtXBZ8wo+eu8WpXmsfbrzcKmIJW8
         D6wN78ZtMAhzA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R2JzL2bPRz4whq;
        Fri, 14 Jul 2023 14:54:06 +1000 (AEST)
Date:   Fri, 14 Jul 2023 14:54:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Akanksha J N <akanksha@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the ftrace tree
Message-ID: <20230714145404.115c7be1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Zaw0o+s/wLb_v7ud=LCmAlG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Zaw0o+s/wLb_v7ud=LCmAlG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  e46ad59233cf ("selftests/ftrace: Add new test case which checks for optim=
ized probes")
  bd2cdc432190 ("selftests/ftrace: Add new test case which adds multiple co=
nsecutive probes in a function")

These are commits

  5985329c7073 ("selftests/ftrace: Add new test case which checks for optim=
ized probes")
  cf9071dd46e7 ("selftests/ftrace: Add new test case which adds multiple co=
nsecutive probes in a function")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Zaw0o+s/wLb_v7ud=LCmAlG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSw1O0ACgkQAVBC80lX
0GyPfAf7BoZotLi6UYcyWkq9porusAXI462ajqVq2CMxpgFUXgSvG61dirIPcbZa
ZN4tFStb65O08MUeOgh1qJ3OEbytZYBAUItfLSKw8iknUY/xV0gTehP29lz065nl
5TKfHChBC67bRzngEk/whhTo1oJBRTTTEt/ZABxhAXNnmqHE9za1UetKZ4FuRKNT
pFnA1d3KnATyOxlF6m0gl0GR0YxMhvUwUv59Rvop9L8EZ5ZA1V8RU0VhzuoTSZOe
fKcjP56wirz1dzVE8B+BO4Iou+arfCwKHWgCOhSAQQH0w6xoOM2QU7upzIOxApJ7
rIZpFMnUvPc1Q9Hx9w0MVliEd1l9nA==
=RaDi
-----END PGP SIGNATURE-----

--Sig_/Zaw0o+s/wLb_v7ud=LCmAlG--
