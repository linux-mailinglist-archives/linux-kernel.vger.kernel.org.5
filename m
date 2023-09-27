Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD5E7AF963
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjI0EaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 00:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjI0E3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:29:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53BF769A;
        Tue, 26 Sep 2023 19:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695781966;
        bh=Y1SdRVKhMsKiJoLM+trJuNnLP2IbtcnaCJML1/uaGMQ=;
        h=Date:From:To:Cc:Subject:From;
        b=TmA+12ZtmMF1Ni7lYGU1Pko5RQQTUAYLGkWDzSbonD/q9E7crtt4YVEKu08w9vK36
         dhRXCh2HZXLAuRRTzARmHvLe57+YPza5r7bKQoIjf3Ee4WxsLAruBKraakN7wxO/fP
         yB1wiML/q0fVUm0PvQAI4dv6z8GJ0rRbuSbzI4rRIaxDn2B9tH6e2ZxvGnRHniSMJi
         w0h1oH2kNDss+k3JihTnvjNNTEbfwBAp7dSDThA+cynohGJuYqxCkXyMhLxxF4/LRq
         TExK2MGYdmFTKVZOGx0DPncaog1T27YjMSx0NI6RfFBtKkHZ984ho5GJra009SdTrs
         VnbtXcKhP3LIw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RwLHd4bDyz4x5k;
        Wed, 27 Sep 2023 12:32:45 +1000 (AEST)
Date:   Wed, 27 Sep 2023 12:32:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Yu Liao <liaoyu15@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the nvdimm tree
Message-ID: <20230927123243.358cda9f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KUde7j0zW3MI/+1q7_vPTPM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KUde7j0zW3MI/+1q7_vPTPM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the nvdimm-fixes tree as a different
commit (but the same patch):

  512747bbf0c7 ("ACPI: NFIT: Fix incorrect calculation of idt size")

This is commit

  33908660e814 ("ACPI: NFIT: Fix incorrect calculation of idt size")

in the nvdimm-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/KUde7j0zW3MI/+1q7_vPTPM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUTlEsACgkQAVBC80lX
0Gy1Vwf+MYk0Epa0gkI0Fvhho9Qb7xSOUYHD7DRCs/Z1yCmfsBrcPof514/9sMY2
6k9lRiM3BXaLEakqhd3/SrqIWop+JIdpJSRWlpznZUSKA5QSg5T8+TjKrAsGFi3y
+vi2oZMFzkr//OpTdSSn4sysUZKIKHdfuk1hKNZo0nXwgFgupvKFTos+lldDwUfd
nCgEzxfmG2D47ZN/6yWzWnYnfUNVUrUxjBWPQpOYWXmtt59MQLPl6Fdsx4T2xP3P
7E86/MfmphOkC/ESv7arr0sOaOhA8ABB9C7IARc4SXynEc6ifd8JYOS8teg+XlJ5
NJrG+tXKFUV7jttQyQsIOZ7JxY6dOg==
=L0lK
-----END PGP SIGNATURE-----

--Sig_/KUde7j0zW3MI/+1q7_vPTPM--
