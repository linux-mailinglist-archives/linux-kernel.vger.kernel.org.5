Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116A878A3D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 03:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjH1BK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 21:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjH1BK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 21:10:28 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774B2AA;
        Sun, 27 Aug 2023 18:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693185020;
        bh=hiT5q+hGC2lwo08ERy44QxB5Jj+2K1z0AdLVE/fhAc0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ARoxuzWq2dpAxnho9INpeo+/DFKRPgZNu8cq/w5Gpgxnk0hn7O/b9PuXhNGzYT8Fg
         yC5QTTsrWoFAjA1unjbu1oxiVuNYFBuesMpG1lqgHNJOY1qy++kB+Kv6OyytmBYfQx
         GylSRcWBJ6hqNbWkJ3f46xXUJ7khbbIV6chjh/B9+bZpXTvnnuA/Q9+snV/kg7ovx+
         OSanCCB1IBiWixJtUzLK5RTdZn3akj5Px7GDUw5nvyne3rULb6flSGRj4uvh9Fh4pY
         dwAUPQTzEJHmpcz7sikWLmET4PmbKOMTFiewuUiZLh5L5AS5T2Zy2i1J9AK6Y07rUc
         ol4qYnWUXU3Ag==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RYstN5CYHz4wd0;
        Mon, 28 Aug 2023 11:10:20 +1000 (AEST)
Date:   Mon, 28 Aug 2023 11:10:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] s390 updates for 6.6 merge window
Message-ID: <20230828111018.42b6733d@canb.auug.org.au>
In-Reply-To: <20230828094228.2381967f@canb.auug.org.au>
References: <20230827203058.5559-A-hca@linux.ibm.com>
        <20230827203401.5559-B-hca@linux.ibm.com>
        <20230828094228.2381967f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z_5TIPutUKvAAZMmpk216i1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z_5TIPutUKvAAZMmpk216i1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 28 Aug 2023 09:42:28 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
>> Something weird there.  I just see the arch/s390/Kconfig part (I use
> git diff-tree <merge commit>).  What did you merge?

Actually I use "git diff-tree --cc <merge commit>"

--=20
Cheers,
Stephen Rothwell

--Sig_/Z_5TIPutUKvAAZMmpk216i1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTr8/oACgkQAVBC80lX
0GyQEAf/f+C/omFbtznRGxh00Gg5LqIfbKwJPx9WxoEAOVzTiJBb/8StxEdecUwD
J0P/GNQ7pxyVi38KbLGUDxSf74MioIM2t/W1xf+ewIvzoC6P0II6cwrz5Fy8EC79
pFthdfJ58jKFkhv8hoKY4oLnmOphb8PmpOebvsr1we9ed4uDVWzOQkn8iZYBV9Vk
/BTm6Pl/BUNmYg+Znws6EB8rB0Jrdzghujd0OhcNTinqTWlUa0QT3v1nD+6fHqVq
T28TuTmdTWD7Ys2KUmPDIMVUYeIL/GMMVsHz4xNQlq1ezCnVKF5OvqPOUq8GtHsT
ORhYdypX6R3w4noPO5+AN3xTtuMO1Q==
=iJOD
-----END PGP SIGNATURE-----

--Sig_/Z_5TIPutUKvAAZMmpk216i1--
