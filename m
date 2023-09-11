Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6A079C14E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjILArT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 20:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjILArP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 20:47:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B186739AA;
        Mon, 11 Sep 2023 17:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694473555;
        bh=8/gdBF5cccjdyD906oA3RzLacfEDjVs4+hlPei2Tjs0=;
        h=Date:From:To:Cc:Subject:From;
        b=dWDVXyMF3uRaVd81zNchSJsVpzGBS6jgpWz0biJjaMQwv1F7evbW36P4OA0DgEsNT
         GA2zp/k1jWAtLCRN4V6NFQ2n6I3AFevhg8pjJXkLAZ91SMzBoQhJZjx6GzyXfhm9is
         EK4/FyKhaDU6N5rBO/7qZPVJt+/6HFmPOmZeytdqr1qPdhPcDSM9IUNZPCdaG/2kTT
         2Rr+eurHA5kHReyg114XvKnOtNn/Y8UFWkZFZgmFFiGbvmfq4hNL5eCwy4OpaJO9Jv
         lTsarjEpj+/wMRyf1DnJZxinwkxCyyRBSPzHqLm80Il7MlRqpSiFS1ewvPrJP1ZOxT
         finzHs2zubPcQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rl2Pt6mStz4xGM;
        Tue, 12 Sep 2023 09:05:54 +1000 (AEST)
Date:   Tue, 12 Sep 2023 09:05:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Ana-Maria Cusco <ana-maria.cusco@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the iio tree
Message-ID: <20230912090544.50add67a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HZY.JqajCYHC+Jj5o2sO+oy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HZY.JqajCYHC+Jj5o2sO+oy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  6ed193ca529e ("iio: amplifiers: hmc425a: Add Support HMC540S 4-bit Attenu=
ator")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/HZY.JqajCYHC+Jj5o2sO+oy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT/nUgACgkQAVBC80lX
0GzpYwf8C6p1cZP3GEx72KweB5I6Sorc8zvijoElLtvGQht6Z02caaRY08ef+Ydk
QkAcxdscTtjDwzLPyZ7idTLQw0kS5dBHBcFuwS90rkuLS9NL1/N/wAv6Wku/Ohjx
eGdPgcN7TTbZ9sEZzFrAOdKtn9F7xdWCla5Gt3e113pNHb73EzjdstHjPyex+6sK
E6qywrT540pgvvsCrTnaPgThdX95P6MfHk9kl32yxkXThAKQ9HpWTm710CwIw0WK
yiVMDKX6kuca+J6L0J6hz2Gz6oCg+ng+lV9YDZ+rrIiC0Tii7swNt1qPgkBb7UBs
aeAzvHFAs0GQs3BODtvsXZUlXLXkyw==
=KvnM
-----END PGP SIGNATURE-----

--Sig_/HZY.JqajCYHC+Jj5o2sO+oy--
