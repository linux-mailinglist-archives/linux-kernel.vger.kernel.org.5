Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0353F779552
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjHKQzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjHKQzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:55:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCF52D7D;
        Fri, 11 Aug 2023 09:55:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FBB567765;
        Fri, 11 Aug 2023 16:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6AEC433C8;
        Fri, 11 Aug 2023 16:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691772909;
        bh=A/Y0gXKWfd4FvHyH1R3kRbDfa2sVb+Y8DGDKbEQm4yo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=I1hRup5h29C6s2CxhN8PvrLCzgLhLQF/ZiR7/r+MdQIre2EpuVK6O5CoJgNRlcH6V
         zj1ZROplgEbdR8XdG+611YXosP8GI8POKoqOfmqRxi7BAwsSDO4UPRoHZqJCo6ZMNy
         H7iAJH6Tnv8MdqcCcuEKbR5moSf2S/a7nzsonSGUgyvPIsd5xxVfk5bZznH/0fgO1D
         BLNyNv5qTVcu3FaE7dpWSX78kvrjV6GpuBitT2KnClIvrA3/h8g5CWDH7SN4Hx/gin
         s6xjaSgpVyU/xOhQnprf8Zt4jMqgMwvmwjNvu60adJdOnzzkPQJx13MsPTsKd7P/RE
         RyaghYa7eI3Zw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1C5B3CE0593; Fri, 11 Aug 2023 09:55:09 -0700 (PDT)
Date:   Fri, 11 Aug 2023 09:55:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Wei Zhang <zhangweilst@gmail.com>, corbet@lwn.net,
        rostedt@goodmis.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: RCU: fix section numbers after adding
 Section 7 in whatisRCU.rst
Message-ID: <275d00fb-8302-4a32-9d5a-754440f94463@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230808155811.550575-1-zhangweilst@gmail.com>
 <aac7b4bf-e961-6d3f-a4d3-01d56a19613d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aac7b4bf-e961-6d3f-a4d3-01d56a19613d@infradead.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:54:48PM -0700, Randy Dunlap wrote:
> 
> 
> On 8/8/23 08:58, Wei Zhang wrote:
> > Signed-off-by: Wei Zhang <zhangweilst@gmail.com>
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Thanks.

Queued and pushed, thank you both!

							Thanx, Paul

> > ---
> >  Documentation/RCU/whatisRCU.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> > index e488c8e557a9..60ce02475142 100644
> > --- a/Documentation/RCU/whatisRCU.rst
> > +++ b/Documentation/RCU/whatisRCU.rst
> > @@ -59,8 +59,8 @@ experiment with should focus on Section 2.  People who prefer to start
> >  with example uses should focus on Sections 3 and 4.  People who need to
> >  understand the RCU implementation should focus on Section 5, then dive
> >  into the kernel source code.  People who reason best by analogy should
> > -focus on Section 6.  Section 7 serves as an index to the docbook API
> > -documentation, and Section 8 is the traditional answer key.
> > +focus on Section 6 and 7.  Section 8 serves as an index to the docbook
> > +API documentation, and Section 9 is the traditional answer key.
> >  
> >  So, start with the section that makes the most sense to you and your
> >  preferred method of learning.  If you need to know everything about
> > 
> > base-commit: 14f9643dc90adea074a0ffb7a17d337eafc6a5cc
> 
> -- 
> ~Randy
