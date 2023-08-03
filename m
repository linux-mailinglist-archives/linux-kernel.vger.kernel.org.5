Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2899176F2F1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjHCSpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbjHCSpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AD5198A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 11:44:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40C4861E77
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 18:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E30C433C9;
        Thu,  3 Aug 2023 18:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691088197;
        bh=+viZhIzSFXfCpemsNfwE5+wg0IfMl924eGE0IoyuWgg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eL8ToXQ43LZ3UPuFsMIMhOIx9kMMIn6mWSlyLFmCUcHy26M6VLmGhfeMBAAJo71L0
         9ZoMsvZOKuFi5gj9EPcMnXYVFy4rKkuosaUlQ0R0fRn5kESKbjCKJEx3qQEt3V7CZj
         GUZ5/GNIqBySAzT+p8QT3OYc8Nau5BJVUp87NIgBH8ePc9oY0eRyu0AzpY8jOnFE3m
         0mK2loxuVaR3yCXhfxFTPP2b9Glp7TIXEb8jwB24FDnY61ITG1kFjUPMsmoRWssMLv
         bVoDhdge0u0daIL6/+bzjGUnARA6r4wbspTF5fw/7w2QMQJRc3mbl0nCTw6k9ZIvtr
         2BUGMuq98Rgpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 42575CE0AE0; Thu,  3 Aug 2023 11:43:17 -0700 (PDT)
Date:   Thu, 3 Aug 2023 11:43:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH] MAINTAINERS: nolibc: add myself as co-maintainer
Message-ID: <884b4415-2b6f-44be-aaeb-da1d9d85ea01@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230728-nolibc-maintainer-v1-1-5f13daaebf4c@weissschuh.net>
 <1f85e8c3-e07d-482f-aa90-5e6631bc7873@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f85e8c3-e07d-482f-aa90-5e6631bc7873@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 08:31:50PM +0200, Thomas Weiﬂschuh wrote:
> Hi Paul, 
> 
> On 2023-07-28 23:21:52+0200, Thomas Weiﬂschuh wrote:
> > As discussed with Willy, Paul and Shuah add myself as maintainer for
> > the nolibc subsystem.
> 
> it seems I forgot to send the nolibc maintainers update patch to you.
> 
> My bad!
> 
> Willy and me wondered if the patch could go through your tree?

It could, but why not just include it in the batch going to Shuah?
It is not all that long until the merge window opens, plus it is hard
to argue that this is a regression.

> For you convenience the link to this patch on lore (with the Ack from Willy):
> https://lore.kernel.org/lkml/20230728-nolibc-maintainer-v1-1-5f13daaebf4c@weissschuh.net/

But if public acknowledgement of your nolibc maintainership would
help:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul

> Thomas
> 
> > Link: https://lore.kernel.org/lkml/7afafb6c-9664-44a1-bc8f-d20239db1dd5@paulmck-laptop/
> > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b87fbcecd905..a67b50caea2a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14993,6 +14993,7 @@ F:	include/linux/power/bq27xxx_battery.h
> >  
> >  NOLIBC HEADER FILE
> >  M:	Willy Tarreau <w@1wt.eu>
> > +M:	Thomas Weiﬂschuh <linux@weissschuh.net>
> >  S:	Maintained
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
> >  F:	tools/include/nolibc/
> > 
> > ---
> > base-commit: f837f0a3c94882a29e38ff211a36c1c8a0f07804
> > change-id: 20230728-nolibc-maintainer-ebdd50c844ed
> > 
> > Best regards,
> > -- 
> > Thomas Weiﬂschuh <linux@weissschuh.net>
