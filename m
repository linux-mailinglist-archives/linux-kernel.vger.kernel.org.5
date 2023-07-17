Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1FF756678
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjGQOdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjGQOd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:33:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA59173A;
        Mon, 17 Jul 2023 07:33:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49C8F60F0B;
        Mon, 17 Jul 2023 14:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862B2C433C8;
        Mon, 17 Jul 2023 14:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689604366;
        bh=Yva/5MHbcy0bGydQM8nVXYxJtVAjH+L9SZPQ/I541CE=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=D5ya+EMh9TGJ9ctyqtA7kO4yD9QB2HMhVeFFSJMT4KjpvUGw3trZGZdRm0U8UuGRJ
         OGathQfjIZo6SQFol7EjO/gmWjYSvBF/0Rv7vMqUPoOjuSjjCXactfsI6HGIInvQwu
         BGyxbby0qOGThVMHl0eN+8O6MjleA1NXgyFED/pK+U7LbAt/WsEmTizgXxoLepscWx
         QWr6SYPlhCb2tWXpOSCZx+in3xiFthSF+V7NR8TXpZpdG/cQUsm4UOO9X4NnIDpyDw
         z+emPx7qTVuDdcOVVIQZbaoWZLDA69/96hpV8cPcT3KaWxi/oFICuZrJRsPzcFesDA
         i0sQWT4WrIakw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 17 Jul 2023 14:32:43 +0000
Message-Id: <CU4IRD6Z82AN.1NSKWR27ODX5I@seitikki>
Cc:     "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Lino Sanfilippo" <l.sanfilippo@kunbus.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] tpmdd changes for v6.5-rc2
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.14.0
References: <20230714181325.3351-1-jarkko@kernel.org>
 <CAHk-=wg6Gv+zbBt7RLN43KD0BaegS=SYkwaHjd_YM5BDsvS08w@mail.gmail.com>
In-Reply-To: <CAHk-=wg6Gv+zbBt7RLN43KD0BaegS=SYkwaHjd_YM5BDsvS08w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Jul 16, 2023 at 7:11 PM UTC, Linus Torvalds wrote:
> On Fri, 14 Jul 2023 at 11:14, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/jarkko/linux-tpmdd.git/ tpm=
dd-v6.5-rc2-fixed
>
> No, that still isn't a valid git repo path.
>
> This all also looks like it should have come in during the merge
> window, so I'm just going to ignore it.
>
> Feel free to send in actual fixes - not this massive update - once you
> have fixed your workflow.
>
> But don't even bother emailing me until you have actually *verified*
> what the heck you are sending me.
>
> No more broken script garbage. No more untested git pull requests that
> don't actually work.
>
>                 Linus

NP, I'll cut down the pr, and fix the issues.

BR, Jarkko
