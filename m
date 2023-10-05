Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2627BAE9A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjJEWFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjJEWFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:05:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E44D8;
        Thu,  5 Oct 2023 15:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696543541;
        bh=m0zzF3Wzng+1P63qf/VP88zj6DvxZccxWABSUtvFigc=;
        h=Date:From:To:Cc:Subject:From;
        b=Z3YfKpqaG0dUdHWHOXTXfWZ8f/EH1AqpCiWZQNjObK0TfIdDO/ywU0iQLGVgj7Qh0
         7n7Ig/vKJJ1BdHSgTovOjqIrLTj9T09rZbpNw0evhp0R3RnuA6Wvx1EyhneJ/nlmVj
         aOE/X06Wl8BpAVcOX9aJACbd0Mqzjv0MPlERF7W0X9HvcndJvcAKzaQHzUvyltXD41
         ZJqlfX60kNwtBj3ea+fCBcWYhsFDVEjsWJ9ClSMx1Ni7HDUZQcXpOmmrgUk3jZjNzj
         eSHILe6SKJP9NDORrQxPb7tRjyjbiwrvNgJfAInNnoNAN9RVxSS2nUCNPTJxKgtURx
         M4M/ml8WJBw7g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S1lxK2wJ7z4xG1;
        Fri,  6 Oct 2023 09:05:41 +1100 (AEDT)
Date:   Fri, 6 Oct 2023 09:05:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pci tree
Message-ID: <20231006090540.2ed5f123@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KjJI2+kANB9F5/fqVQ32VMh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KjJI2+kANB9F5/fqVQ32VMh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  3731355b37a3 ("PCI: endpoint: Use IS_ERR_OR_NULL() helper function")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/KjJI2+kANB9F5/fqVQ32VMh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUfMzQACgkQAVBC80lX
0Gx1hwf/X4dA05ipNHygjkWr7yaYLlyMzSfoyDqgHGPBQ5bFT/YbTpJGFZP8IPEa
95IdnSBIDlFRtBJHQKHVxqXYANepXDKMGvy54zeL+zyPSMf7nSPaykvNJOYeRq+E
8UTFIOuYAtzzP8ePlGFOoiRBA/vckkYq1jvHniLZ/yOBJ0gu55FB9L6cJS7o+KNE
+QNlnegG435vzJ190g7PBf2C6RxRYZNRSPHl65xlX9UiR//wCRfKdBU1/OQhyPQA
jE7QutojwdE4ANZwx7Q7uFdXxBusHG/b4LvLUDhhFqqV5S9LKUxZvQ8QdQ877JFy
+tO+DTHuuK4uUY5dcKdQl+PIKzB9CA==
=nCmo
-----END PGP SIGNATURE-----

--Sig_/KjJI2+kANB9F5/fqVQ32VMh--
