Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270C17624C4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGYVtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjGYVtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:49:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D5C1FF0;
        Tue, 25 Jul 2023 14:49:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B907616A3;
        Tue, 25 Jul 2023 21:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85582C433C7;
        Tue, 25 Jul 2023 21:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690321739;
        bh=giBk76Wu2CNxIKQ+bWSMybNrR4Xwdbrb7bfqe39jKGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UTmiPxbosiW2nQ1ygwQpI0u0A4jO+VTQXLpQm8gykr4mpHK3Nbw0GxqExmFvJhKuo
         K7gyCPZSlS34qRrp6CqEERKzht3NHErcrghZVkiqAvTGB5YnBfjKD8TDu64naG0m9+
         0WdQ5D2fH9aiZ+BTkjukoVJeYUlPba/5saeEmpjCOAsqR3mOdVd7nB1nOdM13z4RRk
         a2zClPLVbB77kQa2iQYXWUUkva6q41jzfJKrKzmfPn06MF0U1N/ptqUc5T7KicqYLW
         HttCu5Irc4LxKIo1jgHA2dktF2NeeoDppcsSg5e2rqsipXR6/4h6hFmSxBtDRHsxKL
         RJcaZWEpIopkQ==
Date:   Tue, 25 Jul 2023 22:48:54 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chen Jiahao <chenjiahao16@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, guoren@kernel.org, heiko@sntech.de,
        bjorn@rivosinc.com, alex@ghiti.fr, akpm@linux-foundation.org,
        atishp@rivosinc.com, bhe@redhat.com, thunder.leizhen@huawei.com,
        horms@kernel.org
Subject: Re: [PATCH -next v8 0/2] support allocating crashkernel above 4G
 explicitly on riscv
Message-ID: <20230725-judiciary-auction-ef50be622175@spud>
References: <20230725214413.2488159-1-chenjiahao16@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tppZMEkMOmCgNS1D"
Content-Disposition: inline
In-Reply-To: <20230725214413.2488159-1-chenjiahao16@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tppZMEkMOmCgNS1D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey,

Your $subject says -next, but the patch failed to apply to
riscv/for-next. What was the base for this patchset?

Thanks,
Conor.

--tppZMEkMOmCgNS1D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMBDRgAKCRB4tDGHoIJi
0sf8AP4uEgceSAb5yQVnixLMnccgleBSjQoafJCHM7CMGvRtRQEA9nabe9G4Ghc/
Xbr6ZvQqp/XMXGdRmePLtK0/PKv2pQs=
=nSay
-----END PGP SIGNATURE-----

--tppZMEkMOmCgNS1D--
