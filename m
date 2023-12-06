Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C1B806679
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 06:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjLFFVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 00:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjLFFVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 00:21:42 -0500
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C3F188
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 21:21:48 -0800 (PST)
Date:   Wed, 6 Dec 2023 00:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701840105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r3uwpE6nH1ZY3NnV+4RJaHdhMr8NRwdTOin5q+eq/aQ=;
        b=h6ZQ9lbdFCxH6KChv8hEWSc9Yr2NnPds8VUr2rbGI7dL7tdsRhwcF8Ayi4bvOoDy/zL+g4
        JCFS5yFWReaju4Fou/43kidkddeNPny2s6uzt8HNZeWqL+H8YozsF72xRRkv9xOCTXp+V2
        lln3skwBHbkKJHxNkcX8ScKS93zjIDw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the vfs tree
Message-ID: <20231206052142.oreb4sczrvcbm26a@moria.home.lan>
References: <20231206133842.104276c7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206133842.104276c7@canb.auug.org.au>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 01:38:42PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the bcachefs tree as different
> commits (but the same patches):
> 
>   bbe6a7c899e7 ("bch2_ioctl_subvolume_destroy(): fix locking")
>   74d016ecc1a7 ("new helper: user_path_locked_at()")
> 
> These are commits
> 
>   b3057fdbaa42 ("bch2_ioctl_subvolume_destroy(): fix locking")
>   6d93d94d56e4 ("new helper: user_path_locked_at()")
> 
> in the bcachefs tree.

Dropped from mine
