Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217CE7CEA27
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjJRVln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJRVlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:41:42 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3740FEA;
        Wed, 18 Oct 2023 14:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697665296;
        bh=Ahbvv5NLr5ZoGYAFW4IYlHINixN9tjhRDhdzjZ0UU9w=;
        h=Date:From:To:Cc:Subject:From;
        b=DJCvHLtrhyxBlsEZVwV+jbGRhKiPHBAuEQw/8ohXn3GhlvqfBHKWK4tqAG2Pwk/2o
         0NfzyA3z/K19FxM6DbxXQk1JbeWN25/BNIQ001ef++2z9o3wj1TK7p3k2SVAnQTShs
         vsgHI/a0xIVJscDW2mdFOIOUX9EghfeiJ6SBCLPQ2sJezz4IAQt0VHvQM9I6gBFIty
         0cz7NuZqF+f5aS+1cDPAO8NrSRDJ2vqa696pECH8OA2OJlhgsgzvW4zvOvRVBGMhOr
         3fOIhNxajqLY1cVSEU5NphgBXDW26G9jeNAFATCvt7OWmKjGlQ9meb7fOnB9D1OqxT
         BrLZPoQt/51yw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9knX1gJGz4x1x;
        Thu, 19 Oct 2023 08:41:36 +1100 (AEDT)
Date:   Thu, 19 Oct 2023 08:41:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the icc tree
Message-ID: <20231019084134.6d624ee2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bogeaf9pF6_lFA2LG9phEPl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bogeaf9pF6_lFA2LG9phEPl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  452b078d0c09 ("fixup! interconnect: qcom: Fix endianness in an intermedia=
te storage")

is missing a Signed-off-by from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/bogeaf9pF6_lFA2LG9phEPl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUwUQ4ACgkQAVBC80lX
0GzLVgf5ATxhQNfsJQVUklys4niEWzjtfx9Yv+4qKwozjEQysIKFnXSOmSFZf+Kv
hs1CmgrPkUwSwKw8aD2NsDI0SFpB4zvbnRIM0YfeuiR13v7SfQiqcPt0Nw49FrzX
EUNvTb1L6xFaFNdPV4/EhJVK4R6x8cKslxmMy2qnJ4SRR7VUl+4PEcVoX8rhoCfD
xcjVDgwfugi3z0n2C+YowQzFX5bAatmOSXDXPc05UtzwiTQGfzIh6kg6oxPdiPqB
5vq6T9ydAwpCo/Sl23PD3JlODtzs2iD471EGppr/oAdohH/W679MZPtMwAtqIml0
hPgfr/RGqxrKoPRMYsfpzQYew9oOsQ==
=YRfo
-----END PGP SIGNATURE-----

--Sig_/bogeaf9pF6_lFA2LG9phEPl--
