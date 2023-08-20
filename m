Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD9878209B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 00:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjHTWXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 18:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjHTWXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 18:23:05 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A7DA7;
        Sun, 20 Aug 2023 15:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692570181;
        bh=dk7Buz7G+v0jfK1OmllJ171LeoXf2NdIQojna/soeeE=;
        h=Date:From:To:Cc:Subject:From;
        b=m9B3iYUnclQG4PBMkWiWSFmj4+WUkuFQossHk9XW15yYTTjgssKHO8StvlMG2yaay
         DFKka6yGfM5wGfxZRUnpCebeMVOtrmT/XsUe6SBMTWWI+9yiwxpGkUMZ8z3Oug2ML9
         jmxgb3XHUXvtOf34neukpQvlk1ee+n39vo/+GeU7j+V6Wknxx8Isl9vPin4g0pWpnV
         SqD3dn8tSQgLUMN/AuGmchBVIe52J1Cyw1d4bKCNUPLI5St54hWGmGkFjKOCSTO1Jg
         t4eWvkPNizV6zcqkV7afOGWgVQfhRnM3mmb/sq3JablVBgFIBbStbSjvZbFGxe+NC/
         wxAs/BKmm44ng==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RTVVY03prz4wxy;
        Mon, 21 Aug 2023 08:23:00 +1000 (AEST)
Date:   Mon, 21 Aug 2023 08:22:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the block tree
Message-ID: <20230821082259.58d2784c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Kc36gaFyG9JjqE3A_6I_f5E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Kc36gaFyG9JjqE3A_6I_f5E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  f4283bc7e38a ("drivers/rnbd: restore sysfs interface to rnbd-client")

This is commit

  6548fce05803 ("drivers/rnbd: restore sysfs interface to rnbd-client")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Kc36gaFyG9JjqE3A_6I_f5E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTikkMACgkQAVBC80lX
0Gzq0wf/e3GZ+kVbCI7D69e8Fgopu7NA2+4srziRZR5QFAwKAuuB7WlkLPNS03/a
yPZMB+1AWjM5C47PKiA/nB0m+jGTM1Wz9fqxnaKJ+gTBM+qtrGyDu7QBC/naiuGE
itJAiDhi+iMUUNWzOTODXWNqbwvxsesiHpM1VSX5rwqjZ/b9cvTOol1CP67KftVt
2XGhunfG64rdrIdNY9hBEicfCeoY635EgXaMi/IjDolpoWd9PRO7AgGaXUwBVHZX
leMy7FBdSAI0bv7tL3QzIiosA1JjdJ6e7Xc2iLzPyB5iXCDsGvcc0/BuXqN6CqGo
GU6ysJ8qDPbC19PkRGHAaMRjTxrePA==
=JGWf
-----END PGP SIGNATURE-----

--Sig_/Kc36gaFyG9JjqE3A_6I_f5E--
