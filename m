Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2D17BD9D3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346313AbjJILa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjJILaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:30:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802E1FF;
        Mon,  9 Oct 2023 04:29:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC5AC433C8;
        Mon,  9 Oct 2023 11:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696850994;
        bh=WS8wXRLrpGq773+gR2evuZFOQs5orun7igEot2rS1qE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Y7oP1hw/3WbXD3I+lUGI0jH5Xj33L5tBzhtpKgqAytZcaixlspLt0IXXBtIh4NRH
         DcMci+F0hv4nZlgPLVzVPtQTTqUA7DyfTttKioG/8uB0GDtcCxVVtpJknAX8s9kKY/
         L2Nuswq0hmLBAsE0+PmkTu4XyYCgqPqp5tcr2OZc=
Date:   Mon, 9 Oct 2023 13:29:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     fw@strlen.de, stable-commits@vger.kernel.org
Subject: Re: Patch "netfilter: nf_tables: fix false-positive lockdep splat"
 has been added to the 5.10-stable tree
Message-ID: <2023100937-gonad-kisser-3aa1@gregkh>
References: <2023100935-paving-evade-70f4@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023100935-paving-evade-70f4@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 12:55:35PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     netfilter: nf_tables: fix false-positive lockdep splat
> 
> to the 5.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      netfilter-nf_tables-fix-false-positive-lockdep-splat.patch
> and it can be found in the queue-5.10 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Oops, nope, this breaks the build, now dropped.

greg k-h
