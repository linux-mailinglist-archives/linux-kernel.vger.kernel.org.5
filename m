Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368D778A2C5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 00:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjH0Wdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 18:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjH0Wdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 18:33:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7887E12E;
        Sun, 27 Aug 2023 15:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693175605;
        bh=3QBP1DDIpyFcZ1ix3DulRa3T8NgSvSy5crVipOmxp14=;
        h=Date:From:To:Cc:Subject:From;
        b=dOeE2i1z+kGKQ3D5+0HmFFr+/B7pwyYQs/YGDWVHCx/mUc19+CbsvCrQaR6bjyiBG
         dRt6QwcNR8Fq9iMPNZRqcf26RJBlFhraV8xroJyozSxm+wOzoKTJZ0L4F9oLpf1m5Y
         4oclmACOPMCFmOPGaebhZzHWtSSEDmT08/d+XjGRN/wfE8yBbk4bbHcMgVAxv0CJjn
         p4x59jfrUkj/HW72frAMnivOvNhFdD1W0A1SurguEBL6bqtV2WChqugPNWawIwr6Ei
         4odA+gF4oyY1gfTZYNNwBPSp4W2y093o5Q7sHWDZELCwEZJemmE5GUfujiVKsR2GLF
         oO1vslIMphBqQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RYpPK1gVZz4wxR;
        Mon, 28 Aug 2023 08:33:25 +1000 (AEST)
Date:   Mon, 28 Aug 2023 08:33:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: the merge window is open
Message-ID: <20230828083321.416d09ad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/c+V3GfxRp.cZv0iN8ZpZQNm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/c+V3GfxRp.cZv0iN8ZpZQNm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Please do *not* include material destined for v6.7 in your linux-next
included branches until *after* v6.6-rc1 has been released.  Also,
do *not* rebase your linu-next included branches onto v6.5.

--=20
Cheers,
Stephen Rothwell

--Sig_/c+V3GfxRp.cZv0iN8ZpZQNm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTrzzEACgkQAVBC80lX
0GzovwgAlfGJ1MZI0gqxHM+UVaNzrcRrBaZozXK5NhtJSJN3VVI9ikqy/wDrn5gK
21v8moB07tK5NtSIKhK/ULPrNCNpKZIBm+B1naBgxygneBDW3uD5q4QIO/FhRlPD
pU2V1K1QzjQKlCblKJOqSFX8xL5Hl+rzjrQbVFLANCMlKeMvDnpan1q0EBwChOYZ
7vfUReI6jB4p+EQGtW5Woj/nJR9bCwQrZ1/l6DQBjE4gy0Lid0viG1l77AwRtbXu
O1jz2zFoZ96tacMbxQBhaLq73X4b77usZ88RgIQpt06Km0Cy7kKahEc/WBRJcxTL
LqJTa6cxy5VNMlFuEP22zZsn/OOMew==
=h1Xs
-----END PGP SIGNATURE-----

--Sig_/c+V3GfxRp.cZv0iN8ZpZQNm--
