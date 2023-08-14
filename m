Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D895F77C3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjHNWzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjHNWzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:55:23 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8671D13E;
        Mon, 14 Aug 2023 15:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692053721;
        bh=/2TXzPKogfozyO6tkfeqY3U4+RI9I/hzF/SrnDB6IL0=;
        h=Date:From:To:Cc:Subject:From;
        b=pVDuaFRST0fVzXZ+C0HafCnAPpe5dxbv7xxKO2j6PEZujLlr5IVjO4gd1Px55X8Jy
         03zJyBlwL07iYcv574JEOlzEaZgylBjvaxB0pbpFD1NmUUM0SkJQwetVPQwtaQoiVW
         AWGw6jm9zLEjm8wspU2Fh89sy6JEmjo0tL6vx5gAMpdAVY/FK2LNQ2BiOtsLsc9VjS
         Wc89x5ccRXSoh4N8oZyrDP7SL6AJh+YEYFCGIZS1/SlQjX7mcWdadll0hTeN6gH4ct
         twXLQjV8e2t6anZE6c+YxeZxZ5m+BJik4RwHdJnqpt8OCIsPgR45OOr2lkrVZFXDKT
         n7BHSfU1Bkjtw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPqVd1Xtjz4wb5;
        Tue, 15 Aug 2023 08:55:21 +1000 (AEST)
Date:   Tue, 15 Aug 2023 08:55:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the gfs2 tree
Message-ID: <20230815085520.6f87c5d6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/k3=rN=LLs5g1hj.ZT+9u162";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k3=rN=LLs5g1hj.ZT+9u162
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  fa6629ae1481 ("gfs2: prevent gfs2_logd from spinning")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/k3=rN=LLs5g1hj.ZT+9u162
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTasNgACgkQAVBC80lX
0GwUtwf9FQFvJv/4owkxkCh9bYBz9xsTEcVBCVGZSVVRshRYXp/1nDUFig4O+cLv
jt8q41B22JGR6/WENgi6VTYlIk/HyRkM+9qsGIwhSaTo+j8Bts6E1lflvh+hlXwL
1YLNe1NNdDJ2Y8sQnlV/zdgcDtqjmoyK8UDFPuMAPArzEbowIFVB6DezRF5S/BPH
k8+gPp7+j1BNscoCkkpRA8eWzNeSg8i+JhQnwcBpyUuXpt89akCvTbs0g47LlINq
cv+4Uh1fD1Og3lwLdollRE8R0CNQd4nbfq2ofanSpSMXPk5gPoMf0OfN72S9WdbQ
8kJV3bBKXe5v/bJqrkZlQ0TrrtGChQ==
=KGS4
-----END PGP SIGNATURE-----

--Sig_/k3=rN=LLs5g1hj.ZT+9u162--
