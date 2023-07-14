Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EE9754217
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbjGNSBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbjGNSBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:01:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3B43A81;
        Fri, 14 Jul 2023 11:01:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DD0761DB5;
        Fri, 14 Jul 2023 17:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD982C433C7;
        Fri, 14 Jul 2023 17:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689357553;
        bh=s1el2zzcSXw96fILtVV/pU2QXloiost9bfy5t32Iex0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ao86t8MZvEKBX/XgxW1G3+uLkvz2sj3PdGXfpGTEa/GrPIW3mGqzpkGOF7eCF1vWx
         0VimLdhjIb3Me1NyirFerV8HXvZVoA1tFC1CrsJF7VEcHjDEhwLj3Kvvfr0eOR2Dqi
         oTY15VDUOV37uBg3EcrTug8xNql0jrwRjvrqCIhqRV9kt2yc5HAnU9df6e3vu3IlYK
         BYQvqiVuYABgO++OH8ym20BY/AxIXPNmHLFalcOZtZqnX0DgNUljn9UIIWdL/7Ohmv
         OnGiB8DHRlzrrmRIGSZSortxasXbis/ID18ere56edFKZOSUqj78OOiXbXLMGmPZEI
         zH1eJC4Ns8nPA==
Date:   Fri, 14 Jul 2023 18:59:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>, corbet@lwn.net,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH docs] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <a7d0381c-c99e-4dba-9156-cc07a86bdc39@sirena.org.uk>
References: <20230713223432.1501133-1-kuba@kernel.org>
 <f61a12c6-9587-9cb4-122e-dc3a74e58bd1@leemhuis.info>
 <20230714102218.687ee2ea@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KVi/BTK8+Otxl5a/"
Content-Disposition: inline
In-Reply-To: <20230714102218.687ee2ea@kernel.org>
X-Cookie: Preserve the old, but know the new.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KVi/BTK8+Otxl5a/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 10:22:18AM -0700, Jakub Kicinski wrote:
> On Fri, 14 Jul 2023 08:24:38 +0200 Thorsten Leemhuis wrote:

> > Also: It's totally normal that commercial vendor contribute basic
> > drivers with known problems and missing features (some of which will
> > never be implemented). The latter will be considered a "bug" for quite a
> > few users that read this. Those suddenly thus might becomes something
> > they now "must" fix, which leads to questions: how fast? just in
> > mainline, or in stable, too?

> If we try to fend off anyone who doesn't understand common meaning=20
> of words the document will be very long and painful to read.

That's true, but "bug" is one of those things where there is a frequent
disconnect on definitions, and when coupled with the must respond bit I
can see things going wrong.

--KVi/BTK8+Otxl5a/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSxjOsACgkQJNaLcl1U
h9ANGQf/Uj59jbEqoKoJTQol5fPW0lVUi1Wk7isseKJDDsElbkiIwrx3FQx3sGjX
T2OjnR9KfvcAENLz7nrC0amKje5ZclDI+70Jz2FRfdVRwVVWh937vG/JnS2Ciy1l
avneg5pyeMDLJaaF8X9V6IDRv4HKZII1YyEOAM9K6o42ZJVuTIMs+VQqowgy1tJN
vGDOCS4GZNmPCSHVGtdfLulsH3D9NilRMXunGFzGdudvDacm+t5b14V/n0tSD0/D
62Jf/C5LTIo5SadXVWakl80KYGnG+AmUHwYa4JHWktw1VGY33ywrhFsa/oRwva/S
ZYsFRsXYI3ly2G3UiN1JpuB6MzAXMg==
=7c+u
-----END PGP SIGNATURE-----

--KVi/BTK8+Otxl5a/--
