Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23528127C0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjLNGLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjLNGLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:11:10 -0500
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD2F4B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:11:15 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3BE6B0O2018424;
        Thu, 14 Dec 2023 07:11:00 +0100
Date:   Thu, 14 Dec 2023 07:11:00 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     users@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PSA: final vger mailing list migration: Thu, Dec 14, 11AM PST
 (1900 UTC)
Message-ID: <20231214061100.GC18223@1wt.eu>
References: <20231212-unselfish-real-myna-67e444@lemur>
 <20231213052055.GA14113@1wt.eu>
 <20231213-gregarious-vole-of-luxury-42f22c@meerkat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213-gregarious-vole-of-luxury-42f22c@meerkat>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 10:19:19AM -0500, Konstantin Ryabitsev wrote:
> On Wed, Dec 13, 2023 at 06:20:55AM +0100, Willy Tarreau wrote:
> > On Tue, Dec 12, 2023 at 04:36:28PM -0500, Konstantin Ryabitsev wrote:
> > (...)
> > > # Questions, comments?
> > > 
> > > If you have any questions or concerns, please reply to this message.
> >  
> > Thanks for this update. I'm having a no-delay rule on my SMTP server
> > for a few well-known friendly senders whom I don't want to inflict
> > the SMTP banner delay. Vger is on it the list. Which host will send
> > messages now ? subspace.kernel.org or any other ? 
> 
> You can check the output of:
> 
>     dig -t txt _listspf.kernel.org
> 
> On our end, we use postwhite for similar purposes, which allows us to just add
> domains and have it automatically generate the list of exceptions via
> published spf records:
> 
> https://github.com/stevejenkins/postwhite

Looks like what I needed, perfect, thanks Konstantin!

Willy
