Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AC875E5C2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 01:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjGWXrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 19:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGWXr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 19:47:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F26CE61;
        Sun, 23 Jul 2023 16:47:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAEDB60EEA;
        Sun, 23 Jul 2023 23:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BA4C433C8;
        Sun, 23 Jul 2023 23:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690156048;
        bh=NLXIE/01ttoXz5b+BLWNfveZhjvzyf28j458rQY1fi4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pyRTB8SE9TtEsdd9+XjtvZZNWw80/QW6s9uRRehWVTwzK+a9ufiHqAbeQ5HBR1acD
         y3ZEU9wIV9c68W+k1FVcM7bPscou3KlENSXtHOqALUVZPUQ2+tr4i+xvcGuGivTC2c
         nqxbVu41M/I7HV1S5YWvXSmRovHTRjb8X7cRf3yVyBAB64m0KSBj56eYmDSb1fJHTU
         4OwAg5ppThhLppUpxFUnl8pwWn6HN5iWN/RqtXR1mI3AirNwRpS9hHA8L2H3L1q6zS
         LqVtf+ty/eH34A5rlfq6TtNdOyyGjOwKJO/r2YjTZSuRzQ3G+IdWmnDyVdyTmFdjju
         T/fVanGmPkv9A==
Message-ID: <448fd63412c1810abb72cee5e75b1fba56b1811e.camel@kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the file-locks
 tree
From:   Jeff Layton <jlayton@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Sun, 23 Jul 2023 19:47:26 -0400
In-Reply-To: <20230724084557.7ad2f3b4@canb.auug.org.au>
References: <20230724084557.7ad2f3b4@canb.auug.org.au>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-24 at 08:45 +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Commit
>=20
>   f9d742d5b7e8 ("fs/locks: Fix typo")
>=20
> is missing a Signed-off-by from its committer.
>=20

Thanks. That should be fixed now.
--=20
Jeff Layton <jlayton@kernel.org>
