Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C905A7CACC4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbjJPPBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbjJPPA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:00:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3639012B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:00:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C2CC433C7;
        Mon, 16 Oct 2023 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468453;
        bh=0GLvmKMndiyVt2ULVPwCbqdYlF8TzgXDxAHUw0Tml34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rS2G571HfKSELOJ65cQHDl05C83C7XrPtjD2iGcnZJQiCCAXXmXVv4RLjJ3Dj2XV/
         FHHkasnnjelj+h0Muc4UED112XsdR8cbC7dOdmur6L4smOq8s3WK1+g5o3qn8o5aX0
         XfP59iKl99MUMv/3XQmvYIBLxwSu80CphnkBzbUY=
Date:   Mon, 16 Oct 2023 16:57:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: emxx_udc: Remove unnecessary parentheses around
 condition tests
Message-ID: <2023101658-unmoral-survival-25cf@gregkh>
References: <ZS0f+xaaLmLpKv2a@gilbert-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS0f+xaaLmLpKv2a@gilbert-PC>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 12:35:23PM +0100, Gilbert Adikankwu wrote:
> Fix 47 warnings detected by checkpatch.pl about unnecessary parenthesis
> around condition tests.

And as I have stated numerous times in the past, they are not
"unnecessary" at all, and provide a valuable hint to the developer as to
what is the ordering involved.

So you can ignore this checkpatch warning please, it's not valid as far
as I'm concerned for the subsystems that I maintain in the kernel.

sorry,

greg k-h
