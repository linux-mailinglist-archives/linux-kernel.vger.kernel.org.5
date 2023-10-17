Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241C97CBA27
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbjJQFct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQFcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:32:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA13A4;
        Mon, 16 Oct 2023 22:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697520763;
        bh=vMZfWwkElN246pFgTJdzSkVyZOT+LEHzT6mMBxK8ElA=;
        h=Date:From:To:Cc:Subject:From;
        b=tmnyq+sCRJA8EwqUkP0jyiFgPzzbQAkA8N3EqpwvN8iDT2IioU7F8nqLuLbFr6uvY
         IvW7b3LKt2ueh5HJ3Lk2KdZm2R2eAY5qKLUzGggQSKq71C0GXqLYwBSD/+MQyt0tfN
         9B9Zzu1Mq1Mkrhpj6n8HcHwG+/FSPxLvXXLVRAPsGiZA5QMfmL+n4JPCi77cfE03Lc
         yE7aJzdXPyOHE9wElYpdRagZPN8CNS9CFgi5uSeRtbgb4UFJJbaDLO9OjRvCFucVtd
         KvBv8kv8m23lUAs6dceewazmoLbHlRxJMt5cE7xoWYEIuu/bVjtkB90jk1x643r+/N
         6gwJeXeuxmYrw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S8jL35lqZz4wxZ;
        Tue, 17 Oct 2023 16:32:43 +1100 (AEDT)
Date:   Tue, 17 Oct 2023 16:32:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: the fetch of the tomoyo tree failed
Message-ID: <20231017163242.62af10b3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.kgUHYOmDSE3ohIjAL6WlUw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.kgUHYOmDSE3ohIjAL6WlUw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

It failed like this:

fatal: unable to access 'https://scm.osdn.net/gitroot/tomoyo/tomoyo-test1.g=
it/': SSL certificate problem: certificate has expired

and indeed it expired at 2023-10-16 23:59:59 UTC.

--=20
Cheers,
Stephen Rothwell

--Sig_/.kgUHYOmDSE3ohIjAL6WlUw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUuHHoACgkQAVBC80lX
0GzZWQf/cCIZo3VUGvwDfJG5e8ohEKpWJ4Rw9GKW2kn6zj6zt6bd3aefXhI8cWDh
m7sZT3dqTWGTBt0157rzsfb5GoubS+RT60gO4u07Y13L2mpWyip0WKfFZ/GCLwOX
xlS7L89mnXiP9mwhSHaG92o0vth9jtZV3zWFchdnz6E5ia2tZoQXF398bKA/elc1
0DkRClgOGK8vySimuT+OssmcrrEiLQxngJJXXeZbNOkcAgnXC4FKSvLjESub3MCK
NlJW6PTZ8DLZibJsiJr1eN9FXDxz3MrwolIBZfrD6TfzqrKI53udwNzfppHlISy6
n6BgKe4Bd3e9h79UqLqN9dLhryVXIA==
=7Fyg
-----END PGP SIGNATURE-----

--Sig_/.kgUHYOmDSE3ohIjAL6WlUw--
