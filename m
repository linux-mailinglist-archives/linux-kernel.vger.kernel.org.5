Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1407CF16A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjJSHhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbjJSHgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:36:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35EAB6;
        Thu, 19 Oct 2023 00:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697701001;
        bh=jXv0UIVoUP2h526W9yTnCr9WSMkBvRxHPsVCrjDu82E=;
        h=Date:From:To:Cc:Subject:From;
        b=EJLuxtDwALc+/Ag7/j6jfCXOJToQYGzZQDySu41yN8xAWGM+darxHEUY5foqi2aOK
         AIkT8k0eSwPE6zH5KD+KaLlRZcxdXCjSX5QAKLRN0qnag4XFkmXvjhCVkCyRUzHHid
         7aKWbULjveI5UoUNA/+RKtfc9L7rAN8GhzJQNffGqTMqjKHSjmaF+XrNUZW5NCrUW6
         du8Xc77z9vUmYTtMrYsojJ/WMPR6VixPzJ/Aw1IvHbgl4RmX/UsbWjlxgTaeLUCOfL
         okKyjKIt/3Xys9Y+mlTeGZDMwMyVEgCUl1AsUzrI6oUgRk9+JHdIXVdj0zBkROOFkZ
         UTAL/mdsHoZ5w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SB009379Gz4xcf;
        Thu, 19 Oct 2023 18:36:40 +1100 (AEDT)
Date:   Thu, 19 Oct 2023 18:36:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the parisc-hd tree
Message-ID: <20231019183640.61e8d5cc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/20fnVh5601iz=GE/pO.bna4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/20fnVh5601iz=GE/pO.bna4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  9baece83a913 ("parisc: Add nop instructions after TLB inserts")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/20fnVh5601iz=GE/pO.bna4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUw3IgACgkQAVBC80lX
0GyqiQgAnoGS6l+yxNTkp78C6USAijEfRYpAJPqOAjargMvD7yByL7GitErPvnMo
QgFKmnWqSu9aF14EBBGoDUNXlQQyFmCU8tqFHX959k7IrU0wi68KzlfazTRkq8p0
Ox9UldGLQJ8CaLfngtebgDO5sCjYo/883e5WpM+ISYYzgk9+zlv7jxKxHUeaxbj6
za03z3uKNdPpXHAWebhZfcd4LcjT88Ww9kOd3WlzrjyFQGDm/4C/uI+eOWb9xteB
WjipntufylYZuFB5AaJ1dOTkdHgxgvBpcA9gZ6NdZr1oXoYJs+88kC50EJ/46Qq5
5lC8g/sbMsePG3UjDsjo5ffO4z301Q==
=66lN
-----END PGP SIGNATURE-----

--Sig_/20fnVh5601iz=GE/pO.bna4--
