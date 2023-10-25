Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BC07D7680
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjJYVTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJYVTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:19:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AA5132;
        Wed, 25 Oct 2023 14:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698268772;
        bh=9i/tRfR1/MlpKccRuA2orgn+CMdJmbapG4NBmApW1Ig=;
        h=Date:From:To:Cc:Subject:From;
        b=eFQ/CaUSrtMlyOHzS6n+RpShHQNlTig9xjqv/AGbXBNbvwvGQCPOHFeCjp2HZ3D+h
         LzESavJ4XRniRslL/aQeE3mrOaPX+ZuPhyto3knP7RBLox+ncHhlWO42qrtvFbvPRs
         cZ7ySRveBxmkrCmmNpOkjBa6JbB4qg8cCCIEgkzjXbPbsE5JHNAkZm8Zquk2bHjzRl
         0oJsFzZk/2zAoZP2rBE17kd3Ds3ZG/8mObeuPg52tu/hTY2IxNgX6h0zGmAadaYUIe
         XhumDUaK15n4qgZ98nmEdsYnoCUip2qhFmp3os7pqlqXa+b2TXL4pdEWWxb1HK2i0d
         3hVRZu+zLyz/A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SG1yr2ZFnz4wxX;
        Thu, 26 Oct 2023 08:19:32 +1100 (AEDT)
Date:   Thu, 26 Oct 2023 08:19:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the devicetree tree
Message-ID: <20231026081930.6b588920@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=NvWPYFzAhMvBTG6bLp1PJu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=NvWPYFzAhMvBTG6bLp1PJu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  460babc96c13 ("dt-bindings: irqchip: renesas,irqc: Add r8a779f0 support")

This is commit

  977f7c2b2756 ("dt-bindings: interrupt-controller: renesas,irqc: Add r8a77=
9f0 support")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/=NvWPYFzAhMvBTG6bLp1PJu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU5hmIACgkQAVBC80lX
0GzhUAf/dGlwGTVxv2s5qCqwa2d3Fm5x8lOylJKMvopP/OlOaQN95w+8Q9Ss34ud
qUBvepcUYlM3RU1l4vumMa/bK+j0rILI/mr5I5/LSFQWaXATUUgp0pr/OktjA7oR
A51+S1+CHglpclqNps0c6/2qiC5xvQofcIKrro/HkfOMES7J6ASLFwFZwk7/Jvgj
nZ7iOMPs9R5Kre2ACRuyyw3RGhsSWg2flTRkRcG+JFQdJB1HbuToG4T0dJMtGf1Q
w6eGvTDB6BxSfgEy/M1Vcuo+0eIE470BjkQuCaejSWR16mWnvDGHU+dkoGkKbL6h
mGF/1rUuznCsFoWag0FASq7AyRTu4A==
=QgMm
-----END PGP SIGNATURE-----

--Sig_/=NvWPYFzAhMvBTG6bLp1PJu--
