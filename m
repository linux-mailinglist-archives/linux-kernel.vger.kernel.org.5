Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52D77CB983
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 06:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbjJQEHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 00:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQEHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 00:07:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF2F83;
        Mon, 16 Oct 2023 21:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697515635;
        bh=8yC14mMPUG4EM1Te+1TbcoTuJ/AgGXdtJL9pp/11p+8=;
        h=Date:From:To:Cc:Subject:From;
        b=o6734GUN/kRFflqdNm2t1PUL7GOJTXID/fHDg8L17nHbuNw2ou8UIiC09cymsHbPM
         GxKIheKSROmgvsAxbWF/IXiDK8RrRqhQFBSneyxiMAoDktIO5EdKWxeM2DveCdf/lU
         eUSnCoMrNhlR24fxOiZ22MruhvU946NDOwVkSe5Y/WP3dK6E4TJlOthv5eOlJwbXTy
         5Mnd06X1ej4DVZ5wZb7zqOSzs0uXWs4TmgXqDAh0n7TUARWpqXWAajQMrxJ7dsyFGV
         ozZbNq4WBbvMIxKjGeLAwqHg6fIysWNbv9WBrwrIUPJnHwL+dPI3IR93GXNyvzgZHu
         pH2M7PUemikxQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S8gRR0jgBz4wxZ;
        Tue, 17 Oct 2023 15:07:15 +1100 (AEDT)
Date:   Tue, 17 Oct 2023 15:07:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the nvmem tree
Message-ID: <20231017150714.41a6c640@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ChICRx5d1PBQfeJ7MUaADPg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ChICRx5d1PBQfeJ7MUaADPg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the char-misc.current tree as different
commits (but the same patches):

  d0b450caca6f ("nvmem: imx: correct nregs for i.MX6ULL")
  f46cfdaf5c07 ("nvmem: imx: correct nregs for i.MX6UL")
  e898831a6683 ("nvmem: imx: correct nregs for i.MX6SLL")

These are commits

  2382c1b04423 ("nvmem: imx: correct nregs for i.MX6ULL")
  7d6e10f5d254 ("nvmem: imx: correct nregs for i.MX6UL")
  414a98abbefd ("nvmem: imx: correct nregs for i.MX6SLL")

in the char-misc.current tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ChICRx5d1PBQfeJ7MUaADPg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUuCHIACgkQAVBC80lX
0GxWMgf/WYx+AKY0d/D70gB4MpH7TaVVPfP6KmL83b30G7SX+szgom2iQLF0Tjz+
Kexv91b2XS/ZrmVTVjrl6snnJ9wzEZgJY0jKqxrddh4FLu4R5Qr6c6nlYueCk5FK
aZZwOgmH+Zvfqx98f9SK6nEU+nMBfdM/udcuSuv+zz16hJwk5rO/EGSFz7oT8/1v
NLiuw9aGBznxHUkx5vCcUDAk6blEDRG1HKvE0xLZmpzn8rAQA4Er/IimmlCA/uE2
P3rYR5EHv+PxD10MnryfJObIVJe58i0EsSbzmwubf5s3MNCGkKqtgUKlxOA2gT+M
moAoPUBM0FKAk1Rk7JTej7MAPwo6qg==
=2znh
-----END PGP SIGNATURE-----

--Sig_/ChICRx5d1PBQfeJ7MUaADPg--
