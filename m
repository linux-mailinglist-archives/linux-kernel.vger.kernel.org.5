Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38067CE0C9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345157AbjJRPKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjJRPKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:10:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB90BA;
        Wed, 18 Oct 2023 08:10:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EE5C433C7;
        Wed, 18 Oct 2023 15:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697641843;
        bh=1taXjK2kFBaDz/Sl8rKQr3Q5UTLj/igjlkRDVwn3IZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GYhfV+NVUz+rf2hYAyKDaJLX57LmBn2TRwbXTL4fW1XL3L0eceK7S07+xSj3l9wku
         wKeGhIkzBfXZYmem0CV7AlyLD8ndqQJAgQ4FEycXKhJoatSlT+az1iLfE9v3sSsYPR
         GTLf9UG+cMmRN8DmOdxVr4k0m0y/8S/yb7asmnsSKqbQbGdHB8XQ1zv4kjK7bWPza5
         DJO+3QoEYlWR2knHJBjBJiaIRlEje41eb/kIcvn5j/wsHMw83u1RRxlKylNIXfuaQh
         jbYnzpZ28WM4h1hMyEIc52tDqWo4QYMTsGf8RTKAlpEJAKep0F+mYZusHd+hiVedaV
         gUK7n5vI1AcNw==
Date:   Thu, 19 Oct 2023 00:10:38 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the ftrace tree
Message-Id: <20231019001038.ed0fa7568e95d2409eb6a697@kernel.org>
In-Reply-To: <20231018141857.6ba1f328@canb.auug.org.au>
References: <20231018141857.6ba1f328@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 14:18:57 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> The following commits are also in the mm tree as a different commit
> (but the same patch):
> 
>   2db949178eca ("fs/proc: Add boot loader arguments as comment to /proc/bootconfig")
> 
> This is commit
> 
>   d120336bf502 ("fs/proc: add boot loader arguments as comment to /proc/bootconfig")

Hmm, sorry, I picked this patch on my bootconfig/for-next branch because
it depends on the bootconfig feature.

Thank you,

> 
> in the mm tree.
> 
> -- 
> Cheers,
> Stephen Rothwell


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
