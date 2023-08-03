Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3959A76F540
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjHCWBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjHCWBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:01:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EAF1BF9;
        Thu,  3 Aug 2023 15:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691100098;
        bh=VfUcVQ8fRjThToHGMYP8DVu6uJPv8HP5cBBle6ELRfs=;
        h=Date:From:To:Cc:Subject:From;
        b=NNTU8sqmRM/H8Db3Y2bXLqy92A2TsTJZX0SSVxQU4P4FkFBTPb0fwlU5c8PvVfT2S
         UM7LTBUxIx6lBbqQj2qPkNgQZm4faJWnzxD8XQIJatGNotAjyBva39HNkp8z/4cCUr
         DzvI8k3GhS4uCILCV3vMajNUbNIUHut7FYy5TA1ysfzvvSzzNMC8kYcTg5qLmgcurm
         Vyen7HRKpEQNNo1b0Dwm/BEl3uBh4nCgYjZeLVbG+A9yGE95WFzRuL4jDODDuIEK0O
         JtWvYzp3gIxnXFjDbFcekGiaCLjU7t6PF1rBcm1feqXnqF4Qsos2eYLAQ2fDQ4jlE+
         +Usoq0NT+JImw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RH2qj71BDz4wxx;
        Fri,  4 Aug 2023 08:01:37 +1000 (AEST)
Date:   Fri, 4 Aug 2023 08:01:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the risc-v-fixes tree
Message-ID: <20230804080137.49f03cf1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Sm65b+Y/07UuFHaDLmu7CjS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Sm65b+Y/07UuFHaDLmu7CjS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  8c82d2bf5944 ("selftests/riscv: fix potential build failure during the "e=
mit_tests" step")

This is commit

  c77896b143d3 ("selftests/riscv: fix potential build failure during the "e=
mit_tests" step")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Sm65b+Y/07UuFHaDLmu7CjS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTMI8EACgkQAVBC80lX
0GzXDggAo5artkXqGE+/iG2j3B6IwkI7pWPGKkTraPDJkbYk8y5CqsdZKTaNdpqO
atqIRpY/5fik0J/4OuzM85M+NXWMzgFHd93WOpYarQGTkC9FBbi4Q8rg+88REpAl
eOmks0bplynh4WrZ3/H88VrACtTYUzP6Utq6D6GrGDS10dZc/JzCqJ+u33q8mzkw
odvo2s4UGBfz0CWUwIiR0098s2gQiZ2qXGRRKKirPQb7IxtMJXErFfLfWk2Q8VR6
vR56tvCuFJ9NA5Gw57vAp/5iMZ+mjwQD9ZDINhj0TZi9wNZKVV0IxwaX6u4NC0wX
z9c9Rj54TxYPVZWJThcWkxgFv4id2Q==
=buJG
-----END PGP SIGNATURE-----

--Sig_/Sm65b+Y/07UuFHaDLmu7CjS--
