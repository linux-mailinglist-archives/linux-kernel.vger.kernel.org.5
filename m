Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C37F7BF197
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442046AbjJJDhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441973AbjJJDhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:37:47 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DAE9D;
        Mon,  9 Oct 2023 20:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696909060;
        bh=+YBDd8EqcKOk8r91tHpJ76I89kDL1oGZ+DnbVAXqp5I=;
        h=Date:From:To:Cc:Subject:From;
        b=oP4rNcvv3zsYbO1/fSoKTxsxwNDb1/2sKEeR7sut1sOSAoj0EHCcS4LKKcZBnAzqc
         UhAo5AO8I+Nj+e+wspN5xPRubaIwTq7qgDePs6yyJK5+29a7KLtlHpZT8ThdoGA856
         3wIlbqkZAL9KOebRYvi3pf1yMdRPo0dUdRtjY/hrGRbCTJd+aD3Hg+Mmmt9ICV+ZgO
         dw5CMTlWMycDtpvIL0jz92QJJ6Nd05PPXUnuCu7mVGTL+JwfPkZ61W/S3PLkLJZvgX
         qb189+tjwVMGJ5ZPU08t++ROxYZ+SnT3kiOqR+R/Id4/zIKS9bpixmWhq5rTGSSjdD
         qbxqrnAr2a1eA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S4M6X2NDdz4xM4;
        Tue, 10 Oct 2023 14:37:40 +1100 (AEDT)
Date:   Tue, 10 Oct 2023 14:37:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the spi tree
Message-ID: <20231010143739.4692aa8a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=IipmES8wmdPvmq13ZSX.ic";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=IipmES8wmdPvmq13ZSX.ic
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the regulator tree as a different commit
(but the same patch):

  8a6b446d8a13 ("spi: spi-geni-qcom: Rename the label unmap_if_dma")

This is commit

  663060e9213e ("spi: spi-geni-qcom: Rename the label unmap_if_dma")

in the regulator tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/=IipmES8wmdPvmq13ZSX.ic
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUkxwMACgkQAVBC80lX
0GzYIgf9EDlMNf+2qWua4jgnZ2ABwHDWKEOs4fpymk4UiKKSGTlAPjk/wrFvUGDk
LmqwqL5ZPnsvhUYh5B9R2Ko2mM8KELes2Ga3JyKpJCWDoUoP1tH5Kf8NrzhX1O3d
LpgE+0kNfgTeWEp1xp2V01p8TPIFneOHsJZdOnkW1ObzWMg9biLOql4QdseBi/yI
4WpTufqaPcPtuEAUcGtQqv5airPkRF6Am+qXXd+71YGot4YCtqc+WaQT0v4NSgTP
Ms4WPnIKWXzSQQ73jN8/sY9WlXSxCh73aoYxJO+SONvQfj6oru2wvkPDDYnpJLXo
R2F04jPwNsH+Eaes82pultRo762J5g==
=5APW
-----END PGP SIGNATURE-----

--Sig_/=IipmES8wmdPvmq13ZSX.ic--
