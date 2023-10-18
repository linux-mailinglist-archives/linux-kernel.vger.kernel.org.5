Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23A47CEB9F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjJRXMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJRXMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:12:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A01111;
        Wed, 18 Oct 2023 16:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697670753;
        bh=kKsyQpft04RQze8CG9JFYl+8mBkr+XGcMFgLwps/ydI=;
        h=Date:From:To:Cc:Subject:From;
        b=sa1e8/2iT0ckwdaxHEFJPA7a8e69IugiVVjsLQFc37Sruqyv/3R3nFDat5XxZiJdA
         eF05n0yqXu293zDrFoi41uX+7fj7YBH+OPwlm16jmPHcBcqWu6M7C3O3L6LH/WApYt
         AEi2yjk1oV8xw0qXeJjbH3s6erSQMy6bVrN7OnHaVqmhRBcWBdkTW1MmHsJdUOFn+J
         AN1cz/oJbPRHhasNcs/6AHzkm9Vg63KDcSw2gaeuh7WoeQETgR/EKXSDP+Jv5PQq3C
         PBETyiEBT+MR3/7hBVOsGKwuVIOfIToh6ZS7371NyrsQ2x+Q9+bYJiwhCf2tAf+r34
         YFTxhYdyrTN+g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9mpT29rdz4xbC;
        Thu, 19 Oct 2023 10:12:33 +1100 (AEDT)
Date:   Thu, 19 Oct 2023 10:12:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the vfs-brauner tree
Message-ID: <20231019101231.174f1124@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4o.gQIoQ=ueDMIi.dhPMJDu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4o.gQIoQ=ueDMIi.dhPMJDu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the overlayfs tree as different
commits (but the same patches):

  b8a42d441199 ("fs: export mnt_{get,put}_write_access() to modules")
  5363f9742437 ("fs: rename __mnt_{want,drop}_write*() helpers")

These are commits

  ddf9e2ff67a9 ("fs: export mnt_{get,put}_write_access() to modules")
  3e15dcf77b23 ("fs: rename __mnt_{want,drop}_write*() helpers")

in the overlayfs tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/4o.gQIoQ=ueDMIi.dhPMJDu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUwZl8ACgkQAVBC80lX
0GzX9wf/WiNcipd+0/ZKSOw/OIBVloa/DkVNouGzdtURBZt2pEOnhA+M1wQJoTxZ
UsFjBqgeWhAVcWjTWnqGLq6IvmOpr4rfexMGCSoAMlPK6aBIMxyHbmA6fPUkBwSN
b3c03FhgTM8QVTNo8FAYS3WfVhsjJoyxqsjC4DY3jto5SEp3qv+sQnncyh2KpOz6
SGeouCZ28rBdY7++62gV+oTWTwx++P667A5uXxm5LA+R0YxnD4ud72uTG8RQ281H
cc8EJrLQTY7G5QM47Cy0cYumg+WvGoyOVhMSFMDNAp9tYLElU6MFspxbMFjqztun
MhJOqyevbkPhZ53WmKnsPWh+e5paJg==
=SZR2
-----END PGP SIGNATURE-----

--Sig_/4o.gQIoQ=ueDMIi.dhPMJDu--
