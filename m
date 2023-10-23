Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D167D4299
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 00:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjJWWPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 18:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJWWPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 18:15:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA749B;
        Mon, 23 Oct 2023 15:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698099305;
        bh=reWOdwCpfQGeFAfpJoJyu/w7vKLIhVwz/XO9tGu8ldE=;
        h=Date:From:To:Cc:Subject:From;
        b=kvq4TBmja7IQru62PJjnKA5P912vRLQt3ztYnxKtwg8GcWddMi0KleYK5HxCQRnf9
         k+fmjTyGQo2MXtvFXAoNwB1pGf1LbodA94oa2RLp+LjEytypmo3UQNW2FsfN6zNI5r
         Jm4wwAtqnjWpvT+DbhloBJe9uU/8jZ08NFJWQ9C/xl84bK0yhzcluf+nRFY4a+s405
         rQudN5i5DdD5eDlKo1EF1bFCRPloubO7FL54Kij4+YC4bvFqcDE3YZsFS1kkT1Xww9
         HJOQa2BxAcnZjWg6jAAisarXVev891Dy+MQe9id81iLaId4d1ZuauwX2yhftiLL/j4
         y62ItXDvHhFNg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDqHr5hmWz4wx5;
        Tue, 24 Oct 2023 09:15:04 +1100 (AEDT)
Date:   Tue, 24 Oct 2023 09:15:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the fpga-fixes tree
Message-ID: <20231024091501.7d58bc99@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/x3gwQHw0UI+JrD8s=qG6xAC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/x3gwQHw0UI+JrD8s=qG6xAC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the char-misc.current tree as a different
commit (but the same patch):

  ee8abd6ce1da ("fpga: disable KUnit test suites when module support is ena=
bled")

This is commit

  a3fad2e92c76 ("fpga: disable KUnit test suites when module support is ena=
bled")

in the char-misc.current tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/x3gwQHw0UI+JrD8s=qG6xAC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU28GUACgkQAVBC80lX
0Gy0Lgf/Tpdu1UfgFG4w3QBD6L+k/eNHML2Oos+dShdkRsUKEL3oDfDYlG1dR3bA
t2GR93u9hLKnmfYU4v7r7wdGAyROTNPlzqEkdYAaBmdhnLxtBtkNAnHtkSENJNw0
oBcmpb3VW1NuSw2jFXpYdrVbmvVzLM+DYpb4SMdMMXs6MT2t6fATwNSau3eVYfsh
F3ffl45NzkxGyjcefZxbXA3eoh1RFxaozxMt5C29C8RMSieq9xNCAEGLpxkTfZQ/
1qjIptILtU7GDTmG8KhYFAggLvV64ccFxr2rK60C+rG0Bxb4DM7Ip+0HXF8tFs47
yz9304TkbDNd6WcTSNicYmyl4Mgoig==
=Magm
-----END PGP SIGNATURE-----

--Sig_/x3gwQHw0UI+JrD8s=qG6xAC--
