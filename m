Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4167CE0E9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345256AbjJRPOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbjJRPNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:13:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E683EA;
        Wed, 18 Oct 2023 08:13:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA070C433C8;
        Wed, 18 Oct 2023 15:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697642030;
        bh=Rn5ZY3cxY/j1OTIpp2TrL+TBhZ3o5KCwQERM+GGg6S0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u/fgA1LyLVi7hRoLvKfisDGRlK5EtS/jM9+z2KdMuKUFjyMP1s4/OPEGUurjSwdmE
         m2EqxE1RG92VKuV098YJPXx5eShwXJgi9w+4cL8pyKoty3UTIYVE6Eg1Q6OkDYV+HB
         mz9lwHqlPO2MmbOiGe0lm3TNUDJuQ3BTLimIKsKE=
Date:   Wed, 18 Oct 2023 08:13:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the ftrace tree
Message-Id: <20231018081349.b5762f6f2c362fa8f84df5d2@linux-foundation.org>
In-Reply-To: <20231019001038.ed0fa7568e95d2409eb6a697@kernel.org>
References: <20231018141857.6ba1f328@canb.auug.org.au>
        <20231019001038.ed0fa7568e95d2409eb6a697@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 00:10:38 +0900 Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Wed, 18 Oct 2023 14:18:57 +1100
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi all,
> > 
> > The following commits are also in the mm tree as a different commit
> > (but the same patch):
> > 
> >   2db949178eca ("fs/proc: Add boot loader arguments as comment to /proc/bootconfig")
> > 
> > This is commit
> > 
> >   d120336bf502 ("fs/proc: add boot loader arguments as comment to /proc/bootconfig")
> 
> Hmm, sorry, I picked this patch on my bootconfig/for-next branch because
> it depends on the bootconfig feature.
> 

I dropped the copy from mm.git.
