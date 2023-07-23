Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4DA75E5A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 00:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGWWqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 18:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjGWWqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 18:46:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1020EE64;
        Sun, 23 Jul 2023 15:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690152358;
        bh=fd0uWTJUuFkwiwoSinEo5CCtAx2AWtX+ND20PMkdHIo=;
        h=Date:From:To:Cc:Subject:From;
        b=suBrWsIupZPqOqlh/L/UtFi2cULrfQMbAhCQWlT+HQu8Iz7mHs+Ud6afwiVHU2mVK
         rX8JRzBx2KkFQb8pOinlWI8bfh1SggCqtNNEIcYR/ifJ2xWX7FbfyGkkfs0vMJsxCA
         5zQOyHkuA48J5Ti0i+ZTyMc5s90ym6451l3cnxrPY8zRrCOhAZkJJNJMJhVaoDrWEz
         4THExw72X3LQ3OEekitLa5gb1GcViS7gWlgCm+Sh2OPmkYuf/lwRYcjO0KN3qs/RoU
         jIPeSb5uV7Fq7HxlwcQrQ1iKf00Su+vXS8i01GnZqIQj4Z413zlmeIAYo+N3MyrZNx
         ZoK59w1xwAhUA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R8JKy3YNkz4wZx;
        Mon, 24 Jul 2023 08:45:58 +1000 (AEST)
Date:   Mon, 24 Jul 2023 08:45:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the file-locks tree
Message-ID: <20230724084557.7ad2f3b4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hD5jhVuYKyHU_p4yUEXUclR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hD5jhVuYKyHU_p4yUEXUclR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  f9d742d5b7e8 ("fs/locks: Fix typo")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/hD5jhVuYKyHU_p4yUEXUclR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS9raUACgkQAVBC80lX
0GyaGAgAjuWG7/Kv97kfeUDoGS//ITH7+MR8Wg+GFSiokThvBauerf7D1Q19+hUm
1ghLiWSeqKsXOp1R003zR548kxwcRvNhqQk5fePHtfM6Y7tOBDTR+aCHevZ0KHaq
B486SWlqzcM2ftjE2zkcBaI/cUUnO6I0m3smMSLQy230WK9u6ATkrXzHi+6T43sq
JbXbwRxSLHKmWqPKIiZvLG0uRBksSZPG/y6xToUSn073bleJ2eI/JEcqj8K6IkFH
mlBmS/PTmJUFWc6oJzsz3Ylp+FUp9OROwqKkTkbokqHIe8UhU+Dv8sPgGFBKXsQH
o4yZMXls57oiGWfQt42kmiav4fWbJQ==
=9IQZ
-----END PGP SIGNATURE-----

--Sig_/hD5jhVuYKyHU_p4yUEXUclR--
