Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141727E51C7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbjKHIQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbjKHIQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:16:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29753D40;
        Wed,  8 Nov 2023 00:16:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5566EC433C7;
        Wed,  8 Nov 2023 08:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699431410;
        bh=bGuAcU9WMGmgeFSNVnWGfx6vlsMRBwdrIusgxMOEZFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YO8DmgsCIoJtEjaKQEN0snGSP3rWDEiBzHTkR44bduqdK1uxAlzICPiCaQhpFfJIs
         vAN1wcU24CMunRvK1tc/HPA84HrWGuZbGB8ggvSxAOveC3OeMp2+9IW8m6bmh6N6Gt
         mj9VTxXIKqhAgNmhUnXu8e51hvP+2Y/Os4O2UDtErnKh4U0LaWJ97x/WTW2xRqvoag
         NfhArxsL2vNwDGX8Q2ms4C0LRwtVUXi89mJYzzuoqIgXxmtJNlWmhORzb23NqTX68p
         Bi7DwpV6IKUWtbT2JMTTTq3bBDgMDPWbCVO6513NOe1f3DfocNbIbUWIHduA6KwOQW
         g/JssNavK0l4A==
Date:   Wed, 8 Nov 2023 09:16:46 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the vfs-brauner tree
Message-ID: <20231108-jagdhund-propaganda-d278124eb479@brauner>
References: <20231108080241.1922d92d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231108080241.1922d92d@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 08:02:41AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   03630940f622 ("fs: handle freezing from multiple devices")
> 
> Fixes tag
> 
>   Fixes: [1]: 288d8706abfc ("bdev: implement freeze and thaw holder operations") # no backport needed
> 
> has these problem(s):
> 
>   - No SHA1 recognised
> 
> The "[1]: " is unexpected.

Fixed, thanks!
