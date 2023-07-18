Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4584757357
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 07:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjGRFrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 01:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjGRFrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 01:47:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAA6E55;
        Mon, 17 Jul 2023 22:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689659236;
        bh=c7TcUew892mf8zXBnscGgYVlDqMwoBd4d6F8Zn47HHg=;
        h=Date:From:To:Cc:Subject:From;
        b=Lb3oB+s6iJET5O/YSBwf3v8XMGuvkGqHv/LgyBkO1+FAXePLbtI4ZTotlj4lp8bTx
         qxmWd1vjIm2uQR8qmubrpeK6ZmPm82Q2SOBSTPHs5qoE00za4jidQrLI+JNUiwnrMW
         ahqM8f2gpbY5Z8D9fc8ftUUt5p2EkuYjFgJGlbWgZYgWeLxFaauAs+NCvPgX09UIei
         3MOHvnWOLErxWqeHr7C9+r2JhhFztyLhfoewr0vRPxd5HlMbioPSHOnH32KBduysm1
         eiC6IRnCAy3XYz5s0ZTnQiB6hGe8Jy0+7O7gcbLI8DjnOB4VjDS5cBsenNu5j+kFxr
         xUZf/tmcSYOUQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R4nyq6tTkz4wxy;
        Tue, 18 Jul 2023 15:47:15 +1000 (AEST)
Date:   Tue, 18 Jul 2023 15:40:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the loongarch tree
Message-ID: <20230718154016.2a6a679a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//5/6vnZ_zBYPwKQWR2ozASq";
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

--Sig_//5/6vnZ_zBYPwKQWR2ozASq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  61ad9ba4af0b ("LoongArch: Add Loongson Binary Translation (LBT) extension=
 support")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_//5/6vnZ_zBYPwKQWR2ozASq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS2JcAACgkQAVBC80lX
0GxvEAf/VnFg8zqWsPPMjOQC1jhhvyk+uG8uVDBQn6XqrD0FGg+v0V2eNN+x+UFD
Jx437uCg4Stj7hLySYgvHfyKLK6LnjUA7BSfa7fTTC7t81fnjqL3xRLjLQpzLEHp
WzGzgwOuRP5hsEkziwhsU+DlgoTkO9P1Jqx9GR3Da25uOa/RRRYu9YAfZjF0JENS
KUZ5sdcf0vCHOJo8+iuxzL2+P3OSVGe9kMqxUBf0iRBOJbOiyyvV2tOuVMo0jlCF
GZzK5ciQukD3KGcYVZ01FPefBWgoP1oxvSTCmWWpIcShqFibPZEstd7JgFMsTICm
LC06txnpud9MHj22yJDz0f5DqNjXCg==
=BqGD
-----END PGP SIGNATURE-----

--Sig_//5/6vnZ_zBYPwKQWR2ozASq--
