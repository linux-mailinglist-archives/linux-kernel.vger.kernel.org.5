Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1657A5529
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjIRVlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjIRVlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:41:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1004A10F;
        Mon, 18 Sep 2023 14:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695073296;
        bh=Vb4eL9CHfhRBJsfJ0QsA45UJHbqU+38DlbUmYxZcS5Q=;
        h=Date:From:To:Cc:Subject:From;
        b=salWIiGxClYMhB8OJT8bjACqDFCVOL8DX6OpgycRUWdkNdnuyouIHGg9V1rOEqLdA
         lB3Pkfd/pKTEriamMfKah8I2SvP0jCeHKPAcJ+Wk84Ez9/9tBimh10qf38FNqienPo
         kVXS6uR7LRze4UN72z8vU/z3+u/A7UGooBJqVUKJfmZKYf85jajrpO9Ug9R3ksByRH
         tfccSwmEEe2IN210tHsKVDFScaVEQm2psATwDAoqOvnEzAufbEhty/gvZ3U4En6EL6
         i49BqqrUW6pIo+ppvxUWt9wQAk1cijwhr2KsOlBnHImgnHxEpSo0WOzwQO5Erz0vdp
         VVLJPsOkjr2jQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RqJCN1dznz4wd0;
        Tue, 19 Sep 2023 07:41:36 +1000 (AEST)
Date:   Tue, 19 Sep 2023 07:41:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Xen Devel <xen-devel@lists.xenproject.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the xen-tip tree
Message-ID: <20230919074135.3e9b06b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+kF1L/j/yNt5jxoz.jnIOrC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+kF1L/j/yNt5jxoz.jnIOrC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  603392995417 ("x86/paravirt: Fix tlb_remove_table function callback proto=
type warning")

This is commit

  fcce1c6cb156 ("x86/paravirt: Fix tlb_remove_table function callback proto=
type warning")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/+kF1L/j/yNt5jxoz.jnIOrC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUIxA8ACgkQAVBC80lX
0GympAgAm1mO57c/f5RDekcV0a/MNqPpNNpvhkHZqMAezFHrKmY0STuctRsiqv03
Jd55r/qxXVrpmBPC37dawEn+bF9nJb+KgF/K9pVFFwu7AXqjYUEgbMyGu5Ahe3c5
pksjE9fVVfLIzHqj1EhQOwUngZcKUoVBEoaFzifmbj4yyrYWZOuksAtNKWqgpiTc
F4LYqL8TjPHI4qifm8wxCZCmQZ0FlmpJAOJYC+StZmjLG6WVoMU0PVg6x14zODfk
e6KnNC7f25z2JniTiDlziDpaFgnNqbh1dHdBpitZ2HvqoAscQVQaA/SPZzGQvTfh
MqyoXR3BgGQmUXWipC6tdOGHh0RxDg==
=eOiP
-----END PGP SIGNATURE-----

--Sig_/+kF1L/j/yNt5jxoz.jnIOrC--
