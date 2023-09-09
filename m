Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70333799872
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 15:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345937AbjIINOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 09:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjIINOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 09:14:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59B119C;
        Sat,  9 Sep 2023 06:14:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF0DC433C8;
        Sat,  9 Sep 2023 13:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694265243;
        bh=hA38vgR65ocLsNwz+QZr0r6zmYr1/A1O/SqQg8OcADg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qFpV/RxGlOErFve9XPuhZbYGWoYgzunQ/UoSnlYoBHsnkzj4egR0uVQs/UWPSilzv
         v2XiwzGrQYsVPz+DW/lvwkuGde66GQiLcxzKMR+0jA9OHClE5zIIOZP8qMr53W2G3x
         teo5Ivjit+pC6Sasu02GY20xFxYGCT79z3w+JXic=
Date:   Sat, 9 Sep 2023 14:14:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     asml.silence@gmail.com, axboe@kernel.dk,
        stable-commits@vger.kernel.org
Subject: Re: Patch "io_uring: break out of iowq iopoll on teardown" has been
 added to the 6.1-stable tree
Message-ID: <2023090949-rocky-amusing-e21e@gregkh>
References: <2023090941-dramatic-backslid-a1fd@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023090941-dramatic-backslid-a1fd@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 01:56:41PM +0100, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     io_uring: break out of iowq iopoll on teardown
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      io_uring-break-out-of-iowq-iopoll-on-teardown.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> >From 45500dc4e01c167ee063f3dcc22f51ced5b2b1e9 Mon Sep 17 00:00:00 2001

Nope, this breaks the build, now dropped.

greg k-h
