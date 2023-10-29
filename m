Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725217DB0DE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjJ2XVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjJ2XVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:21:32 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5F04B15B;
        Sun, 29 Oct 2023 16:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698621132;
        bh=bKHXvgvKyB4M/Qh3XhrCU3H2j2rl32GD6xyS8sP2HKM=;
        h=Date:From:To:Cc:Subject:From;
        b=VJFIL95MvtZjZ3bqqifuz6t1q5ZR1qTU0h/MHyCcZ9UfuFuelXsEgBzoEAC7Gdq6y
         vUJbiOWJmzEzCzLeNdr61zof/y2nYo8Cp/ia1RmGIFVVfWQbCb55MVay+iGOpyz0OC
         DcrerEx6Vm62deXkhdXNW7ep2XCCPHQJcOM7dHXnrKn56tSQfLlr/O/+TvBwswz7Lz
         gRNL8Fv1lgviZoptYADpKYS8hrCkgIkaXkEI31NS2SdhDHDwZSNVcB9/i7a/V3AIEp
         fQtTWB4GtOIsdcINFhwZGfjatxTGwjubGbOFDMu728CWA6GbL/gLrVMJ5j4tihL200
         XmrbIPyNWqIbw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SJXGz4hPvz4wcX;
        Mon, 30 Oct 2023 10:12:11 +1100 (AEDT)
Date:   Mon, 30 Oct 2023 10:12:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the risc-v tree
Message-ID: <20231030101210.2d787c26@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Zw.b3GsXOHO2gd06ge+pIYW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Zw.b3GsXOHO2gd06ge+pIYW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the arm-soc tree as a different commit
(but the same patch):

  5392534a1954 ("riscv: Kconfig: Add select ARM_AMBA to SOC_STARFIVE")

This is commit

  78a03b9f8e6b ("riscv: Kconfig: Add select ARM_AMBA to SOC_STARFIVE")

in the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Zw.b3GsXOHO2gd06ge+pIYW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU+5soACgkQAVBC80lX
0Gx90Af/V28ebVcvRpXsrf3A03LwMwlY5o2rt3g2pWvRjz5lcQK1jEVzFNMwjKsK
5SsLJ9+EcHN5FltHrozQ5ftvDMsxj2Hnb1GXXxFraKyxeTFOL51PLP+YmT96cMUt
4qj1h4DfOqKQyGZLvc7r/qjyjTFu2Jd4BWnktoPGYDIAhkaO6ttN4zLJ095/3QAC
nVLEmFSuqIQB3A+1PlQSvNtOQxj0/kOvkl4t7LAoQ9gbMNDcj9vc2tkYfZaHOlLn
BgsRs16YliFCltgU3lR4DxBRKHc9wFJc2RVCvQXjxo35R4DrtMmrqtYMoOVkpZHd
J2LIAEQMtSxQQUveW/AE7tT4M8CMbA==
=SN/g
-----END PGP SIGNATURE-----

--Sig_/Zw.b3GsXOHO2gd06ge+pIYW--
