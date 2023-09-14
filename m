Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0577A11FB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjINXow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjINXov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:44:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A731FE8;
        Thu, 14 Sep 2023 16:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694735086;
        bh=pT5UrpfCMVGRXSACPqeP/Xvjp5b4jCyTouDPdHdi6Qk=;
        h=Date:From:To:Cc:Subject:From;
        b=VuCzKzy0jrXMkEpPumqfYzDZTL1fdYBnc//buMNSmEb4dpWfEjIWfpqgN2gueC9mf
         kElN6sjxNyH+U3vZX7oNX2MsFJdfsb6VbOtasMQ3LCwidgIkMt2So/LaROspzR01Ft
         /eEXBdE8QD6gXA61vaA3ZwFXIa/ImqTmrn6Bs1UNf9RnR7CAGcx9YzVppnZIb3lXa3
         pjlOF2APjRhRcQ6CyDqc32pGK6w88c2tE+cXzqA8xFWMfnwzRDTc9/DJw/bRRyvWAv
         uPEM6bSwsMRMFsEZf5L2iOw/j5dRt10c2sLz0RgF0J34ldX0/wfyDG1gHca60O7AkG
         XXIi3AwGn9tcw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rmv7L01Pjz4wxh;
        Fri, 15 Sep 2023 09:44:45 +1000 (AEST)
Date:   Fri, 15 Sep 2023 09:44:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the v4l-dvb-next tree
Message-ID: <20230915094444.266b938f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2SvlkEtILSp84/vVuujrrum";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2SvlkEtILSp84/vVuujrrum
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in v4l-dvb-fixes tree as different
commits (but the same patches):

  0835b195d034 ("media: ivsc: Depend on VIDEO_DEV")
  99de9266e8ef ("media: uvcvideo: Fix OOB read")
  14f36ff244d8 ("media: via: Use correct dependency for camera sensor drive=
rs")
  a498bdab9b61 ("media: v4l: Use correct dependency for camera sensor drive=
rs")
  cb655c1231ca ("media: pci: ivsc: Select build dependencies")

--=20
Cheers,
Stephen Rothwell

--Sig_/2SvlkEtILSp84/vVuujrrum
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUDmu0ACgkQAVBC80lX
0GxBsQf+KKsw31ig7lz+Uq72bazGEDaEs7U1uo87w5dPpfwPgFNLBopQzS9KwveD
TD+ZJ81/1+GkvBTmoERPWqUYQnwekFJM7RTwztsxwg9VWzf8/KYgZLLDA7TCoT9v
/CtZNcsh61ICw3oZ28C7EB1fiJlmZypebefjengQCUvLuE6PAsZS4/G3xVCHePM+
LCpxbhDKPq86Dm8A2QAOBA2YAqY3lCuMBFcYiU2KSgDO+cCpsJGCWlSsy5VCBjLZ
DhL5+uSwfTqJHGIWEqzeq7I6FMH6+YptbVumhvvxOCETcOZjavYsQoTA3/+jMZG8
JKHuvvtkwQD/xqDBmkFABDt1NC3ufw==
=rhRN
-----END PGP SIGNATURE-----

--Sig_/2SvlkEtILSp84/vVuujrrum--
