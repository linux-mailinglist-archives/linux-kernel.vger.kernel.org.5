Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D757CD29D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 05:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjJRDTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 23:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJRDTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 23:19:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EE6C4;
        Tue, 17 Oct 2023 20:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697599139;
        bh=EuyEsnkgjrXOmrlpw8SvJT134IW4p86ShkHqdqUBa9k=;
        h=Date:From:To:Cc:Subject:From;
        b=lPgLczT6tCgmVeYuLCRj7wymJqaHtt1lrIs02p/UcT4/bl+cp3HDdf5HaSEqdzgeL
         9ro9fEcshNJyE8J7QbROsLWGcuKSjr4eEx3dPIjJaQVlSUkz3sbaJY5bvFQzqH6GnF
         5fhxc9Zbg5XijL7tGrk2mRFoOnSiRxdhTYDCMoqrK4rPuqDcD3FAzGlb2Lr5zrICvT
         2NKe1ltZDUpqQU0SacR9r4onDDgLoVs4MOK1bhci0cfBHWqkjc3a249yqRbGWjBNjZ
         8i4eo/qtfagJWlcyUtVgccsNInUr/WAvjMPVJacIHUuyqLL1PnK8NQPB6FPQXZx28S
         39ykDPHc5GHHg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9GKH13pbz4xG4;
        Wed, 18 Oct 2023 14:18:58 +1100 (AEDT)
Date:   Wed, 18 Oct 2023 14:18:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the ftrace tree
Message-ID: <20231018141857.6ba1f328@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PAiFvmAPHCfL+BQGveA/NnG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PAiFvmAPHCfL+BQGveA/NnG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the mm tree as a different commit
(but the same patch):

  2db949178eca ("fs/proc: Add boot loader arguments as comment to /proc/boo=
tconfig")

This is commit

  d120336bf502 ("fs/proc: add boot loader arguments as comment to /proc/boo=
tconfig")

in the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/PAiFvmAPHCfL+BQGveA/NnG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUvTqEACgkQAVBC80lX
0GxIJwf9FXRf6j5jI4PByw70SDwgOE/Ld9Xtj85bDDvt6i5RMmM9jHnsxKTavn+G
IxuSMMkMxKSWGmmaItOy55hojv2wbn5x08VJE6DO44Wcwy9bRYTw1JuWWGwUVOUh
Cfe3rh1Y6osmiPYkzvOz5goKTTcRV6K7s3byTnRx63gXxSLkkeJsX+eRK6sWiGgv
2iR9WlOVQltIhCPKAypWtGSRAICMseTmxeVS2ClR1pixIUMDo8DzbUg/TmKntGu2
wkLQ0VBOai0FGfeWwlluvOK1zgyi3XP8dJA0Ym9zzGTLnOJtpRAn6IxY8BHhzkcK
FDbodjr1bdiIgVo0XWgw5hNjPA4ktQ==
=DUGd
-----END PGP SIGNATURE-----

--Sig_/PAiFvmAPHCfL+BQGveA/NnG--
