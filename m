Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5503C791F1B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 23:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbjIDVum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 17:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIDVuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 17:50:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BF31B7;
        Mon,  4 Sep 2023 14:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693864234;
        bh=/uSY4R+0Uqu74+S9RPzi1Sqa5+qa6sCk+6usSEh02HU=;
        h=Date:From:To:Cc:Subject:From;
        b=KM4W4BlpU0TGNFyE3zM5PoDc7n+/6YJjL75b66hdPgU2asqgnDYOUt9+f8gKdaAEV
         D85soJbu40AKU8Ye0FuPOaDF0Lr+yBOzKRtjVXYyvq/E3o1jPILqnfGLIv/YdMel/0
         lMAEbIp9ufJo8Qdyh2HrNFDORJ6JZtml3Keb+1YFC4oAnxvEgl4KlZWYdnIBlZcqUT
         EpdM5GweZ7VugejjjIUdmRSTk76zjQb5PJwTq2IxqIof07Zz2k6zGJ4dsD1a8kxZil
         m6VmpkoxM6mAVZ2NLnFIALetk80gbrh2NWA4Ik9VRZ65MG5qNEfykDxuaxS3hZjTYj
         TeiO/1EksN/8A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rfj4B5bBxz4wxN;
        Tue,  5 Sep 2023 07:50:34 +1000 (AEST)
Date:   Tue, 5 Sep 2023 07:50:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the ftrace tree
Message-ID: <20230905075033.0df2b7fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1clXow6U7SjRdYHyOlKQv8F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1clXow6U7SjRdYHyOlKQv8F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  bd96000ba862 ("Documentation: tracing: Update fprobe event example with B=
TF field")

This is commit

  a2439a4c9085 ("Documentation: tracing: Update fprobe event example with B=
TF field")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/1clXow6U7SjRdYHyOlKQv8F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT2USkACgkQAVBC80lX
0GzVTgf/TVV8CcMUNWjQNY1XwKkkTcmeIrkq/dHHrWcEQpS3+SCX9yECUXzr+j3Z
kiNn8/gj++8WTBzKV5RiZuhf4mhiqZtderBt+4JbQyDT3SgC4jGm7mnyQWtG62os
r8YS6w/7J8lAHV1mbEcfziT92m3CeKgijc1cnrmTFXzvboAozh0MjKdNlOaMyciI
mMw+cUPWZAU+n1LunYdmcrWyG+Z8TTAGBTbtUZ7hKLs86UErpIyNBYKnwhwKqwLp
k99LcYyk94kPNA9M71M9/UB2rdUZ2eButTaOMsSDe7CDy4nh6eDDRAA31hlxSO1+
Zy2MONFuzvpzroS+/4CX7ICQdRbCrQ==
=P3sH
-----END PGP SIGNATURE-----

--Sig_/1clXow6U7SjRdYHyOlKQv8F--
