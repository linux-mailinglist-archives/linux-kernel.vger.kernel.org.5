Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7AA806522
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjLFCij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjLFCii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:38:38 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6BA183;
        Tue,  5 Dec 2023 18:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701830323;
        bh=jyjavBbFUwkDjLn/BtciNJOtogWo8sCatGx7IAFjGyc=;
        h=Date:From:To:Cc:Subject:From;
        b=tCvhPNP7HEoWS6rPgOc88V+Ca2rtlnJ5WTJH61+CZW5ABPL/z6ewHrNmMnZiwtnxw
         DOoQ/jXgeR5nZn/iDSIB8WzjDc8ZBI0EKwceaBDHsjVnoUJvxGH8GZ76p5OT9nzV7Y
         45N2F1ZKls6lfkI1+49sp0z16R/+LH6hjLbp1MppvGMOHfWaxX/+NUfx/hl6t2oQvm
         9d00CJty8HmY81mMApecfZELeq8dv8m8BuuaTu4+/Gqk2/3v7debOpvou9aJqmkFfp
         ybTbIXgTuNNt8zjKSHxmXWAa8A2b+KWhDZcUc7+mKP7L1WeQ2zMRSltVg3Gd1B9lhV
         v+yCZ+keUWIhg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SlM6C2fRdz4wcJ;
        Wed,  6 Dec 2023 13:38:42 +1100 (AEDT)
Date:   Wed, 6 Dec 2023 13:38:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the vfs tree
Message-ID: <20231206133842.104276c7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8d/a555COXW92pP0U_VyfpT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8d/a555COXW92pP0U_VyfpT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the bcachefs tree as different
commits (but the same patches):

  bbe6a7c899e7 ("bch2_ioctl_subvolume_destroy(): fix locking")
  74d016ecc1a7 ("new helper: user_path_locked_at()")

These are commits

  b3057fdbaa42 ("bch2_ioctl_subvolume_destroy(): fix locking")
  6d93d94d56e4 ("new helper: user_path_locked_at()")

in the bcachefs tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/8d/a555COXW92pP0U_VyfpT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVv3rIACgkQAVBC80lX
0GxNswgAljhVwu6CM1jteFx9i2LrM5BEDb48gxNXy+P7ruz/MMldmG8bW0INN7fh
Vreae3mmHUwBwaOKH9+OQ/6UEm4Ijwxn5fiXr4Jown1rJZAwilbD+p1AyCuHefu+
xAQbJsBkVusPKSMKdt8Lh21xDJInVRgEmmLCo+eVQ8QycFEnGF9Br5DM7j2VXrVG
dFC7kT/75FuYbuHrqFCYj9pwTeTh9FtGPdvDp83GPOg/Ux66/VgbCLZGkT4c4Gt1
k2n4S7cjuaxn9hQfcglVC4sNtwnDPk0fN9vleb91B/ywzluX1/k0jea37ObmE+5I
ETcsQTdz+6b0cVWI9k3pwmqO+c3F2Q==
=SQvK
-----END PGP SIGNATURE-----

--Sig_/8d/a555COXW92pP0U_VyfpT--
