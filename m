Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DAF7EA51D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 21:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjKMUzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 15:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKMUzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 15:55:07 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4257D57;
        Mon, 13 Nov 2023 12:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699908902;
        bh=DUv/lJ8qA5cOJasdLl/4KI3Byg7tjhwKBtZ2bXBLmFg=;
        h=Date:From:To:Cc:Subject:From;
        b=sGxdMDUj2J0vpRNJVDPnvsSgiTBkmBqRh4+/XlynAWcJ19+yoybrg5yDfUuqbDes8
         eK06i4hM5r1YHiENbLd1jqNRMFZO56v3x2m4E6oSrwRXlyTMMwIBZOhwCCH3I5KGsg
         ZjM0euA2XgM7oPbYhIfHqhm7xJX1IL13lvLRTQRhnvvsyS3W2d/J0fz2DUo9PRbyV+
         EmlfcFi+/m6sg7pDX4X0wZ4x2F80eLlCrrwKJCGvNuP8mKtZjNC7l7dmJmV5w8tcSM
         fvLLuy0sMjfImv5wKYNYIBECaj6iT90eyVNZzgliBtz0Pl4jZFwwiUjIJy/jCrtUo/
         xU9SrllY3XfHQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SThWp45pYz4wdF;
        Tue, 14 Nov 2023 07:55:02 +1100 (AEDT)
Date:   Tue, 14 Nov 2023 07:55:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Luben Tuikov <ltuikov89@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the drm-misc tree
Message-ID: <20231114075501.61321c29@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Emdt8+VYSRwA677krXtY.UV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Emdt8+VYSRwA677krXtY.UV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  0da611a87021 ("dma-buf: add dma_fence_timestamp helper")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Emdt8+VYSRwA677krXtY.UV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVSjSUACgkQAVBC80lX
0Gwz5Af/YNPogz3RRCNjYLK5dR2VMBX/IRevqIKwxef//cPJ0hDVSYqMmcjQdd7j
sUyw3BvrUkrXC+jPMxAwtsmSC1NoeX0dDC4YrIG2io0RtiYvD6CmX56fkPNcReIf
fSZSHz1FL1qA1gKezWe2xcKP00HILXxUsQQKT0cLaP5j7OvnmRM9oDPccWrgcqyY
9eHNhQ+ylFk8HbNNsvP0ZsgJDO2pS5VDfi3otVnQNhmJRcDipz3apqhyehMLMgDk
4xAsuMVvg99nPQQFtHW7lP3xuY7tHrqYWoOcGdk+Zs2T0afABQ+T05YbZG366sE5
gPhUQ44dm0x/SEBWJjSX9/ZDY1nU4A==
=E4tp
-----END PGP SIGNATURE-----

--Sig_/Emdt8+VYSRwA677krXtY.UV--
