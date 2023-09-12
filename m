Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4905F79DBAF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbjILWLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbjILWLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:11:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BFF10DF;
        Tue, 12 Sep 2023 15:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694556652;
        bh=hzxfvmySaIDBJU4IKdLgpG6Qqj4JyxZqaKtaEVBHDQ8=;
        h=Date:From:To:Cc:Subject:From;
        b=HNOGOO8BJItgqIpExOqS2fPscbcUD8IWTy9ICReKmK4SXUaSLRchnNTXlV6XKp922
         WV3Ejgyw5WXMt5fS5PjeZAoINLgE1mr/VYxyd8ofae8zlHUMitpy93RiMBtWtZUNy6
         78D0yiicOqiMsav0MmEkKQH0rFNChBwdkW2dr9p9/0MlAbOB00AgxecXVqqP7ijl7o
         iY5mOXRTJJm9bMaikfjx5fdEP64WseM+LAei98WbBawBBjuO3u45fTLLD3MzVcA+yV
         Q5t7eonmZcK+4Lv3zMdNeFG7qrPDaZ3BlrYM4dfkywzQHjZ/oC7k63TNEk1EMdi5/8
         F4IoT9CEExYEQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rld7v66xtz4xNj;
        Wed, 13 Sep 2023 08:10:51 +1000 (AEST)
Date:   Wed, 13 Sep 2023 08:10:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the bpf tree
Message-ID: <20230913081050.5e0862bd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BW_/5e442H6Rlu1lcQweJJn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BW_/5e442H6Rlu1lcQweJJn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  3903802bb99a ("libbpf: Add basic BTF sanity validation")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/BW_/5e442H6Rlu1lcQweJJn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUA4eoACgkQAVBC80lX
0GxGjQf/SGr1FLGGusMk6/5zOdgHHsTmEZrx/D5btKy2p31GRNf91oKqcOztl9dg
1cfUYflEAP4e/NCvtza/EtmFOiycmhViDv1XXNwdyEJoGlRC22L38+GL4ZhqhZbI
CAxtMQ4YcLUBc7w3APV4HjMtiwtLv87/yg2BJrnkx2Fgkd0PRZlrYr16mpzNsL3o
7hqKGNanKVvceHww5DRTaFQ2+cMxOiU6H5c2lSSRr3YG3QMyGauUiYPWSFPHF6s5
Ow6FpTf+G6kOvduhgympCNz4Ww+CzCrzZ6M+ph0bgA/MIURPEOtjm9SsqsmzKGbq
G38dnCAriKNQFNEmSDwO6pNwH20tdg==
=EciS
-----END PGP SIGNATURE-----

--Sig_/BW_/5e442H6Rlu1lcQweJJn--
