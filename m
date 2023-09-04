Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0B8791F21
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 23:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbjIDV7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 17:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIDV7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 17:59:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08776CC6;
        Mon,  4 Sep 2023 14:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693864770;
        bh=C1+z3pUjKmEKsI0HQM+PmDHkjrqytHjuO0JZcZwOBsY=;
        h=Date:From:To:Cc:Subject:From;
        b=r/gXzxkfI+DBjGTrILLxO44cLOUSOkRdjKaNwhYsPaYczIZNpZgyp67KAPfmKOBtY
         XQwlnK66J3xCPZ35+7fhoDQsZSGZM+MbW7VrAVblFF2NLqnUFV2KymZ9QsipUogu59
         FD+dhP2Ywlk/rCnMPPNqQZTALHstVKChSMZLhYpDyS3S+9eJiYULm3KtqnYMEEsDPu
         hFNE+OC/GIy8BKgVGQWHFyXLILqWIuQtbczN8c6bNIJWYpcwBJr/tFz6mi3oGpdUyI
         1tUo1HK9IaFmGkKBFobFM5rWM/L8L1zLwPXOFkxlJLWH77ypcXxdBkIUENyNAvXc65
         9PRmuCVLYtSVQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfjGV4qwzz4wb1;
        Tue,  5 Sep 2023 07:59:30 +1000 (AEST)
Date:   Tue, 5 Sep 2023 07:59:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     William Breathitt Gray <wbg@kernel.org>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the counter-next tree
Message-ID: <20230905075929.79f4c897@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/q/q=v89rJjEmjRT+UOP3KKJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/q/q=v89rJjEmjRT+UOP3KKJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  b482cccdd3ac ("counter: rz-mtu3-cnt: Reorder locking sequence for consist=
ency")
  778924436d30 ("Documentation: ABI: sysfs-bus-counter: Fix indentation")
  091053abd32c ("counter: Declare counter_priv() to be const")
  b71596bd272d ("counter: Explicitly include correct DT includes")

These are commits

  39266b642ccd ("counter: rz-mtu3-cnt: Reorder locking sequence for consist=
ency")
  3a91388002af ("Documentation: ABI: sysfs-bus-counter: Fix indentation")
  83bc0982bf25 ("counter: Declare counter_priv() to be const")
  7aadfd0eae31 ("counter: Explicitly include correct DT includes")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/q/q=v89rJjEmjRT+UOP3KKJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT2U0EACgkQAVBC80lX
0Gw3RAf/VL2xwt+yryBZuRHN8nUYGZcja7kRxCSiBhdnQnNsQQKAj8TffO15AvaW
vEhWAB5nN0yKUCGKLDMfGsW4pwT245tnRUKfMCX2CEm7VkGgAJxNQAk30cxYaLHq
V2RENkpPiJB3ZkMhoSWMhJLLDADL1sG8v6xy/ZvKtmsd51hlA3L9b1+krO0j535h
bEQqpj8U/VqQm1YF5FXv5qXZ2ARcGAHEa/hSz2FssnUa56Zw49q2Iv1Lv17FAqRE
LmIqmHzsrWGjEs1a4hHwxA9+nA/LTkxteyxRnqiGW6C2mTgFrDaRVQPnC/fVpLvT
AI0QVrZht8OPEm/r53plP+5EJPnQsA==
=RBbz
-----END PGP SIGNATURE-----

--Sig_/q/q=v89rJjEmjRT+UOP3KKJ--
