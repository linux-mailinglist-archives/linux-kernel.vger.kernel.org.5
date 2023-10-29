Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF647DAE58
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 21:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjJ2U4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 16:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2U4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 16:56:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E1EAF;
        Sun, 29 Oct 2023 13:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698612991;
        bh=vaJ4TR1qJ/mWN2JKMSlQh04o5B9snfYq4UsWqpxjZvM=;
        h=Date:From:To:Cc:Subject:From;
        b=hhaanTsNvWIZ9SlWqAMZzrSZPonTUFnWG061aaThFWH0jtNa4sYyAAXCAPpTvW4IU
         8gATAAw7KDZLyKhzMYFVqhRoC1gg1VWIsbqirrhIrtSF65rlBfKXvtioWPk/8yh3Z+
         VdH1tT9ML6RvL/EBIGcEOKi6BU+IDca+QNRQdRSDlmZpq0WOg4HGizqshlKA4aXBZ3
         Sojd0hUi6pgFYchuTn5axhWaedPmmUTSxvRnlB38arkdurbBaIxEu2Y2fdHx0at2NK
         lVFtdfwG9/mA8wmmc2hjzwNcZQlA4pAVGbQJ0oT+/LKPN2p3VCCpMi0dI27TgBF8d7
         UUbdS/OJy3DSQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SJTGQ0Q7Zz4wcJ;
        Mon, 30 Oct 2023 07:56:29 +1100 (AEDT)
Date:   Mon, 30 Oct 2023 07:56:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the risc-v tree
Message-ID: <20231030075629.0296f072@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HV5VZSwmL3obi6OKoUnZlpb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HV5VZSwmL3obi6OKoUnZlpb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  767423658d53 ("riscv: kexec: Align the kexeced kernel entry")
  fe2ed36d419f ("riscv: Remove duplicate objcopy flag")

--=20
Cheers,
Stephen Rothwell

--Sig_/HV5VZSwmL3obi6OKoUnZlpb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU+xv0ACgkQAVBC80lX
0Gy4iAf+P4eKkXL4erp87uLWlmMXxTyLTTwMl7r0epUSauUt3At8h9ognU6DJXYB
6vKAsaZoJcwm+zLHytJqFmGK9v1VagNGH2HooQbV7ORw4gRjnOs779T9hV5a3Loz
X42xGlcyV9pcA+OpEXBOiIc16hZHvZ1ZpuVpnVv/1nwOeq4wE/Sq4g1v68sbrwjr
ovxu3p1DaS1qT2MUT1kcqDRZALZMu5Td2C+sDqrz6+GjyPZJmD/f9WderGQliwsq
Iigq3M8IA/9I+N1IXpmXM7zLV2jAX96Y3Iqz3XXgvPM4rkTYwL71ormwEpsxrwob
enu2uEZz+ZPeEANbfzDLkc0ZUpuCwQ==
=UOQt
-----END PGP SIGNATURE-----

--Sig_/HV5VZSwmL3obi6OKoUnZlpb--
