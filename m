Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A805B75BA43
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 00:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjGTWGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 18:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGTWGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 18:06:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96755B3;
        Thu, 20 Jul 2023 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689890790;
        bh=8PjLe55C10eFLpdIOnx+lNPejBKkr1eSfY6bH407UWU=;
        h=Date:From:To:Cc:Subject:From;
        b=tO1oUVrIrpYaXvEgtGv83tj0ssuOTJJOTpP16CA/pbAbxFpqVUlBplZLVSDGPbQNP
         lpgHDzWktYCFlqso4dAjqDh71L8h1xYEh+qDQDsJMIZNYEMzVET2fn+XbZ0W3elA/G
         lsTotNvmwyErMVVZJdW9f7nmwIqCr5QvTrjj0wwxZLGedG7TSZmksY69+JVnd5lagg
         IMwb3VoJf5KhIjyZMNghC5/VoGpak3myXRYHew5nK4APlQmEMCg3s418TgZ4GiuAB8
         Rk23KjcuhonGR97GaHZ9/J2+y7fqL1bHk3i+SQE4mJsGuzhyX6Aay65mCYomOmRy5/
         09+TrU05M35GQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R6Rbp3knsz4wqW;
        Fri, 21 Jul 2023 08:06:30 +1000 (AEST)
Date:   Fri, 21 Jul 2023 08:06:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Teigland <teigland@redhat.com>
Cc:     Alexander Aring <aahringo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the dlm tree
Message-ID: <20230721080618.0dcdd503@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I+h4JHv=bn+1YA26S+wPJ9m";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I+h4JHv=bn+1YA26S+wPJ9m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  32b62ba6dcbe ("fs: dlm: fix F_CANCELLK to cancel pending request")
  09abc5f6f348 ("fs: dlm: allow to F_SETLKW getting interrupted")
  33c63abadcf6 ("fs: dlm: remove twice newline")

are missing a Signed-off-by from their author.

--=20
Cheers,
Stephen Rothwell

--Sig_/I+h4JHv=bn+1YA26S+wPJ9m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS5r9oACgkQAVBC80lX
0Gzyrwf/Zpo4yvLGDMTR5FPHJ9k8dz10RpTdlSiZ1KiTLaCY8jNc3QfKVHiiD1Hh
Za1Tdxm4oB5uFeOa0MtU/XzsZxIsSHtpi5z+XwPWeL6JEQnzNLet/y71R99Iut1A
rfOwoJMNY5Yd6P2ppRO5L32RsTSBoBLOufDUsFTigLdKRMQcrjocSxuN8gOX2BGg
VSG6AW2M/0qAuQwE4XkNGHpcJXjHflvtoUzKn1Ff8VC3wE5/uvkkC/ApZZoc76ig
UNxJk9L5DviNWEYuhvAv4Pti4Zkqghs/IowyhA62Ob9GvhciXoY9BoPKWkb7NfTP
ZvAzxgL05m/6dRpTWGji5ajs2g9QdA==
=h6iw
-----END PGP SIGNATURE-----

--Sig_/I+h4JHv=bn+1YA26S+wPJ9m--
