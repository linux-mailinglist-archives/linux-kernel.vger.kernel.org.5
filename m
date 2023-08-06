Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4CA77173D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 01:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjHFXNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 19:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHFXNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 19:13:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7700FF4;
        Sun,  6 Aug 2023 16:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691363584;
        bh=i+xTiYkx1aQz7cVtfX+6mYvnuL3zuwClbhnnV98fAV0=;
        h=Date:From:To:Cc:Subject:From;
        b=j5PVhRUvycfiKhxaOGhGI6ZYjttyVK28iNq4tMrc98p16VNokQZLrPDDIxslk/sRO
         3Yht/pjn9tpo8n5H9QUDvBixYgwhtEzOF0weeLVOeGae3r6Ld1hTOeEm9fiF3W/K0G
         uMrYnYBKxSBDy9SCXyPFHYDw0ewWzyFnrMfVT5sl3Xh8hf4kTF5rg3mDhoCVdop7pE
         ueiMPatDSQEVmRtKLXr+Vfkxt1xlPNjik5XpzqsLLvfHmX93P/07rGDAv3Xvn1Al6Y
         YbYWFEj89dy5MqlKP3TiWhKrcvzv91Wkzr8tuBqFnGspgE0Il1MDpkcAiOrPUmzk8y
         xwH0SxNPaKl7A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RJwGm0ZyYz4wxQ;
        Mon,  7 Aug 2023 09:13:04 +1000 (AEST)
Date:   Mon, 7 Aug 2023 09:13:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the rust tree
Message-ID: <20230807091302.6370fc50@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/41G.EhXo3Ams0Uz5mOiebmy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/41G.EhXo3Ams0Uz5mOiebmy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  10a6032595f4 ("rust: allocator: Prevent mis-aligned allocation")

This is commit

  b3d8aa84bbfe ("rust: allocator: Prevent mis-aligned allocation")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/41G.EhXo3Ams0Uz5mOiebmy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTQKP8ACgkQAVBC80lX
0Gwu0wf9Hf3quLaHkwcPYiF3LZ+r2UJW0XidGBzbndqFa00vvNcT95yBJH37Tqig
tremY2mHRDJNzLxNgET/Y7MFUC4U+fH54Wn4yCsOn4P7erdDSh8KMny1tKCVVgW1
ZVUxOH+n9sU+Uk2iiLIz4buTDmK0hNClwZ4YU1b1CJy9GIuTnWwlJnuTN+Dlm0jv
ReZ/wL5jjxM/hEhbF1m+NwWCZOdN8t5c21sXVPgkdfJeT36sSagSI5UsRqcu+Hcp
2SFYezDTmm1RbSAoaZCG4/JzSYQxaCmQy/3HtLycc+J5EqLHWh73oGCaeKnWFbfm
jVJAFRrHvujDMgSQcRHn6ceDLHY4YQ==
=xPce
-----END PGP SIGNATURE-----

--Sig_/41G.EhXo3Ams0Uz5mOiebmy--
